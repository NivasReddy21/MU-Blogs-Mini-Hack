import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:mu_blogs/Screens/LayoutTemplate.dart';
import 'package:mu_blogs/Services/AuthService.dart';

class LoginMobile extends StatefulWidget {
  const LoginMobile({Key? key}) : super(key: key);

  @override
  _LoginMobileState createState() => _LoginMobileState();
}

class _LoginMobileState extends State<LoginMobile> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return isLoading
        ? Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.grey,
            ),
          )
        : SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.symmetric(vertical: height * 0.1),
              alignment: Alignment.center,
              child: Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("login.jpg"),
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.8,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                      color: Colors.white.withOpacity(0.75),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(40),
                    width: MediaQuery.of(context).size.width * 0.8,
                    height: MediaQuery.of(context).size.height * 0.8,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.all(
                        Radius.circular(30),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image(
                          image: AssetImage("logo.png"),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Text(
                          "MU BLOGS",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: 40,
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
                ],
              ),
            ),
          );
  }
}
