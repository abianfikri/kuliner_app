import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_kuliner_app/controller/auth_controller.dart';
import 'package:flutter_kuliner_app/view/auth/login_view.dart';
import 'package:flutter_kuliner_app/view/home/home_view.dart';

class MainPageStatus extends StatefulWidget {
  const MainPageStatus({super.key});

  @override
  State<MainPageStatus> createState() => _MainPageStatusState();
}

class _MainPageStatusState extends State<MainPageStatus> {
  final authController = AuthController();
  bool isLoggin = false;

  Future<void> _checkLoginStatus() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;

    if (user != null) {
      DocumentSnapshot<Map<String, dynamic>> userSnaphot =
          await FirebaseFirestore.instance
              .collection('users')
              .doc(user.uid)
              .get();
      if (userSnaphot.exists) {
        setState(() {
          isLoggin = true;
        });
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkLoginStatus();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoggin) {
      return Scaffold(
        body: HomeView(),
      );
    } else {
      return Scaffold(
        body: LoginView(),
      );
    }
  }
}
