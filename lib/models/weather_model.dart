class WeatherModel {
  Coord? coord;
  List<Weather>? weather;
  String? base;
  Main? main;
  int? visibility;
  Wind? wind;
  Clouds? clouds;
  int? dt;
  Sys? sys;
  int? timezone;
  int? id;
  String? name;
  int? cod;

  WeatherModel({
    this.coord,
    this.weather,
    this.base,
    this.main,
    this.visibility,
    this.wind,
    this.clouds,
    this.dt,
    this.sys,
    this.timezone,
    this.id,
    this.name,
    this.cod,
  });

  WeatherModel.fromJson(Map<String, dynamic> json) {
    try {
      coord = json['coord'] != null ? Coord.fromJson(json['coord']) : null;
      if (json['weather'] != null) {
        weather = <Weather>[];
        json['weather'].forEach((v) {
          weather!.add(Weather.fromJson(v));
        });
      }
      base = json['base'];
      main = json['main'] != null ? Main.fromJson(json['main']) : null;
      visibility = json['visibility'];
      wind = json['wind'] != null ? Wind.fromJson(json['wind']) : null;
      clouds = json['clouds'] != null ? Clouds.fromJson(json['clouds']) : null;
      dt = json['dt'];
      sys = json['sys'] != null ? Sys.fromJson(json['sys']) : null;
      timezone = json['timezone'];
      id = json['id'];
      name = json['name'];
      cod = json['cod'];
    } catch (e) {
      print('Error parsing WeatherModel: $e');
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (coord != null) {
      data['coord'] = coord!.toJson();
    }
    if (weather != null) {
      data['weather'] = weather!.map((v) => v.toJson()).toList();
    }
    data['base'] = base;
    if (main != null) {
      data['main'] = main!.toJson();
    }
    data['visibility'] = visibility;
    if (wind != null) {
      data['wind'] = wind!.toJson();
    }
    if (clouds != null) {
      data['clouds'] = clouds!.toJson();
    }
    data['dt'] = dt;
    if (sys != null) {
      data['sys'] = sys!.toJson();
    }
    data['timezone'] = timezone;
    data['id'] = id;
    data['name'] = name;
    data['cod'] = cod;
    return data;
  }
}

class Coord {
  double? lon;
  double? lat;

  Coord({this.lon, this.lat});

  Coord.fromJson(Map<String, dynamic> json) {
    try {
      lon = _toDouble(json['lon']);
      lat = _toDouble(json['lat']);
    } catch (e) {
      print('Error parsing Coord: $e');
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lon'] = lon;
    data['lat'] = lat;
    return data;
  }
}

class Weather {
  int? id;
  String? main;
  String? description;
  String? icon;

  Weather({
    this.id,
    this.main,
    this.description,
    this.icon,
  });

  Weather.fromJson(Map<String, dynamic> json) {
    try {
      id = json['id'];
      main = json['main'];
      description = json['description'];
      icon = json['icon'];
    } catch (e) {
      print('Error parsing Weather: $e');
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['main'] = main;
    data['description'] = description;
    data['icon'] = icon;
    return data;
  }
}

class Main {
  double? temp;
  double? feelsLike;
  double? tempMin;
  double? tempMax;
  int? pressure;
  int? humidity;
  int? seaLevel;
  int? grndLevel;

  Main({
    this.temp,
    this.feelsLike,
    this.tempMin,
    this.tempMax,
    this.pressure,
    this.humidity,
    this.seaLevel,
    this.grndLevel,
  });

  Main.fromJson(Map<String, dynamic> json) {
    try {
      temp = _toDouble(json['temp']);
      feelsLike = _toDouble(json['feels_like']);
      tempMin = _toDouble(json['temp_min']);
      tempMax = _toDouble(json['temp_max']);
      pressure = json['pressure'];
      humidity = json['humidity'];
      seaLevel = json['sea_level'];
      grndLevel = json['grnd_level'];
    } catch (e) {
      print('Error parsing Main: $e');
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['temp'] = temp;
    data['feels_like'] = feelsLike;
    data['temp_min'] = tempMin;
    data['temp_max'] = tempMax;
    data['pressure'] = pressure;
    data['humidity'] = humidity;
    data['sea_level'] = seaLevel;
    data['grnd_level'] = grndLevel;
    return data;
  }
}

class Wind {
  double? speed;
  int? deg;
  double? gust;

  Wind({this.speed, this.deg, this.gust});

  Wind.fromJson(Map<String, dynamic> json) {
    try {
      speed = _toDouble(json['speed']);
      deg = json['deg'];
      gust = _toDouble(json['gust']);
    } catch (e) {
      print('Error parsing Wind: $e');
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['speed'] = speed;
    data['deg'] = deg;
    data['gust'] = gust;
    return data;
  }
}

class Clouds {
  int? all;

  Clouds({this.all});

  Clouds.fromJson(Map<String, dynamic> json) {
    try {
      all = json['all'];
    } catch (e) {
      print('Error parsing Clouds: $e');
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['all'] = all;
    return data;
  }
}

class Sys {
  int? type;
  int? id;
  String? country;
  int? sunrise;
  int? sunset;

  Sys({
    this.type,
    this.id,
    this.country,
    this.sunrise,
    this.sunset,
  });

  Sys.fromJson(Map<String, dynamic> json) {
    try {
      type = json['type'];
      id = json['id'];
      country = json['country'];
      sunrise = json['sunrise'];
      sunset = json['sunset'];
    } catch (e) {
      print('Error parsing Sys: $e');
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['id'] = id;
    data['country'] = country;
    data['sunrise'] = sunrise;
    data['sunset'] = sunset;
    return data;
  }
}

// Helper function to safely convert numeric values to double
double? _toDouble(dynamic value) {
  if (value == null) return null;
  if (value is double) return value;
  if (value is int) return value.toDouble();
  if (value is String) {
    try {
      return double.parse(value);
    } catch (e) {
      print('Error converting string to double: $value');
      return null;
    }
  }
  return null;
}