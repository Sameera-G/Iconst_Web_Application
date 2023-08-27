import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lconst/model/my_encryption.dart';
import 'package:lconst/model/user_model.dart';
import 'package:lconst/screens/home_screen.dart';

class UploadComplete extends StatefulWidget {
  const UploadComplete({Key? key}) : super(key: key);

  @override
  State<UploadComplete> createState() => _YourProfileState();
}

class _YourProfileState extends State<UploadComplete> {
  //get data from the database
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  var _fName, _sName;

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
        _fName = MyEncryptionDecryption.decryptionAES(loggedInUser.firstName);
        _sName = MyEncryptionDecryption.decryptionAES(loggedInUser.secondName);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final backToHome = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      //button color
      color: Colors.amber,
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          Navigator.pushReplacement((context),
              MaterialPageRoute(builder: (context) => const HomeScreen()));
        },
        child: const Text(
          'Go Back to Home Screen',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('My Profile'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/background2.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(
                    height: 50.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      //**************************************************** */
                      //profile information
                      const Text(
                        "Hi! ",
                        style: TextStyle(
                          fontSize: 30.0,
                          color: Colors.white,
                        ),
                      ),
                      Flexible(
                        child: Text(
                          '${_fName} ${_sName}',
                          style: const TextStyle(
                            fontSize: 30.0,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  const Text(
                    "Thank you for Uploading",
                    style: TextStyle(
                      fontSize: 30.0,
                      color: Colors.white,
                    ),
                  ),
                  //******************************************************* */
                  // email

                  const SizedBox(
                    height: 20.0,
                  ),
                  //******************************************* */
                  //address
                  backToHome,
                  const SizedBox(
                    height: 20.0,
                  ),
                  //profile information tables finished here
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
