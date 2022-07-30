import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:todoapp/firebase_options.dart';
import 'package:todoapp/views/sign_in_page.dart';

bool shouldUseFirestoreEmulator = false;
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // if (shouldUseFirestoreEmulator) {
  //   FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
  // }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static const String _title = 'Flutter TodoApp';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(initialRoute: "/", home: SignInPage());
  }
}
