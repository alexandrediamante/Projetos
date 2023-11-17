class User {
  final String login;
  final String password;

  User({required this.login, required this.password});

  Map<String, dynamic> toMap() {
    return {'login': login, 'password': password};
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(login: map['login'], password: map['password']);
  }
}
