//import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lconst/model/locationModel.dart';
import 'package:lconst/model/my_encryption.dart';
import 'package:lconst/model/user_model.dart';

// ignore: must_be_immutable
class ShowLocations extends StatefulWidget {
  const ShowLocations({
    Key? key,
  }) : super(key: key);

  @override
  State<ShowLocations> createState() => _ShowLocationsState();
}

class _ShowLocationsState extends State<ShowLocations> {
  //get data from the database
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  UserModel2 location = UserModel2();
  var lat1, lat2, lat3, long1, long2, long3;

  String? downloadUrl;

  @override
  void initState() {
    //implement initState
    super.initState();

    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .collection('collections')
        .doc('locationsdoc')
        .get()
        .then((value) {
      location = UserModel2.fromMap(value.data());
      setState(() {
        lat1 = MyEncryptionDecryption.decryptionAES(location.img1lat);
        long1 = MyEncryptionDecryption.decryptionAES(location.img1long);
        lat2 = MyEncryptionDecryption.decryptionAES(location.img2lat);
        long2 = MyEncryptionDecryption.decryptionAES(location.img2long);
        lat3 = MyEncryptionDecryption.decryptionAES(location.img3lat);
        long3 = MyEncryptionDecryption.decryptionAES(location.img3long);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      //backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Construction Location'),
      ),
      body: Container(
        width: width,
        height: height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/background2.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  decoration:
                      BoxDecoration(color: Colors.black.withOpacity(0.6)),
                  child: buildQuoteCard0(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  decoration:
                      BoxDecoration(color: Colors.black.withOpacity(0.6)),
                  child: buildQuoteCard(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  decoration:
                      BoxDecoration(color: Colors.black.withOpacity(0.6)),
                  child: buildQuoteCard2(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  decoration:
                      BoxDecoration(color: Colors.black.withOpacity(0.6)),
                  child: buildQuoteCard3(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildQuoteCard0() => Card(
        color: Colors.transparent,
        elevation: 8,
        shadowColor: Colors.black,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 12),
                  Text(
                    'Locations of the progress photos were taken at',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )
                ]),
          ),
        ),
      );

  Widget buildQuoteCard() => Card(
        color: Colors.transparent,
        elevation: 8,
        shadowColor: Colors.black,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'First Geopoint of the Image of the construction',
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Latitude ${lat1} Longitude ${long1}',
                    style: TextStyle(
                        fontSize: 24,
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
        child: Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'First Geopoint of the Image of the construction',
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Latitude ${lat2} Longitude ${long2}',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )
                ]),
          ),
        ),
      );

  Widget buildQuoteCard3() => Card(
        color: Colors.transparent,
        elevation: 8,
        shadowColor: Colors.black,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'First Geopoint of the Image of the construction',
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Latitude ${lat3} Longitude ${long3}',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  )
                ]),
          ),
        ),
      );
}
