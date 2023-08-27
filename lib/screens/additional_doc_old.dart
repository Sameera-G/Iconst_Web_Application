import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lconst/model/user_model.dart';
import 'package:lconst/screens/phnverfyaddoc.dart';

class AdditionalDoc extends StatefulWidget {
  const AdditionalDoc({Key? key}) : super(key: key);

  @override
  State<AdditionalDoc> createState() => _ProgressUploadState();
}

class _ProgressUploadState extends State<AdditionalDoc> {
  UploadTask? task;
  File? file, file2;
  bool loading = false;
  String? downloadURL4;

  //get data from the database
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

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
    //final fileName = file != null ? (file!.path) : 'No File Selected';
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    //double checkheight = 0.3;
    return DefaultTabController(
      length: 1,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), // Creates border
                  color: Colors.redAccent),
              tabs: [
                //Tab(icon: Icon(Icons.picture_as_pdf)),
                Tab(icon: Icon(Icons.image)),
              ]),
          title: const Text('Upload Additional documents'),
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/background2.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: TabBarView(
            children: [
              /*Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: height * 0.04,
                        child: Text(
                          'Select your PDF files Here!',
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      TextButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.red)),
                        onPressed: (() => selectFile()),
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: SizedBox(
                      height: height * 0.8,
                      child: file != null
                          ? SfPdfViewer.file(
                              file!,
                            )
                          : Container(
                              decoration: BoxDecoration(color: Colors.red[200]),
                              width: double.infinity,
                              //height: checkheight,
                              child: IconButton(
                                  color: Colors.grey[800],
                                  onPressed: () {
                                    selectFile();
                                  },
                                  icon: Icon(
                                    Icons.add_a_photo,
                                  )),
                            ),
                    ),
                  ),
                  loading
                      ? CircularProgressIndicator()
                      : MaterialButton(
                          minWidth: width * 0.6,
                          color: Colors.amber,
                          onPressed: uploadFile,
                          child: const Text(
                            'Upload File',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                  SizedBox(
                    height: 10.0,
                  ),
                ],
              ),*/
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: height * 0.04,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Text(
                            'Select your Document Images Here!',
                            style:
                                TextStyle(fontSize: 15.0, color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      TextButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.red)),
                        onPressed: (() => selectFile()),
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: SizedBox(
                      height: height * 0.8,
                      child: file != null
                          ? Image.file(
                              file!,
                            )
                          : Container(
                              decoration: BoxDecoration(color: Colors.red[200]),
                              width: double.infinity,
                              child: IconButton(
                                  color: Colors.grey[800],
                                  onPressed: () {
                                    selectFile();
                                  },
                                  icon: Icon(Icons.add_a_photo)),
                            ),
                    ),
                  ),
                  loading
                      ? CircularProgressIndicator()
                      : MaterialButton(
                          minWidth: width * 0.6,
                          color: Colors.amber,
                          onPressed: () {
                            uploadFile();
                          },
                          child: const Text(
                            'Upload File',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                  SizedBox(
                    height: 10.0,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result == null) return;
    final path = result.files.single.path;
    setState(() => file = File(path!));
  }

  /*Future selectFile2() async {
    final result2 = await FilePicker.platform.pickFiles(allowMultiple: false);
    if (result2 == null) return;
    final path2 = result2.files.single.path;
    setState(() => file2 = File(path2!));
  }*/

  Future uploadFile() async {
    setState(() {
      loading = true;
    });
    final postID = DateTime.now().toString();
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    Reference ref = FirebaseStorage.instance
        .ref()
        .child('users/${loggedInUser.uid}/additional_doc')
        .child('post_$postID');
    await ref.putFile(file!);
    downloadURL4 = await ref.getDownloadURL();
    print(downloadURL4);
    await firebaseFirestore
        .collection('users')
        .doc(loggedInUser.uid)
        .collection('additional_doc')
        .add({
          'downloadURL4': downloadURL4,
        })
        .then((value) =>
            Fluttertoast.showToast(msg: "Additional Documents uploaded"))
        .catchError((error) => Fluttertoast.showToast(msg: "$error"));
    setState(() {
      loading = false;
    });

    Navigator.push((context),
        MaterialPageRoute(builder: (context) => const PhoneVerifiAdDoc()));
  }

  /*Future uploadFile2() async {
    setState(() {
      loading = true;
    });
    final postID = DateTime.now().toString();
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    Reference ref = FirebaseStorage.instance
        .ref()
        .child('users/${loggedInUser.uid}/additional_doc')
        .child('post_$postID');
    await ref.putFile(file2!);
    downloadURL4 = await ref.getDownloadURL();
    print(downloadURL4);
    await firebaseFirestore
        .collection('users')
        .doc(loggedInUser.uid)
        .collection('additional_doc')
        .add({
          'downloadURL4': downloadURL4,
        })
        .then((value) =>
            Fluttertoast.showToast(msg: "Additional Documents uploaded"))
        .catchError((error) => Fluttertoast.showToast(msg: "$error"));
    setState(() {
      loading = false;
    });

    Navigator.push((context),
        MaterialPageRoute(builder: (context) => const UploadComplete()));
  }*/

  /*Future uploadFile() async {
    setState(() {
      loading = true;
    });
    if (file == null) return;
    //final fileName = (file!.path);
    final postID = DateTime.now().toString();
    final destination = 'users/${user!.uid}/additional_doc/$postID';
    FirebaseApi.uploadFile(destination, file!);
    setState(() {
      loading = false;
    });
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => UploadComplete()));
  }*/
}

/*class FirebaseApi {
  static UploadTask? uploadFile(String destination, File file) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);
      return ref.putFile(file);
    } on FirebaseException {
      return null;
    }
  }
}*/
