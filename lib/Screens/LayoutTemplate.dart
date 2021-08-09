import 'package:flutter/material.dart';
import 'package:mu_blogs/Locator.dart';
import 'package:mu_blogs/Routing/RouteNames.dart';
import 'package:mu_blogs/Routing/Router.dart';
import 'package:mu_blogs/Services/NavigationService.dart';
import 'package:mu_blogs/Widgets/Navbar/NavBar.dart';
import 'package:mu_blogs/Widgets/NavbarDrawer/NavDrawer.dart';
import 'package:responsive_builder/responsive_builder.dart';

class LayoutTemplate extends StatelessWidget {
  const LayoutTemplate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) => Scaffold(
        drawer: sizingInformation.deviceScreenType == DeviceScreenType.mobile
            ? NavDrawer()
            : sizingInformation.deviceScreenType == DeviceScreenType.tablet
                ? NavDrawer()
                : null,
        backgroundColor: Colors.grey[800],
        body: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Navbar(),
            SizedBox(
              height: 30,
            ),
            Expanded(
              child: Navigator(
                key: locator<NavigationService>().navigatorKey,
                onGenerateRoute: generateRoute,
                initialRoute: HomeRoute,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
