import 'package:flutter/material.dart';
import 'package:mu_blogs/Locator.dart';
import 'package:mu_blogs/Routing/RouteNames.dart';
import 'package:mu_blogs/Services/NavigationService.dart';

class NavDrawerHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        locator<NavigationService>().navigateTo(HomeRoute);
      },
      child: Container(
        color: Colors.white,
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
                height: 150, width: 150, child: Image.asset("Assets/logo.png")),
          ],
        ),
      ),
    );
  }
}
