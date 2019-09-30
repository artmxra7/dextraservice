class Default {
  final String code;
  final String message;

  Default({this.code, this.message});

  factory Default.fromJson(Map<String, dynamic> json) {
    return Default(
      code: json['code'],
      message: json['message'],
    );
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["code"] = code;
    map["message"] = message;

    return map;
  }
}

class Register {
  final String code;
  final String message;
  final DataRegis data;

  Register({this.code, this.message, this.data});

  factory Register.fromJson(Map<String, dynamic> json) {
    return Register(
      code: json['code'],
      message: json['message'],
      data: json['data'],
//      requestId: json['data']['request_id'],
    );
  }
}

class DataRegis {
  final String requestId;

  DataRegis({this.requestId});

  factory DataRegis.fromJson(Map<String, dynamic> json) {
    return DataRegis(
      requestId: json['request_id'],
    );
  }
}
