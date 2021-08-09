import 'package:flutter/material.dart';
import 'package:mu_blogs/Locator.dart';
import 'package:mu_blogs/Services/NavigationService.dart';

class NavbarItem extends StatelessWidget {
  final String title;
  final String navigationPath;
  const NavbarItem(
      {Key? key, required this.title, required this.navigationPath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        locator<NavigationService>().navigateTo(navigationPath);
      },
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w400,
          color: Colors.white,
        ),
      ),
    );
  }
}
