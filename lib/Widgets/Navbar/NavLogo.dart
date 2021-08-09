import 'package:flutter/material.dart';
import 'package:mu_blogs/Locator.dart';
import 'package:mu_blogs/Routing/RouteNames.dart';
import 'package:mu_blogs/Services/NavigationService.dart';

class NavBarLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        locator<NavigationService>().navigateTo(HomeRoute);
      },
      child: SizedBox(
        height: 80,
        width: 150,
        child: Row(
          children: [
            SizedBox(
                height: 50, width: 50, child: Image.asset("Assets/logos.png")),
            Text("BLOGS",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    fontWeight: FontWeight.w800))
          ],
        ),
      ),
    );
  }
}
