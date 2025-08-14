import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/controller/home_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = context.read<HomeController>();
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF74b9ff),
              Color(0xFF0984e3),
              Color(0xFF6c5ce7),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                // Header with location
                _buildHeader(),

                const SizedBox(height: 30),

                // Main weather card
                Consumer<HomeController>(
                  builder: (context, provider, child) {
                    if (provider.isLoading) {
                      return Expanded(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircularProgressIndicator(
                                color: Colors.white,
                                strokeWidth: 3,
                              ),
                              SizedBox(height: 20),
                              Text(
                                'Getting weather data...',
                                style: GoogleFonts.poppins(
                                  color: Colors.white70,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    if (provider.errorMessage.isNotEmpty) {
                      return Expanded(
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                FontAwesomeIcons.triangleExclamation,
                                color: Colors.white70,
                                size: 50,
                              ),
                              SizedBox(height: 20),
                              Text(
                                'Oops!',
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 40),
                                child: Text(
                                  provider.errorMessage,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                    color: Colors.white70,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: () => provider.refreshWeatherData(),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white.withOpacity(0.2),
                                  foregroundColor: Colors.white,
                                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                ),
                                child: Text(
                                  'Try Again',
                                  style: GoogleFonts.poppins(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    return Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            _buildMainWeatherCard(provider),
                            const SizedBox(height: 20),
                            _buildWeatherDetailsGrid(provider),
                            const SizedBox(height: 20),
                            _buildSunTimesCard(provider),
                          ],
                        ),
                      ),
                    );
                  },
                ),

                const SizedBox(height: 20),

                // Bottom navigation
                _buildBottomNavigation(controller, context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Weather',
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Today',
              style: GoogleFonts.poppins(
                color: Colors.white70,
                fontSize: 16,
              ),
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(50),
            border: Border.all(color: Colors.white.withOpacity(0.3)),
          ),
          child: Icon(
            FontAwesomeIcons.bell,
            color: Colors.white,
            size: 20,
          ),
        ),
      ],
    );
  }

  Widget _buildMainWeatherCard(provider) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(30),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withOpacity(0.3),
            Colors.white.withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          // Location
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                FontAwesomeIcons.locationDot,
                color: Colors.white,
                size: 16,
              ),
              SizedBox(width: 8),
              Text(
                '${provider.currentWeather.name ?? 'Mahdia'}, ${provider.currentWeather.sys?.country ?? 'TN'}',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),

          SizedBox(height: 20),

          // Weather icon
          Container(
            height: 120,
            width: 120,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(60),
            ),
            child: Center(
              child: Image.network(
                'http://openweathermap.org/img/wn/${provider.currentWeather.weather?[0]?.icon ?? '01d'}@2x.png',
                height: 80,
                width: 80,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    FontAwesomeIcons.sun,
                    color: Colors.white,
                    size: 50,
                  );
                },
              ),
            ),
          ),

          SizedBox(height: 15),

          // Weather description
          Text(
            provider.currentWeather.weather?[0]?.description?.toUpperCase() ?? 'CLEAR SKY',
            style: GoogleFonts.poppins(
              color: Colors.white70,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              letterSpacing: 1.5,
            ),
          ),

          SizedBox(height: 10),

          // Temperature
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${provider.currentWeather.main?.temp?.round() ?? 25}',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 72,
                  fontWeight: FontWeight.w200,
                ),
              ),
              Text(
                '°C',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),

          // Feels like temperature
          Text(
            'Feels like ${provider.currentWeather.main?.feelsLike?.round() ?? 25}°C',
            style: GoogleFonts.poppins(
              color: Colors.white70,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeatherDetailsGrid(provider) {
    return GridView.count(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 15,
      mainAxisSpacing: 15,
      childAspectRatio: 1.1,
      children: [
        _buildDetailCard(
          icon: FontAwesomeIcons.temperatureHigh,
          title: 'Max Temp',
          value: '${provider.currentWeather.main?.tempMax?.round() ?? 25}°C',
          color: Color(0xFFff7675),
        ),
        _buildDetailCard(
          icon: FontAwesomeIcons.temperatureLow,
          title: 'Min Temp',
          value: '${provider.currentWeather.main?.tempMin?.round() ?? 25}°C',
          color: Color(0xFF74b9ff),
        ),
        _buildDetailCard(
          icon: FontAwesomeIcons.droplet,
          title: 'Humidity',
          value: '${provider.currentWeather.main?.humidity ?? 76}%',
          color: Color(0xFF00b894),
        ),
        _buildDetailCard(
          icon: FontAwesomeIcons.wind,
          title: 'Wind Speed',
          value: '${provider.currentWeather.wind?.speed ?? 1.13} m/s',
          color: Color(0xFF6c5ce7),
        ),
      ],
    );
  }

  Widget _buildDetailCard({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withOpacity(0.25),
            Colors.white.withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.2),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Icon(
              icon,
              color: color,
              size: 24,
            ),
          ),
          SizedBox(height: 12),
          Text(
            title,
            style: GoogleFonts.poppins(
              color: Colors.white70,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 4),
          Text(
            value,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSunTimesCard(provider) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(25),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withOpacity(0.25),
            Colors.white.withOpacity(0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildSunTimeItem(
            icon: FontAwesomeIcons.solidSun,
            title: 'Sunrise',
            time: _formatTime(provider.currentWeather.sys?.sunrise) ?? '06:15',
            color: Color(0xFFfdcb6e),
          ),
          Container(
            height: 50,
            width: 1,
            color: Colors.white.withOpacity(0.3),
          ),
          _buildSunTimeItem(
            icon: FontAwesomeIcons.moon,
            title: 'Sunset',
            time: _formatTime(provider.currentWeather.sys?.sunset) ?? '19:45',
            color: Color(0xFFe17055),
          ),
        ],
      ),
    );
  }

  Widget _buildSunTimeItem({
    required IconData icon,
    required String title,
    required String time,
    required Color color,
  }) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.2),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Icon(
            icon,
            color: color,
            size: 20,
          ),
        ),
        SizedBox(height: 8),
        Text(
          title,
          style: GoogleFonts.poppins(
            color: Colors.white70,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: 4),
        Text(
          time,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildBottomNavigation(controller, context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withValues(alpha: 0.3),
            Colors.white.withValues(alpha: 0.1),
          ],
        ),
        borderRadius: BorderRadius.circular(35),
        border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildNavItem(
            icon: FontAwesomeIcons.locationDot,
            isActive: true,
            onTap: () async {
              await controller.refreshWeatherData();
            },
          ),
          _buildNavItem(
            icon: FontAwesomeIcons.magnifyingGlass,
            onTap: () => _showSearchDialog(context, controller),
          ),
          _buildNavItem(
            icon: FontAwesomeIcons.chartLine,
            onTap: () {
              // TODO: Navigate to forecast/charts page
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Forecast view coming soon!'),
                  backgroundColor: Colors.blue,
                  duration: Duration(seconds: 2),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required VoidCallback onTap,
    bool isActive = false,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(25),
      child: Container(
        padding: EdgeInsets.all(15),
        decoration: isActive ? BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(25),
        ) : null,
        child: Icon(
          icon,
          color: Colors.white,
          size: 24,
        ),
      ),
    );
  }

  void _showSearchDialog(BuildContext context, HomeController controller) {
    TextEditingController searchController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFF74b9ff).withOpacity(0.95),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Text(
            'Search City',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: TextField(
            controller: searchController,
            style: GoogleFonts.poppins(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Enter city name...',
              hintStyle: GoogleFonts.poppins(color: Colors.white70),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white70),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
            ),
            autofocus: true,
            onSubmitted: (value) {
              if (value.trim().isNotEmpty) {
                Navigator.of(context).pop();
                controller.fetchWeatherForCity(value.trim());
              }
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Cancel',
                style: GoogleFonts.poppins(color: Colors.white70),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (searchController.text.trim().isNotEmpty) {
                  Navigator.of(context).pop();
                  controller.fetchWeatherForCity(searchController.text.trim());
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Color(0xFF74b9ff),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Search',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  String? _formatTime(int? timestamp) {
    if (timestamp == null) return null;
    final dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
  }
}