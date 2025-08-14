import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

import '../models/weather_model.dart';

class HomeController with ChangeNotifier {
  bool _isLoading = true;
  bool get isLoading => _isLoading;
  bool get isLoad => _isLoading;

  String _currentLocationName = '';
  String get locationName => _currentLocationName;

  String _errorMessage = '';
  String get errorMessage => _errorMessage;

  Position? _currentPosition;
  Position? get currentPosition => _currentPosition;

  static const apiKey = '1781491c5996e28da369536bd1c883b2';
  WeatherModel currentWeather = WeatherModel();

  HomeController() {
    initializeWeatherData();
  }

  /// Initialize weather data when controller is created
  Future<void> initializeWeatherData() async {
    await loadWeatherState();
  }

  /// Set loading state and notify listeners
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  /// Set error message and notify listeners
  void _setError(String error) {
    _errorMessage = error;
    notifyListeners();
  }

  /// Clear error message
  void _clearError() {
    _errorMessage = '';
  }

  /// Get current location coordinates and address
  Future<String> getCurrentLocation() async {
    try {
      _setLoading(true);
      _clearError();

      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _setError("Location services are disabled. Please enable them in settings.");
        _setLoading(false);
        return '';
      }

      // Check location permissions
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          _setError("Location permission denied. Please grant location access.");
          _setLoading(false);
          return '';
        }
      }

      if (permission == LocationPermission.deniedForever) {
        _setError("Location permission permanently denied. Please enable in app settings.");
        _setLoading(false);
        return '';
      }

      // Get current position with timeout
      _currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: Duration(seconds: 15),
      );

      // Get address from coordinates
      List<Placemark> placemarks = await placemarkFromCoordinates(
        _currentPosition!.latitude,
        _currentPosition!.longitude,
      );

      String address = "Unknown Location";
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        address = '${place.locality ?? place.subAdministrativeArea ?? 'Unknown'}, ${place.country ?? 'Unknown'}';
      }

      _currentLocationName = address;
      _setLoading(false);
      return address;
    } catch (e) {
      _setError("Failed to get location: ${e.toString()}");
      _setLoading(false);
      debugPrint("Location error: $e");
      return '';
    }
  }

  /// Load weather data for current location
  Future<void> loadWeatherState() async {
    try {
      _setLoading(true);
      _clearError();
      // Get current location if not available
      if (_currentLocationName.isEmpty) {
        await getCurrentLocation();
      }

      // If still no location, try with coordinates
      if (_currentLocationName.isEmpty && _currentPosition != null) {
        await _fetchWeatherByCoordinates(_currentPosition!.latitude, _currentPosition!.longitude);
      } else if (_currentLocationName.isNotEmpty) {
        await _fetchWeatherByCity(_currentLocationName);
      } else {
        // Fallback to a default location
        await _fetchWeatherByCity("Mahdia, TN");
      }

      _setLoading(false);
    } catch (e) {
      _setError("Failed to load weather data: ${e.toString()}");
      _setLoading(false);
      debugPrint("Weather loading error: $e");
    }
  }

  /// Fetch weather data by city name
  Future<void> _fetchWeatherByCity(String cityName) async {
    try {
      var url = Uri.https('api.openweathermap.org', '/data/2.5/weather', {
        'q': cityName,
        'appid': apiKey,
        'units': 'metric',
      });

      var response = await http.get(url);
      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        // Safely parse the JSON with error handling
        currentWeather = WeatherModel.fromJson(jsonData as Map<String, dynamic>);
        _clearError();
      } else if (response.statusCode == 404) {
        throw Exception('City not found. Please check the city name and try again.');
      } else if (response.statusCode == 401) {
        throw Exception('Invalid API key. Please check your OpenWeatherMap API key.');
      } else {
        throw Exception('Failed to load weather data. Error: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error fetching weather by city: $e');
      rethrow;
    }
  }

  /// Fetch weather data by coordinates
  Future<void> _fetchWeatherByCoordinates(double lat, double lon) async {
    try {
      var url = Uri.https('api.openweathermap.org', '/data/2.5/weather', {
        'lat': lat.toString(),
        'lon': lon.toString(),
        'appid': apiKey,
        'units': 'metric', // Get temperature in Celsius
      });

      var response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        // Add debug logging
        debugPrint('API Response: ${response.body}');

        // Safely parse the JSON with error handling
        currentWeather = WeatherModel.fromJson(jsonData as Map<String, dynamic>);
        _clearError();
      } else {
        throw Exception('Failed to load weather data for coordinates. Error: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error fetching weather by coordinates: $e');
      rethrow;
    }
  }

  /// Fetch weather for a specific city (for search functionality)
  Future<void> fetchWeatherForCity(String cityName) async {
    try {
      _setLoading(true);
      _clearError();
      _currentLocationName = cityName;
      await _fetchWeatherByCity(cityName);
      _setLoading(false);
    } catch (e) {
      _setError("City not found or failed to load weather data");
      _setLoading(false);
      debugPrint("City weather error: $e");
    }
  }

  /// Refresh weather data
  Future<void> refreshWeatherData() async {
    await loadWeatherState();
  }

  /// Get formatted temperature with unit
  String getTemperatureString(double? temp) {
    if (temp == null) return '--°C';
    return '${temp.round()}°C';
  }

  /// Get weather condition emoji
  String getWeatherEmoji(String? weatherMain) {
    switch (weatherMain?.toLowerCase()) {
      case 'clear':
        return '☀️';
      case 'clouds':
        return '☁️';
      case 'rain':
        return '🌧️';
      case 'drizzle':
        return '🌦️';
      case 'thunderstorm':
        return '⛈️';
      case 'snow':
        return '❄️';
      case 'mist':
      case 'fog':
        return '🌫️';
      default:
        return '🌤️';
    }
  }

  /// Check if weather data is available
  bool get hasWeatherData => currentWeather.main != null;

  /// Get formatted wind speed
  String getWindSpeedString(double? speed) {
    if (speed == null) return '-- m/s';
    return '${speed.toStringAsFixed(1)} m/s';
  }

  /// Get formatted humidity
  String getHumidityString(int? humidity) {
    if (humidity == null) return '--%';
    return '$humidity%';
  }
}