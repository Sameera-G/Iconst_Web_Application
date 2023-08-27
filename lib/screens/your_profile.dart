//import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lconst/model/locationModel.dart';
import 'package:lconst/model/my_encryption.dart';
import 'package:lconst/model/user_model.dart';
import 'package:lconst/screens/show_additionaldoc.dart';
import 'package:lconst/screens/show_locations.dart';
import 'package:lconst/screens/uploaded_img.dart';

class YourProfile extends StatefulWidget {
  const YourProfile({
    Key? key,
  }) : super(key: key);

  @override
  State<YourProfile> createState() => _YourProfileState();
}

class _YourProfileState extends State<YourProfile> {
  //get data from the database
  User? user = FirebaseAuth.instance.currentUser;

  UserModel loggedInUser = UserModel();
  UserModel2 location = UserModel2();
  var fName, sName, hAddress;
  String? downloadUrl;
  var items = List<String>.generate(100, (index) => 'Item $index');

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
      setState(() {
        fName = MyEncryptionDecryption.decryptionAES(loggedInUser.firstName);
        sName = MyEncryptionDecryption.decryptionAES(loggedInUser.secondName);
        hAddress =
            MyEncryptionDecryption.decryptionAES(loggedInUser.homeAddress);
      });
    });
  }

  //get data from firebase

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Your Profile',
        ),
      ),
      body: Container(
        height: height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/background2.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(
                      'https://images.unsplash.com/photo-1627161684458-a62da52b51c3?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8Nnx8bWFufGVufDB8MnwwfHw%3D&auto=format&fit=crop&w=500&q=60'),
                  fit: BoxFit.contain,
                ),
              ),
              child: null,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black.withOpacity(0.6)),
                width: width,
                child: buildQuoteCard(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black.withOpacity(0.6)),
                width: width,
                child: buildQuoteCard2(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(10),
                ),
                width: width,
                child: buildQuoteCard3(),
              ),
            ),
            /* SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () => Navigator.push(
                      (context),
                      MaterialPageRoute(
                          builder: (context) => const UploadedImg()),
                    ),
                    child: Text(
                      ('Uploaded\n Images'),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15.0),
                    ),
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.push(
                      (context),
                      MaterialPageRoute(
                          builder: (context) => const ShowLocations()),
                    ),
                    child: Text(
                      ('Show\n Locations'),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15.0),
                    ),
                  ),
                  SizedBox(
                    width: 15.0,
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.push(
                      (context),
                      MaterialPageRoute(
                          builder: (context) => const UploadedDocs()),
                    ),
                    child: Text(
                      ('Uploaded\n Documents'),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 15.0),
                    ),
                  ),
                ],
              ),
            ), */
            SizedBox(
              height: 10.0,
            ),
            //list view of the users
            ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text('{user name, $index}'),
                  );
                }),
          ],
        ),
      ),
    );
  }

  Widget buildQuoteCard() => Card(
        color: Colors.transparent,
        elevation: 8,
        shadowColor: Colors.black,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
          ),
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Name',
                    style: TextStyle(fontSize: 15, color: Colors.white),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '${fName} ${sName}',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )
                ]),
          ),
        ),
      );

  Widget buildQuoteCard2() => Card(
        color: Colors.transparent,
        elevation: 8,
        shadowColor: Colors.black,
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Text(
              'Email Address',
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
            const SizedBox(height: 12),
            Text(
              '${loggedInUser.email}',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            )
          ]),
        ),
      );

  Widget buildQuoteCard3() => Card(
        color: Colors.transparent,
        elevation: 8,
        shadowColor: Colors.black,
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Text(
              'Address',
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
            const SizedBox(height: 12),
            Text(
              '${hAddress}',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            )
          ]),
        ),
      );
}
