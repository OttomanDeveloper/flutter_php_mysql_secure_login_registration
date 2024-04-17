import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:login_tutorial/services/encrypt_decrypt.dart';

const site = "Your API"; // Paste Your API Here
const api = "$site/manage.php";
const profile = "$site/userdatadisplay.php";

class DatabaseRequest {
  final String fullName;
  final String password;
  final String username;
  DatabaseRequest(
      {required this.fullName, required this.password, required this.username});

  Future<String> request() async {
    try {
      final response = await http.post(Uri.parse(api), body: {
        'fullname': Security(text: fullName).encrypt(),
        'username': Security(text: username).encrypt(),
        'password': Security(text: password).encrypt()
      });
      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        print('result : $result');
        return result;
      } else {
        return 'Server Error';
      }
    } catch (e) {
      return 'App Error';
    }
  }
}

class GetProfile {
  final String username;

  GetProfile({required this.username});

  Future<dynamic> getProfile() async {
    try {
      final response = await http.post(Uri.parse(profile), body: {
        'username': Security(text: username).encrypt(),
      });

      if (response.statusCode == 200) {
        final result = json.decode(response.body);
        print(result);
        return result;
      } else {
        return 'Server Error';
      }
    } catch (e) {
      return 'App Error';
    }
  }
}
