import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:mu_blogs/Screens/LayoutTemplate.dart';
import 'package:mu_blogs/Services/AuthService.dart';

class LoginDesktop extends StatefulWidget {
  const LoginDesktop({Key? key}) : super(key: key);

  @override
  _LoginDesktopState createState() => _LoginDesktopState();
}

class _LoginDesktopState extends State<LoginDesktop> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return isLoading
        ? Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.grey,
            ),
          )
        : Container(
            margin: EdgeInsets.symmetric(
              horizontal: width * 0.09,
              vertical: height * 0.09,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(40),
                  width: MediaQuery.of(context).size.width * 0.4,
                  height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "MU BLOGS",
                        style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 70,
                      ),
                      SignInButton(Buttons.GoogleDark, onPressed: () {
                        setState(() async {
                          isLoading = !isLoading;
                          try {
                            await AuthService().signInWithGoogle();
                            Navigator.of(context).pop();
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => LayoutTemplate(),
                              ),
                            );
                          } catch (e) {
                            print(e);
                            setState(() {
                              isLoading = !isLoading;
                            });
                          }
                        });
                      }),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
                Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.4046,
                      height: MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage("login.jpg"),
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.4046,
                      height: MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                        color: Colors.white.withOpacity(0.75),
                      ),
                    ),
                    Positioned(
                      top: height * .25,
                      left: width * .13,
                      child: Container(
                        child: Image.asset("Assets/logo.png"),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
  }
}
