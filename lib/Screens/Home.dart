import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mu_blogs/Widgets/PostWidget.dart';
import 'package:responsive_builder/responsive_builder.dart';

String postText = """
Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec finibus orci mattis libero pulvinar, id eleifend libero facilisis. Vivamus faucibus eu leo quis fringilla. Suspendisse cursus at turpis sit amet rutrum. Phasellus vitae libero elementum, luctus turpis ac, pretium velit. Maecenas imperdiet aliquam nisl, id varius orci fermentum ut. Fusce rutrum dolor aliquet ultrices tempus. Ut molestie ac quam nec auctor. Aliquam varius metus nec dapibus tristique. Nam in erat nec purus ultricies pharetra. Nam dignissim sapien at tortor auctor consequat. Etiam ultrices augue sed neque blandit, id tempus neque sodales. Integer vel turpis sit amet massa accumsan luctus id at libero.

Morbi vel justo id velit faucibus dapibus id quis elit. Pellentesque in urna non metus pellentesque luctus. Sed tellus nisl, efficitur nec accumsan sed, interdum non velit. Nunc euismod risus eu nibh gravida, eu aliquet purus mollis. Praesent eget orci dapibus, cursus lorem ac, ultricies metus. Vivamus nec nulla eget dui malesuada laoreet. Donec pretium porttitor diam sed pellentesque. Nunc libero felis, imperdiet id ultricies ac, aliquet quis nulla. Aenean congue vitae diam eget pharetra. Vivamus vel magna vel nulla varius finibus. Vestibulum sollicitudin tortor eget lacus convallis consectetur. Quisque id ultricies lorem. Maecenas nec nisi ut risus imperdiet tincidunt.
""";

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return ResponsiveBuilder(
      builder: (context, sizingInformation) => Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Container(
            height: height * 0.8,
            width: width * 0.9,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(25)),
              color: Colors.black,
            ),
            padding: EdgeInsets.all(15),
            child: StreamBuilder<QuerySnapshot>(
                stream:
                    FirebaseFirestore.instance.collection('blogs').snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.grey,
                      ),
                    );
                  } else {
                    print(snapshot.data);
                    List docs = snapshot.data!.docs;

                    List<PostWidget> blogs = docs
                        .map(
                          (doc) => PostWidget(
                              postText: doc.data()!['blogText'],
                              postTitle: doc.data()!['blogTitle'],
                              userName: doc.data()!['userName'],
                              photoUrl: doc.data()!['photoUrl'],
                              isMyPost: false),
                        )
                        .toList();

                    return SingleChildScrollView(
                      child: Column(
                        children: blogs,
                      ),
                    );
                  }
                }),
          ),
        ),
      ),
    );
  }
}
