import 'package:flutter/material.dart';
import 'package:login_tutorial/services/encrypt_decrypt.dart';
import 'package:login_tutorial/services/loginRequest.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController fullName = TextEditingController();
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  String result = '';

  String name = '';
  String user = '';

  @override
  void dispose() {
    fullName.dispose();
    username.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          height: size.height,
          width: size.width,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Result: $result',
                style: TextStyle(
                  fontSize: size.height * 0.03,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.02,
                ),
                child: Column(
                  children: [
                    CustomInput(
                      hint: 'Enter Name',
                      controller: fullName,
                    ),
                    CustomInput(
                      hint: 'Enter Username',
                      controller: username,
                    ),
                    CustomInput(
                      hint: 'Enter Password',
                      controller: password,
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.01),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MaterialButton(
                    color: Colors.blueAccent,
                    onPressed: () async {
                      result = await DatabaseRequest(
                        username: username.text,
                        password: password.text,
                        fullName: fullName.text,
                      ).request();
                      setState(() {});
                    },
                    child: const Text(
                      'Login Now',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  MaterialButton(
                    color: Colors.blueAccent,
                    onPressed: () async {
                      GetProfile(username: username.text)
                          .getProfile()
                          .then((value) {
                        name = Security(text: value[0]['fullname']).decrypt();
                        user = Security(text: value[0]['username']).decrypt();
                        setState(() {});
                      });
                    },
                    child: const Text(
                      'Get Profile',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
              Text(
                'Fullname: $name',
                style: TextStyle(fontSize: size.height * 0.03),
              ),
              Text(
                'UserName: $user',
                style: TextStyle(fontSize: size.height * 0.03),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomInput extends StatelessWidget {
  const CustomInput({
    super.key,
    required this.hint,
    required this.controller,
  });

  final String hint;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(hintText: hint),
    );
  }
}
