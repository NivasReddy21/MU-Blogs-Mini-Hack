import 'package:flutter/material.dart';
import 'package:mu_blogs/Widgets/Navbar/NavBarDesktop.dart';
import 'package:mu_blogs/Widgets/Navbar/NavBarMobile.dart';
import 'package:responsive_builder/responsive_builder.dart';

class Navbar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout(
      mobile: NavbarMobile(),
      desktop: NavbarDesktop(),
    );
  }
}
