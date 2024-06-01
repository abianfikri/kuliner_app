import 'package:flutter/material.dart';
import 'package:flutter_kuliner_app/_widgets/button_widget.dart';
import 'package:flutter_kuliner_app/_widgets/tfprefix_widget.dart';
import 'package:flutter_kuliner_app/controller/auth_controller.dart';
import 'package:flutter_kuliner_app/model/user_model.dart';
import 'package:flutter_kuliner_app/view/auth/register_view.dart';
import 'package:flutter_kuliner_app/view/home/home_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final formKey = GlobalKey<FormState>();
  final controller = AuthController();
  final email = TextEditingController();
  final password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
            key: formKey,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 50,
                    child: Icon(
                      Icons.person,
                      size: 35,
                    ),
                  ),
                  const Text(
                    "LOGIN",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Email
                  TFPrefixIconWidget(
                    controller: email,
                    textInputType: TextInputType.emailAddress,
                    hintText: "Masukkan Email",
                    labelText: "Email",
                    validator: "Email Tidak Boleh Kosong",
                    maxLines: 1,
                    prefixIcon: const Icon(Icons.email),
                  ),

                  // Password
                  TFPrefixIconWidget(
                    controller: password,
                    textInputType: TextInputType.visiblePassword,
                    hintText: "Masukkan Password",
                    labelText: "Password",
                    validator: "Password Tidak Boleh Kosong",
                    maxLines: 1,
                    prefixIcon: const Icon(Icons.password),
                  ),

                  const SizedBox(
                    height: 15,
                  ),

                  ButtonWidget(
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        UserModel? result = await controller
                            .signEmailandPassword(email.text, password.text);

                        if (result != null) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Login Successful'),
                                content: const Text(
                                    'You have been successfully Loginned.'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const HomeView(),
                                        ),
                                      );
                                      // Navigate to the next screen or perform any desired action
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              );
                            },
                          );
                        } else {
                          // Login failed
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text('Login Failed'),
                                content: const Text(
                                    'An error occurred during Login.'),
                                actions: <Widget>[
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const LoginView()),
                                        (route) => false,
                                      );
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
                    nameButton: "Login",
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Apakah Kamu belum Punya Akun?"),
                      TextButton(
                        child: const Text("Pilih Register"),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegisterView(),
                            ),
                          );
                        },
                      )
                    ],
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
