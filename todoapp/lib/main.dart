import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:todoapp/colors.dart';
import 'package:todoapp/firebase_options.dart';
import 'package:todoapp/providers/sign_in_provider.dart';
import 'package:todoapp/providers/size_providers.dart';
import 'package:todoapp/providers/todo_dashboard_provider.dart';
import 'package:todoapp/views/google_sign_in_page.dart';
import 'package:todoapp/views/todo_page.dart';

bool shouldUseFirestoreEmulator = false;
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TodoDashboardProvider>(
            create: (_) => TodoDashboardProvider()),
        ChangeNotifierProvider<SignInProvider>(create: (_) => SignInProvider()),
        ChangeNotifierProvider<SizeProvider>(create: (_) => SizeProvider()),
      ],
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, userSnapShotData) {
                if (!userSnapShotData.hasData) {
                  return GoogleSignInPage();
                } else if (userSnapShotData.connectionState ==
                    ConnectionState.waiting) {
                  return const CircularProgressIndicator(
                    color: blueShade,
                    value: 10.0,
                  );
                } else {
                  return TodoDashBoard();
                }
              }),
        );
      },
    );
  }
}
