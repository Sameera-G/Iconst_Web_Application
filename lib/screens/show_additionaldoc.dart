//to show additional documents this is used
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lconst/model/user_model.dart';

class UploadedDocs extends StatefulWidget {
  const UploadedDocs({Key? key}) : super(key: key);

  @override
  State<UploadedDocs> createState() => _UploadedImgState();
}

class _UploadedImgState extends State<UploadedDocs> {
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
        title: Text('Uploaded Additional Documents'),
      ),
      body: //show images *****************************************
          Container(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users')
                .doc(loggedInUser.uid)
                .collection('additional_doc')
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return (const Center(
                  child: Text('No Document Uploaded'),
                ));
              } else {
                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      String url = snapshot.data!.docs[index]['downloadURL4'];
                      return SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: SizedBox(
                          width: width,
                          child: Image.network(
                            url,
                            height: height,
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    });
              }
            }
            //profile information tables finished here
            ),
      ),
    );
  }
}
