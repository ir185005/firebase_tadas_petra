import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FirebaseAuthLesson extends StatefulWidget {
  const FirebaseAuthLesson({Key? key}) : super(key: key);
  @override
  State<FirebaseAuthLesson> createState() => _FirebaseAuthLessonState();
}

class _FirebaseAuthLessonState extends State<FirebaseAuthLesson> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  UserCredential? _authResult;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _signUp({required String email, required String password}) async {
    try {
      _authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      _authResult!.user!.sendEmailVerification();
      if (kDebugMode) {
        print('Account created for user ${_authResult!.user!.email}');
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  void _logIn({required String email, required String password}) async {
    try {
      _authResult = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (_authResult!.user!.emailVerified) {
        if (!mounted) return;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const SignInPage(),
          ),
        );
      } else {
        if (kDebugMode) {
          print('You need to verify your email.');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Firebase Auth"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextField(
                controller: _emailController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: TextField(
                controller: _passwordController,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _signUp(
                  email: _emailController.text,
                  password: _passwordController.text,
                );
              },
              child: const Text('Sign Up'),
            ),
            ElevatedButton(
              onPressed: () {
                _logIn(
                  email: _emailController.text,
                  password: _passwordController.text,
                );
              },
              child: const Text('Log In'),
            ),
          ],
        ),
      ),
    );
  }
}

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SignIn Page'),
      ),
    );
  }
}
