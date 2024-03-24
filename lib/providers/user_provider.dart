import 'package:flutter/foundation.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:twitter/models/user.dart';

class UserProvider with ChangeNotifier, DiagnosticableTreeMixin {
  final User _user = User();

  bool isSignedIn() => _user.accessToken != null;
  //utiliser cette méthode en production
  //bool isSignedIn() => _user.accessToken != null && !hasExpired();

  String? get accessToken => _user.accessToken;
  //on considère que la propriété d'un access_token correspond à une connexion avérée
  //il faudrait vérifier sa péremption

  User get user => _user;

  //mutateur
  signIn(String login, String password) {
    if (login == "john@doe.com" && password == "azerty") {
      _user.accessToken =
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c";

      Map<String, dynamic> decodedToken = JwtDecoder.decode(_user.accessToken!);

      String name = decodedToken["name"].toString(); //"john doe"

      _user.firstname = name.split(" ")[0];
      _user.lastname = name.split(" ")[1];

      notifyListeners();
    }
  }

  //mutateur
  signOut() {
    _user.accessToken = null;
    notifyListeners();
  }

  bool hasExpired() {
    return JwtDecoder.isExpired(_user.accessToken!);
  }
}
