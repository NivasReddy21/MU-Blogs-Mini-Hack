import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:mu_blogs/Routing/RouteNames.dart';
import 'package:mu_blogs/Screens/Authentication/Login.dart';
import 'package:mu_blogs/Widgets/Navbar/NavItems.dart';
import 'package:mu_blogs/Widgets/Navbar/NavLogo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NavbarDesktop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          )),
      height: 80,
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          NavBarLogo(),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              NavbarItem(
                title: 'CREATE',
                navigationPath: CreateRoute,
              ),
              SizedBox(
                width: 60,
              ),
              NavbarItem(
                title: 'MY BLOGS',
                navigationPath: MyBlogsRoute,
              ),
              SizedBox(
                width: 60,
              ),
              GestureDetector(
                onTap: () async {
                  FirebaseAuth.instance.signOut();

                  SharedPreferences _prefs =
                      await SharedPreferences.getInstance();

                  _prefs.clear();

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
          )
        ],
      ),
    );
  }
}
