import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter/models/user.dart';
import 'package:twitter/providers/user_provider.dart';
import '../widgets/tweet_master.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    final User user = context.watch<UserProvider>().user;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome"),
      ),
      body: Center(
        child: Column(
          children: [
            context.watch<UserProvider>().isSignedIn()
                ? Text("Welcome ${user.firstname} ${user.lastname}")
                : const Text("Utilisateur déconnecté"),
            context.watch<UserProvider>().isSignedIn()
                ? ElevatedButton(
              onPressed: () => context.read<UserProvider>().signOut(),
              child: const Text("Déconnexion"),
            )
                : Container(),
            context.watch<UserProvider>().isSignedIn()
                ? TweetMaster() // Display the TweetMaster widget here
                : const FloatingActionButton(
                    onPressed:null,
                    tooltip: 'Increment',
                    child: Icon(Icons.add),
                  ),
            const SizedBox(height: 20), // Add some spacing
          ],
        ),
      ),
    );
  }
}
