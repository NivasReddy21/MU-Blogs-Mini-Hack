import 'package:flutter/material.dart';
import 'package:mu_blogs/Widgets/Navbar/NavItems.dart';

class DrawerItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final String navigationPath;
  const DrawerItem(this.title, this.icon, this.navigationPath);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, top: 60),
      child: Row(
        children: <Widget>[
          Icon(
            icon,
            color: Colors.white,
          ),
          SizedBox(
            width: 30,
          ),
          NavbarItem(
            title: title,
            navigationPath: navigationPath,
          )
        ],
      ),
    );
  }
}
