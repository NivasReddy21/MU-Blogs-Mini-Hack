import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class CreateView extends StatefulWidget {
  @override
  _CreateViewState createState() => _CreateViewState();
}

class _CreateViewState extends State<CreateView> {
  TextEditingController _postController = TextEditingController();
  TextEditingController _titleController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Container(
        child: GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.grey[800],
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.grey,
                ),
              )
            : Center(
                child: Container(
                  height: height * 0.91,
                  width: width * 0.8,
                  padding: EdgeInsets.all(15),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Text(
                          "CREATE POST",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        SizedBox(
                          height: 13,
                        ),
                        TextField(
                          maxLines: 1,
                          onChanged: (value) {
                            setState(() {
                              _titleController.text = value;
                            });
                          },
                          style: TextStyle(fontSize: 18.0, color: Colors.white),
                          decoration: InputDecoration(
                            hintText: "Add a Title",
                            contentPadding: EdgeInsets.all(15),
                            hintStyle: TextStyle(
                              fontSize: 18,
                              color: Colors.white70,
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 1.0,
                              ),
                            ),
                            fillColor: Colors.black,
                            filled: true,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide:
                                  BorderSide(color: Colors.white, width: 2.0),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextField(
                          maxLines: 22,
                          onChanged: (value) {
                            setState(() {
                              _postController.text = value;
                            });
                          },
                          style: TextStyle(fontSize: 18.0, color: Colors.white),
                          decoration: InputDecoration(
                            hintText: "Start Writing....",
                            contentPadding: EdgeInsets.all(15),
                            hintStyle: TextStyle(
                              fontSize: 18,
                              color: Colors.white70,
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.black,
                                width: 1.0,
                              ),
                            ),
                            fillColor: Colors.black,
                            filled: true,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide:
                                  BorderSide(color: Colors.white, width: 2.0),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        MaterialButton(
                          onPressed: () async {
                            setState(() {
                              isLoading = true;
                            });
                            await postBlog(_postController, _titleController);
                            setState(() {
                              isLoading = false;
                            });
                          },
                          child: Text(
                            "Post",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                          color: Colors.black,
                          padding: EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 20,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
      ),
    ));
  }

  Future postBlog(textCntroller, titleController) async {
    if (textCntroller.text == '' || titleController.text == '') {
      AwesomeDialog(
          dismissOnTouchOutside: true,
          dismissOnBackKeyPress: true,
          context: context,
          dialogType: DialogType.ERROR,
          animType: AnimType.SCALE,
          headerAnimationLoop: false,
          title: 'Error',
          desc: 'Please Give Both Title and Body!',
          width: 500)
        ..show();
    } else {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      String userName = _prefs.getString("name")!;
      String photoUrl = _prefs.getString("photoUrl")!;
      var data = {
        "blogText": textCntroller.text,
        "blogTitle": titleController.text,
        "userName": userName,
        "photoUrl": photoUrl,
      };

      await FirebaseFirestore.instance
          .collection("blogs")
          .doc(titleController.text)
          .set(data);
      await FirebaseFirestore.instance
          .collection("users")
          .doc(userName)
          .collection("blogs")
          .doc(titleController.text)
          .set(data);

      AwesomeDialog(
          context: context,
          animType: AnimType.SCALE,
          headerAnimationLoop: false,
          dialogType: DialogType.SUCCES,
          title: 'Succes',
          desc: 'Posted Successfully!',
          dismissOnTouchOutside: true,
          dismissOnBackKeyPress: true,
          width: 500)
        ..show();

      return true;
    }
  }
}
