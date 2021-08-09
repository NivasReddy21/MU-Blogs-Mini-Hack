import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

class PostWidget extends StatefulWidget {
  final String postText;
  final String postTitle;
  final String userName;
  final String photoUrl;
  final bool isMyPost;

  const PostWidget({
    Key? key,
    required this.postText,
    required this.postTitle,
    required this.isMyPost,
    required this.userName,
    required this.photoUrl,
  }) : super(key: key);

  @override
  _PostWidgetState createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  bool isBusy = false;

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (context, sizingInformation) {
        return InkWell(
          onTap: () {
            showDialog(
              context: context,
              builder: (context) {
                return Dialog(
                  child: Container(
                    width: sizingInformation.isDesktop
                        ? MediaQuery.of(context).size.width * 0.6
                        : MediaQuery.of(context).size.width * 0.8,
                    // height: MediaQuery.of(context).size.height ,
                    padding: EdgeInsets.all(15),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            widget.postTitle,
                            style: TextStyle(
                              fontSize: sizingInformation.isMobile ? 18 : 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            widget.postText,
                            style: TextStyle(
                              fontSize: sizingInformation.isMobile ? 16 : 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
          child: Container(
            height: MediaQuery.of(context).size.height * 0.22,
            width: MediaQuery.of(context).size.width * 0.9,
            margin: EdgeInsets.all(15),
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(20),
              ),
              color: Colors.white60,
            ),
            child: Stack(
              children: [
                if (isBusy)
                  Container(
                    height: MediaQuery.of(context).size.height * 0.22,
                    width: MediaQuery.of(context).size.width * 0.9,
                    margin: EdgeInsets.all(15),
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20),
                      ),
                      color: Colors.black.withOpacity(0.25),
                    ),
                  )
                else
                  SizedBox(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(widget.photoUrl),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.userName,
                                  style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 15,
                                  ),
                                ),
                                Text(
                                  "6 Aug 2021",
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                        widget.isMyPost
                            ? MaterialButton(
                                onPressed: () async {
                                  setState(() {
                                    isBusy = true;
                                  });
                                  await FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(widget.userName)
                                      .collection('blogs')
                                      .doc(widget.postTitle)
                                      .delete();
                                  await FirebaseFirestore.instance
                                      .collection('blogs')
                                      .doc(widget.postTitle)
                                      .delete();
                                  setState(() {
                                    isBusy = false;
                                  });
                                },
                                color: Colors.redAccent,
                                padding: EdgeInsets.symmetric(
                                    horizontal: 5, vertical: 15),
                                child: Text(
                                  "Delete",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            : SizedBox()
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.postTitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                        fontSize: sizingInformation.isMobile ? 18 : 20,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      widget.postText,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: sizingInformation.isMobile ? 16 : 18,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
