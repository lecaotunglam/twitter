import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter/providers/user_provider.dart';
import 'package:twitter/screens/signin_screen.dart';
import 'package:twitter/screens/welcome_screen.dart';



void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Twitter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xfffce68e)),
        useMaterial3: true,
      ),
      home: context.watch<UserProvider>().isSignedIn()
          ? const WelcomeScreen()
          : const SignInScreen()

    ); // This trailing comma makes auto-formatting nicer for build methods

  }
}




