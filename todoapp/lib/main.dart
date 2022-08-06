import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:todoapp/controllers/auth_controller.dart';
import 'package:todoapp/firebase_options.dart';
import 'package:todoapp/page_routes.dart';
import 'package:todoapp/views/sign_in_page.dart';
import 'package:todoapp/views/todo_page.dart';

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

  @override
  Widget build(BuildContext context) {
    Get.put(AuthController());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      // initialRoute: "/",
      home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, userSnapShotData) {
            if (!userSnapShotData.hasData) {
              return SignInPage();
            } else {
              return TodoDashBoard();
            }
          }),
      getPages: pageRoutes(),
      // initialBinding: BindingsBuilder(() => {
      //   Get.put(AuthController()),
      // }),
    );
  }
}
