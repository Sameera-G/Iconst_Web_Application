import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lconst/model/locationModel.dart';
import 'package:lconst/model/my_encryption.dart';
import 'package:lconst/model/user_model.dart';
import 'package:lconst/screens/multiuserlocation.dart';
import 'package:lconst/screens/userlist.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:universal_html/html.dart' as html;

// ignore: must_be_immutable
class UserData extends StatefulWidget {
  final String userInfo;
  UserData({Key? key, required this.userInfo});

  @override
  State<UserData> createState() => _UserDataState();
}

class _UserDataState extends State<UserData> {
  UserModel loggedInUser = UserModel();
  UserModel2 location = UserModel2();

  User? user = FirebaseAuth.instance.currentUser;

  var lat1, lat2, lat3, long1, long2, long3;

  String? downloadUrl;

  String fName = '', sName = '', mNumber = '', hAddress = '', eAddress = '';

  @override
  void initState() {
    //implement initState
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(widget.userInfo)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {
        fName = MyEncryptionDecryption.decryptionAES(loggedInUser.firstName);
        sName = MyEncryptionDecryption.decryptionAES(loggedInUser.secondName);
        mNumber =
            MyEncryptionDecryption.decryptionAES(loggedInUser.mobileNumber);
        hAddress =
            MyEncryptionDecryption.decryptionAES(loggedInUser.homeAddress);
        eAddress = loggedInUser.email!;
      });
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(widget.userInfo)
        .collection('collections')
        .doc('locationsdoc')
        .get()
        .then((value2) {
      location = UserModel2.fromMap(value2.data());
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
      appBar: AppBar(title: Text('${fName} ${sName}')),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/background2.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Card(
                    color: Colors.black38,
                    elevation: 8,
                    //shadowColor: Colors.black,
                    child: Container(
                      height: height,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Center(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: height * 0.5,
                                    child: Container(
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
                                    ),
                                  ),
                                  SizedBox(
                                    height: 25.0,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Name: ',
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            color: Colors.white),
                                      ),
                                      SizedBox(
                                        width: 10.0,
                                      ),
                                      Text(
                                        '$fName $sName',
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 1.0,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Contact Number: ',
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            color: Colors.white),
                                      ),
                                      SizedBox(
                                        width: 10.0,
                                      ),
                                      Text(
                                        '$mNumber',
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 25.0,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Home Address: ',
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            color: Colors.white),
                                      ),
                                      SizedBox(
                                        width: 10.0,
                                      ),
                                      Text(
                                        '$hAddress',
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 25.0,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Email Address: ',
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            color: Colors.white),
                                      ),
                                      SizedBox(
                                        width: 10.0,
                                      ),
                                      Text(
                                        '$eAddress',
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 25.0,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        'Loan Amount: ',
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            color: Colors.white),
                                      ),
                                      SizedBox(
                                        width: 10.0,
                                      ),
                                      Text(
                                        'Rs. 1,500,000.00',
                                        style: TextStyle(
                                            fontSize: 20.0,
                                            color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                width: 15.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Card(
                    color: Colors.black38,
                    elevation: 8,
                    //shadowColor: Colors.black,
                    child: SingleChildScrollView(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
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
                                          decoration: BoxDecoration(
                                              color: Colors.black
                                                  .withOpacity(0.6)),
                                          child: buildQuoteCard0(),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.black
                                                  .withOpacity(0.6)),
                                          child: buildQuoteCard(),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.black
                                                  .withOpacity(0.6)),
                                          child: buildQuoteCard2(),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.black
                                                  .withOpacity(0.6)),
                                          child: buildQuoteCard3(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                child: SingleChildScrollView(
                  child: Container(
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(15.0),
                          child: Card(
                            color: Colors.black54,
                            //shadowColor: Colors.amber,
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
                            //shadowColor: Colors.amber,
                            child: StreamBuilder(
                                stream: FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(widget.userInfo)
                                    .collection('progress_images')
                                    .snapshots(),
                                builder: (BuildContext context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (!snapshot.hasData) {
                                    return (const Center(
                                      child: Text('No Image Uploaded'),
                                    ));
                                  } else {
                                    return snapshot.data != null
                                        ? GridView.builder(
                                            padding: EdgeInsets.fromLTRB(
                                                15.0, 15.0, 15.0, 15.0),
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            shrinkWrap: true,
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 3,
                                              crossAxisSpacing: 5.0,
                                              mainAxisSpacing: 5.0,
                                            ),
                                            itemCount: 3,
                                            itemBuilder: (context, index) {
                                              String url = snapshot.data!
                                                  .docs[index]['downloadURL1'];
                                              return SizedBox(
                                                height: height,
                                                width: width,
                                                child: GestureDetector(
                                                  onTap: () async {
                                                    try {
                                                      // first we make a request to the url like you did
                                                      // in the android and ios version
                                                      final http.Response r =
                                                          await http.get(
                                                        Uri.parse(url),
                                                      );

                                                      // we get the bytes from the body
                                                      final data = r.bodyBytes;
                                                      // and encode them to base64
                                                      final base64data =
                                                          base64Encode(data);

                                                      // then we create and AnchorElement with the html package
                                                      final a = html.AnchorElement(
                                                          href:
                                                              'data:image/jpeg;base64,$base64data');

                                                      // set the name of the file we want the image to get
                                                      // downloaded to
                                                      a.download =
                                                          'download.jpg';

                                                      // and we click the AnchorElement which downloads the image
                                                      a.click();
                                                      // finally we remove the AnchorElement
                                                      a.remove();
                                                    } catch (e) {
                                                      print(e);
                                                    }
                                                  },
                                                  child: url != null
                                                      ? Image.network(
                                                          url,
                                                          fit: BoxFit.fill,
                                                          //height: height,
                                                        )
                                                      : Text(
                                                          'No Image uploaded'),
                                                ),
                                              );
                                            },
                                          )
                                        : Text('No Image available');

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
