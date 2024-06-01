import 'package:flutter/material.dart';
import 'package:flutter_kuliner_app/_widgets/button_widget.dart';
import 'package:flutter_kuliner_app/_widgets/tf_widget.dart';
import 'package:flutter_kuliner_app/controller/auth_controller.dart';
import 'package:flutter_kuliner_app/model/user_model.dart';
import 'package:flutter_kuliner_app/view/auth/login_view.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final formKey = GlobalKey<FormState>();
  final controller = AuthController();
  final email = TextEditingController();
  final password = TextEditingController();
  final username = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Register"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Center(
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    child: Icon(
                      Icons.person,
                      size: 35,
                    ),
                  ),
                  const Text(
                    "Register",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Email
                  TfWidget(
                    controller: email,
                    textInputType: TextInputType.emailAddress,
                    hintText: "Masukkan Email",
                    labelText: "Email",
                    validator: "Email Tidak Boleh Kosong",
                    maxLines: 1,
                  ),

                  // Username
                  TfWidget(
                    controller: username,
                    textInputType: TextInputType.name,
                    hintText: "Masukkan Username",
                    labelText: "Username",
                    validator: "Username Tidak Boleh Kosong",
                    maxLines: 1,
                  ),

                  // Password
                  TfWidget(
                    controller: password,
                    textInputType: TextInputType.visiblePassword,
                    hintText: "Masukkan Password",
                    labelText: "Password",
                    validator: "Password Tidak Boleh Kosong",
                    maxLines: 1,
                  ),

                  const SizedBox(
                    height: 15,
                  ),

                  ButtonWidget(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        UserModel? result =
                            await controller.registeremailPassword(
                                email.text, password.text, username.text);

                        if (result != null) {
                          // Registration successful
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Registration Successful'),
                                content: const Text(
                                    'You have been successfully registered.'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const LoginView()));
                                      // Navigate to the next screen or perform any desired action
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                        } else {
                          // Registration failed
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Registration Failed'),
                                content: const Text(
                                    'An error occurred during registration.'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const RegisterView()));
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      }
                    },
                    nameButton: "Simpan",
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
