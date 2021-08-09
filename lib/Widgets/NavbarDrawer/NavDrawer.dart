import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mu_blogs/Routing/RouteNames.dart';
import 'package:mu_blogs/Screens/Authentication/Login.dart';
import 'package:mu_blogs/Widgets/NavbarDrawer/DrawerHeader.dart';
import 'package:mu_blogs/Widgets/NavbarDrawer/DrawerItem.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      decoration: BoxDecoration(
        color: Colors.black,
        boxShadow: [
          BoxShadow(color: Colors.white12, blurRadius: 16),
        ],
      ),
      child: Column(
        children: <Widget>[
          NavDrawerHeader(),
          DrawerItem('CREATE', Icons.create, CreateRoute),
          DrawerItem('MY BLOGS', FontAwesomeIcons.bookReader, MyBlogsRoute),
          Padding(
            padding: const EdgeInsets.only(left: 30, top: 60),
            child: Row(
              children: <Widget>[
                Icon(
                  FontAwesomeIcons.signOutAlt,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 30,
                ),
                GestureDetector(
                  onTap: () async {
                    FirebaseAuth.instance.signOut();

                    SharedPreferences _prefs =
                        await SharedPreferences.getInstance();

                    _prefs.clear();
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ),
                    );
                  },
                  child: Text(
                    "LOG OUT",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
