// ignore: file_names
class UsuarioLogin {
  String? token;
  String? expiration;
  bool? authenticated;
  String? message;

  UsuarioLogin({this.token, this.expiration, this.authenticated, this.message});

  UsuarioLogin.fromJson(Map<dynamic, dynamic> json) {
    token = json['token'];
    expiration = json['expiration'];
    authenticated = json['authenticated'];
    message = json['message'];
  }

  Map<dynamic, dynamic> toJson() {
    final Map<dynamic, dynamic> data = <dynamic, dynamic>{};
    data['token'] = token;
    data['expiration'] = expiration;
    data['authenticated'] = authenticated;
    data['message'] = message;
    return data;
  }
}
