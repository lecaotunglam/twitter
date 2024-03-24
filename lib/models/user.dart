class User {
  String? firstname;
  String? lastname;
  String? login;
  String? accessToken;
  String? refreshToken;
  int? expires;

  User({
    this.login,
    this.accessToken,
    this.refreshToken,
    this.firstname,
    this.lastname,
    this.expires,
  });
}
