import 'package:flutter/material.dart';
import 'package:twitter/providers/user_provider.dart';
import 'package:provider/provider.dart';
import 'package:twitter/screens/welcome_screen.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  SignInFormState createState() {
    return SignInFormState();
  }
}

class SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();

  final _loginController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Identifiant"),
          TextFormField(
            controller: _loginController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez saisir un identifiant';
              }
              return null;
            },
          ),
          const Text("Mot de passe"),
          TextFormField(
            controller: _passwordController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Veuillez saisir un mot de passe';
              }
              return null;
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  final String login = _loginController.text;
                  final String password = _passwordController.text;

                  context.read<UserProvider>().signIn(login, password);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const WelcomeScreen();
                      },
                    ),
                  );

                  // ScaffoldMessenger.of(context).showSnackBar(
                  //   const SnackBar(content: Text('Processing Data')),
                  // );
                }
              },
              child: const Text('Connexion'),
            ),
          ),
        ],
      ),
    );
  }
}
