class LoginResponse {
  Success? success;

  LoginResponse({this.success});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    success =
        json['success'] != null ? new Success.fromJson(json['success']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.success != null) {
      data['success'] = this.success!.toJson();
    }
    return data;
  }
}

class Success {
  int? code;
  String? token;
  String? entity;
  String? message;

  Success({this.code, this.token, this.entity, this.message});

  Success.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    token = json['token'];
    entity = json['entity'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['token'] = this.token;
    data['entity'] = this.entity;
    data['message'] = this.message;
    return data;
  }
}