//this is ok for uploaded images

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lconst/model/user_model.dart';
import 'package:lconst/screens/fullscreenimg.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:universal_html/html.dart' as html;

class UploadedImg extends StatefulWidget {
  const UploadedImg({Key? key}) : super(key: key);

  @override
  State<UploadedImg> createState() => _UploadedImgState();
}

class _UploadedImgState extends State<UploadedImg> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  String? downloadUrl;

  @override
  void initState() {
    //implement initState
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Uploaded Images'),
      ),
      body: //show images *****************************************
          SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/background2.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(15.0),
                child: Card(
                  color: Colors.black54,
                  shadowColor: Colors.amber,
                  margin: EdgeInsets.all(20.0),
                  child: Container(
                    padding: EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Text(
                          'Uploaded Construction progress images',
                          style: TextStyle(
                            fontSize: 30.0,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Text(
                          'To download, please click on the image',
                          style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                child: Card(
                  margin: EdgeInsets.all(15.0),
                  color: Colors.black54,
                  elevation: 10,
                  shadowColor: Colors.amber,
                  child: StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .doc(loggedInUser.uid)
                          .collection('progress_images')
                          .snapshots(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return (const Center(
                            child: Text('No Image Uploaded'),
                          ));
                        } else {
                          return GridView.builder(
                            padding:
                                EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 5.0,
                              mainAxisSpacing: 5.0,
                            ),
                            itemCount: 3,
                            itemBuilder: (context, index) {
                              String url =
                                  snapshot.data!.docs[index]['downloadURL1'];
                              return SizedBox(
                                height: height,
                                width: width,
                                child: GestureDetector(
                                  onTap: () async {
                                    try {
                                      // first we make a request to the url like you did
                                      // in the android and ios version
                                      final http.Response r = await http.get(
                                        Uri.parse(url),
                                      );

                                      // we get the bytes from the body
                                      final data = r.bodyBytes;
                                      // and encode them to base64
                                      final base64data = base64Encode(data);

                                      // then we create and AnchorElement with the html package
                                      final a = html.AnchorElement(
                                          href:
                                              'data:image/jpeg;base64,$base64data');

                                      // set the name of the file we want the image to get
                                      // downloaded to
                                      a.download = 'download.jpg';

                                      // and we click the AnchorElement which downloads the image
                                      a.click();
                                      // finally we remove the AnchorElement
                                      a.remove();
                                    } catch (e) {
                                      print(e);
                                    }
                                  },
                                  child: Image.network(
                                    url,
                                    fit: BoxFit.fill,
                                    //height: height,
                                  ),
                                ),
                              );
                            },
                          );

                          /*ListView.builder(
                              padding: EdgeInsets.all(15.0),
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (BuildContext context, int index) {
                                String url = snapshot.data!.docs[index]['downloadURL1'];
                                return SizedBox(
                                  height: height,
                                  width: width,
                                  child: Image.network(
                                    url,
                                    fit: BoxFit.fill,
                                    //height: height,
                                  ),
                                );
                              });*/
                        }
                      }
                      //profile information tables finished here
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
