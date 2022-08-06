import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todoapp/colors.dart';
import 'package:todoapp/controllers/google_sign_in.dart';

class NavigationDrawerWidget extends StatelessWidget {
  // const NavigationDrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: Colors.amber,
        child: Material(
          color: navbarcolor,
          child: ListView(
            children: [
              const SizedBox(
                height: 10,
              ),
              buildMenuItem(
                  text: FirebaseAuth.instance.currentUser!.email!.split('@')[0],
                  icon: Icons.person_outlined),
              buildMenuItem(
                  text: 'Logout',
                  icon: Icons.logout_outlined,
                  onClicked: () async {
                    if (Get.find<GoogleSignInController>().user != null) {
                      await Get.find<GoogleSignInController>().googleLogout();
                    }
                    await FirebaseAuth.instance.signOut();
                    Get.offNamed('/');
                  })
            ],
          ),
        ));
  }
}

Widget buildMenuItem(
    {required String text, required IconData icon, VoidCallback? onClicked}) {
  const color = blueShade;
  return ListTile(
    leading: Icon(
      icon,
      color: color,
    ),
    title: Text(
      text,
      style: const TextStyle(color: color, fontWeight: FontWeight.w600),
    ),
    onTap: onClicked,
  );
}
