import 'dart:convert';

air_quaity AirqualityFromJson(String str) => air_quaity.fromJson(json.decode(str));
class air_quaity {
  String? status;
  Data? data;

  air_quaity({this.status, this.data});

  air_quaity.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? aqi;
  int? idx;
  List<Attributions>? attributions;
  City? city;
  String? dominentpol;
  Iaqi? iaqi;
  Time? time;
  Forecast? forecast;
  Debug? debug;

  Data(
      {this.aqi,
      this.idx,
      this.attributions,
      this.city,
      this.dominentpol,
      this.iaqi,
      this.time,
      this.forecast,
      this.debug});

  Data.fromJson(Map<String, dynamic> json) {
    aqi = json['aqi'];
    idx = json['idx'];
    if (json['attributions'] != null) {
      attributions = <Attributions>[];
      json['attributions'].forEach((v) {
        attributions!.add(new Attributions.fromJson(v));
      });
    }
    city = json['city'] != null ? new City.fromJson(json['city']) : null;
    dominentpol = json['dominentpol'];
    iaqi = json['iaqi'] != null ? new Iaqi.fromJson(json['iaqi']) : null;
    time = json['time'] != null ? new Time.fromJson(json['time']) : null;
    forecast = json['forecast'] != null
        ? new Forecast.fromJson(json['forecast'])
        : null;
    debug = json['debug'] != null ? new Debug.fromJson(json['debug']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['aqi'] = this.aqi;
    data['idx'] = this.idx;
    if (this.attributions != null) {
      data['attributions'] = this.attributions!.map((v) => v.toJson()).toList();
    }
    if (this.city != null) {
      data['city'] = this.city!.toJson();
    }
    data['dominentpol'] = this.dominentpol;
    if (this.iaqi != null) {
      data['iaqi'] = this.iaqi!.toJson();
    }
    if (this.time != null) {
      data['time'] = this.time!.toJson();
    }
    if (this.forecast != null) {
      data['forecast'] = this.forecast!.toJson();
    }
    if (this.debug != null) {
      data['debug'] = this.debug!.toJson();
    }
    return data;
  }
}

class Attributions {
  String? url;
  String? name;
  String? logo;

  Attributions({this.url, this.name, this.logo});

  Attributions.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    name = json['name'];
    logo = json['logo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['name'] = this.name;
    data['logo'] = this.logo;
    return data;
  }
}

class City {
  List<double>? geo;
  String? name;
  String? url;
  String? location;

  City({this.geo, this.name, this.url, this.location});

  City.fromJson(Map<String, dynamic> json) {
    geo = json['geo'].cast<double>();
    name = json['name'];
    url = json['url'];
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['geo'] = this.geo;
    data['name'] = this.name;
    data['url'] = this.url;
    data['location'] = this.location;
    return data;
  }
}

class Iaqi {
  H? h;
  No2? no2;
  No2? o3;
  H? p;
  O3? pm10;
  O3? pm25;
  H? t;
  No2? w;
  H? wg;

  Iaqi(
      {this.h,
      this.no2,
      this.o3,
      this.p,
      this.pm10,
      this.pm25,
      this.t,
      this.w,
      this.wg});

  Iaqi.fromJson(Map<String, dynamic> json) {
    h = json['h'] != null ? new H.fromJson(json['h']) : null;
    no2 = json['no2'] != null ? new No2.fromJson(json['no2']) : null;
    o3 = json['o3'] != null ? new No2.fromJson(json['o3']) : null;
    p = json['p'] != null ? new H.fromJson(json['p']) : null;
    pm10 = json['pm10'] != null ? new O3.fromJson(json['pm10']) : null;
    pm25 = json['pm25'] != null ? new O3.fromJson(json['pm25']) : null;
    t = json['t'] != null ? new H.fromJson(json['t']) : null;
    w = json['w'] != null ? new No2.fromJson(json['w']) : null;
    wg = json['wg'] != null ? new H.fromJson(json['wg']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.h != null) {
      data['h'] = this.h!.toJson();
    }
    if (this.no2 != null) {
      data['no2'] = this.no2!.toJson();
    }
    if (this.o3 != null) {
      data['o3'] = this.o3!.toJson();
    }
    if (this.p != null) {
      data['p'] = this.p!.toJson();
    }
    if (this.pm10 != null) {
      data['pm10'] = this.pm10!.toJson();
    }
    if (this.pm25 != null) {
      data['pm25'] = this.pm25!.toJson();
    }
    if (this.t != null) {
      data['t'] = this.t!.toJson();
    }
    if (this.w != null) {
      data['w'] = this.w!.toJson();
    }
    if (this.wg != null) {
      data['wg'] = this.wg!.toJson();
    }
    return data;
  }
}

class H {
  int? v;

  H({this.v});

  H.fromJson(Map<String, dynamic> json) {
    v = json['v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['v'] = this.v;
    return data;
  }
}

class No2 {
  double? v;

  No2({this.v});

  No2.fromJson(Map<String, dynamic> json) {
    v = json['v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['v'] = this.v;
    return data;
  }
}

class Time {
  String? s;
  String? tz;
  int? v;
  String? iso;

  Time({this.s, this.tz, this.v, this.iso});

  Time.fromJson(Map<String, dynamic> json) {
    s = json['s'];
    tz = json['tz'];
    v = json['v'];
    iso = json['iso'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['s'] = this.s;
    data['tz'] = this.tz;
    data['v'] = this.v;
    data['iso'] = this.iso;
    return data;
  }
}

class Forecast {
  Daily? daily;

  Forecast({this.daily});

  Forecast.fromJson(Map<String, dynamic> json) {
    daily = json['daily'] != null ? new Daily.fromJson(json['daily']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.daily != null) {
      data['daily'] = this.daily!.toJson();
    }
    return data;
  }
}

class Daily {
  List<O3>? o3;
  List<O3>? pm10;
  List<O3>? pm25;

  Daily({this.o3, this.pm10, this.pm25});

  Daily.fromJson(Map<String, dynamic> json) {
    if (json['o3'] != null) {
      o3 = <O3>[];
      json['o3'].forEach((v) {
        o3!.add(new O3.fromJson(v));
      });
    }
    if (json['pm10'] != null) {
      pm10 = <O3>[];
      json['pm10'].forEach((v) {
        pm10!.add(new O3.fromJson(v));
      });
    }
    if (json['pm25'] != null) {
      pm25 = <O3>[];
      json['pm25'].forEach((v) {
        pm25!.add(new O3.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.o3 != null) {
      data['o3'] = this.o3!.map((v) => v.toJson()).toList();
    }
    if (this.pm10 != null) {
      data['pm10'] = this.pm10!.map((v) => v.toJson()).toList();
    }
    if (this.pm25 != null) {
      data['pm25'] = this.pm25!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class O3 {
  int? avg;
  String? day;
  int? max;
  int? min;

  O3({this.avg, this.day, this.max, this.min});

  O3.fromJson(Map<String, dynamic> json) {
    avg = json['avg'];
    day = json['day'];
    max = json['max'];
    min = json['min'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['avg'] = this.avg;
    data['day'] = this.day;
    data['max'] = this.max;
    data['min'] = this.min;
    return data;
  }
}

class Debug {
  String? sync;

  Debug({this.sync});

  Debug.fromJson(Map<String, dynamic> json) {
    sync = json['sync'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sync'] = this.sync;
    return data;
  }
}
