class UserModel {
  int id;
  String username;
  String password;
  String mail;

  UserModel({this.id, this.username, this.password, this.mail});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['username'];
    password = json['password'];
    mail = json['mail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['username'] = this.username;
    data['password'] = this.password;
    data['mail'] = this.mail;
    return data;
  }
}
