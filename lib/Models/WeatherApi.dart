import 'dart:convert';

WeatherApi weatherApiFromJson(String str) =>
    WeatherApi.fromJson(json.decode(str));

class WeatherApi {
  WeatherApi({
    required this.current,
    required this.forecasts,
    required this.city,
  });
  late final Current current;
  late final List<Forecasts> forecasts;
  late final City city;

  WeatherApi.fromJson(Map<String, dynamic> json) {
    current = Current.fromJson(json['current']);
    forecasts =
        List.from(json['forecasts']).map((e) => Forecasts.fromJson(e)).toList();
    city = City.fromJson(json['city']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['current'] = current.toJson();
    _data['forecasts'] = forecasts.map((e) => e.toJson()).toList();
    _data['city'] = city.toJson();
    return _data;
  }
}

class Current {
  Current({
    required this.coord,
    required this.weather,
    required this.base,
    required this.main,
    required this.visibility,
    required this.wind,
    required this.clouds,
    required this.dt,
    required this.sys,
    required this.timezone,
    required this.id,
    required this.name,
    required this.cod,
  });
  late final Coord coord;
  late final List<Weather> weather;
  late final String base;
  late final Main main;
  late final int visibility;
  late final Wind wind;
  late final Clouds clouds;
  late final int dt;
  late final Sys sys;
  late final int timezone;
  late final int id;
  late final String name;
  late final int cod;

  Current.fromJson(Map<String, dynamic> json) {
    coord = Coord.fromJson(json['coord']);
    weather =
        List.from(json['weather']).map((e) => Weather.fromJson(e)).toList();
    base = json['base'];
    main = Main.fromJson(json['main']);
    visibility = json['visibility'];
    wind = Wind.fromJson(json['wind']);
    clouds = Clouds.fromJson(json['clouds']);
    dt = json['dt'];
    sys = Sys.fromJson(json['sys']);
    timezone = json['timezone'];
    id = json['id'];
    name = json['name'];
    cod = json['cod'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['coord'] = coord.toJson();
    _data['weather'] = weather.map((e) => e.toJson()).toList();
    _data['base'] = base;
    _data['main'] = main.toJson();
    _data['visibility'] = visibility;
    _data['wind'] = wind.toJson();
    _data['clouds'] = clouds.toJson();
    _data['dt'] = dt;
    _data['sys'] = sys.toJson();
    _data['timezone'] = timezone;
    _data['id'] = id;
    _data['name'] = name;
    _data['cod'] = cod;
    return _data;
  }
}

class Coord {
  Coord({
    required this.lon,
    required this.lat,
  });
  late final double lon;
  late final double lat;

  Coord.fromJson(Map<String, dynamic> json) {
    if (json['lon'].runtimeType == int || json['lat'].runtimeType == int) {
      double lon_temp = json['lon'] + .0;
      double lat_temp = json['lat'] + .0;
    } else {
      lon = json['lon'];
      lat = json['lat'];
    }
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['lon'] = lon;
    _data['lat'] = lat;
    return _data;
  }
}

class Weather {
  Weather({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });
  late final int id;
  late final String main;
  late final String description;
  late final String icon;

  Weather.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    main = json['main'];
    description = json['description'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['main'] = main;
    _data['description'] = description;
    _data['icon'] = icon;
    return _data;
  }
}

class Main {
  Main({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
  });
  late final double temp;
  late final double feelsLike;
  late final double tempMin;
  late final double tempMax;
  late final int pressure;
  late final int humidity;

  Main.fromJson(Map<String, dynamic> json) {
    if (json['temp'].runtimeType == int ||
        json['temp_min'].runtimeType == int ||
        json['temp_max'].runtimeType == int ||
        json['feels_like'] == int) {
      double t = json['temp'] + .0;
      double tmi = json['temp_min'] + .0;
      double tma = json['temp_max'] + .0;
      double fl = json['feels_like'] + .0;
      temp = t;
      tempMin = tmi;
      tempMax = tma;
      feelsLike = fl;
    } else {
      temp = json['temp'];
      tempMin = json['temp_min'];
      tempMax = json['temp_max'];
      feelsLike = json['feels_like'];
    }

    pressure = json['pressure'];
    humidity = json['humidity'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['temp'] = temp;
    _data['feels_like'] = feelsLike;
    _data['temp_min'] = tempMin;
    _data['temp_max'] = tempMax;
    _data['pressure'] = pressure;
    _data['humidity'] = humidity;
    return _data;
  }
}

class Wind {
  Wind({
    required this.speed,
    required this.deg,
  });
  late final double speed;
  late final int deg;

  Wind.fromJson(Map<String, dynamic> json) {
    if (json['speed'].runtimeType == int) {
      double temp = json['speed'] + .0;
      speed = temp;
    } else {
      speed = json['speed'];
    }

    deg = json['deg'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['speed'] = speed;
    _data['deg'] = deg;
    return _data;
  }
}

class Clouds {
  Clouds({
    required this.all,
  });
  late final int all;

  Clouds.fromJson(Map<String, dynamic> json) {
    all = json['all'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['all'] = all;
    return _data;
  }
}

class Sys {
  Sys({
    required this.type,
    required this.id,
    required this.country,
    required this.sunrise,
    required this.sunset,
  });
  late final int type;
  late final int id;
  late final String country;
  late final int sunrise;
  late final int sunset;

  Sys.fromJson(Map<String, dynamic> json) {
    // print(json);
    // type = 2;
    // id = 2034555;
    // country = "TH";
    // sunrise = 1682809022;
    // sunset = 1682854401;

    if (json['pod'] != Null) {
    } else {
      type = json['type'];
      id = json['id'];
      country = json['country'];
      sunrise = json['sunrise'];
      sunset = json['sunset'];
    }
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['type'] = type;
    _data['id'] = id;
    _data['country'] = country;
    _data['sunrise'] = sunrise;
    _data['sunset'] = sunset;
    return _data;
  }
}

class Forecasts {
  Forecasts({
    required this.day,
    required this.hours,
  });
  late final String day;
  late final List<Hours> hours;

  Forecasts.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    hours = List.from(json['hours']).map((e) => Hours.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['day'] = day;
    _data['hours'] = hours.map((e) => e.toJson()).toList();
    return _data;
  }
}

class Hours {
  Hours({
    required this.forecast,
    required this.hour,
  });
  late final Forecast forecast;
  late final String hour;

  Hours.fromJson(Map<String, dynamic> json) {
    forecast = Forecast.fromJson(json['forecast']);
    hour = json['hour'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['forecast'] = forecast.toJson();
    _data['hour'] = hour;
    return _data;
  }
}

class Forecast {
  Forecast({
    required this.dt,
    required this.main,
    required this.weather,
    required this.clouds,
    required this.wind,
    required this.visibility,
    required this.pop,
    required this.sys,
    required this.dtTxt,
  });
  late final int dt;
  late final Main main;
  late final List<Weather> weather;
  late final Clouds clouds;
  late final Wind wind;
  late final int visibility;
  late final double pop;
  late final Sys sys;
  late final String dtTxt;

  Forecast.fromJson(Map<String, dynamic> json) {
    dt = json['dt'];
    main = Main.fromJson(json['main']);
    weather =
        List.from(json['weather']).map((e) => Weather.fromJson(e)).toList();
    clouds = Clouds.fromJson(json['clouds']);
    wind = Wind.fromJson(json['wind']);
    visibility = json['visibility'];
    print(json['pop']);
    if (json['pop'].runtimeType == int) {
      double temp = json['pop'] + .0;
      pop = temp;
    } else {
      pop = json['pop'];
    }

    sys = Sys.fromJson(json['sys']);
    dtTxt = json['dt_txt'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['dt'] = dt;
    _data['main'] = main.toJson();
    _data['weather'] = weather.map((e) => e.toJson()).toList();
    _data['clouds'] = clouds.toJson();
    _data['wind'] = wind.toJson();
    _data['visibility'] = visibility;
    _data['pop'] = pop;
    _data['sys'] = sys.toJson();
    _data['dt_txt'] = dtTxt;
    return _data;
  }
}

class City {
  City({
    required this.id,
    required this.name,
    required this.coord,
    required this.country,
    required this.population,
    required this.timezone,
    required this.sunrise,
    required this.sunset,
  });
  late final int id;
  late final String name;
  late final Coord coord;
  late final String country;
  late final int population;
  late final int timezone;
  late final int sunrise;
  late final int sunset;

  City.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    coord = Coord.fromJson(json['coord']);
    country = json['country'];
    population = json['population'];
    timezone = json['timezone'];
    sunrise = json['sunrise'];
    sunset = json['sunset'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['coord'] = coord.toJson();
    _data['country'] = country;
    _data['population'] = population;
    _data['timezone'] = timezone;
    _data['sunrise'] = sunrise;
    _data['sunset'] = sunset;
    return _data;
  }
}

class TypesHelper {
  static int toInt(num val) {
    try {
      if (val == null) {
        return 0;
      }
      if (val is int) {
        return val;
      } else {
        return val.toInt();
      }
    } catch (error) {
      print('Error');
      return 0;
    }
  }
}
