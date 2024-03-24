import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter/providers/user_provider.dart';
import 'package:twitter/screens/sign_in_form.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign in"),
      ),
      body: Column(
        children: [
          context.watch<UserProvider>().isSignedIn()
              ? const Text("utilisateur connecté")
              : const Text("utilisateur non connecté"),
          const Center(
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: SignInForm(),
            ),
          ),
        ],
      ),
    );
  }
}
