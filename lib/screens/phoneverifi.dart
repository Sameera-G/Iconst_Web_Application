import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lconst/screens/progress_complete.dart';

class PhoneVerifi extends StatefulWidget {
  const PhoneVerifi({super.key, String? phNumber});

  @override
  State<PhoneVerifi> createState() => _PhoneVerifiState();
}

String? phNumber;

class _PhoneVerifiState extends State<PhoneVerifi> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController otpCodeController = TextEditingController();

  //firebase
  FirebaseAuth _auth = FirebaseAuth.instance;

  String verificationIDReceived = '';
  bool otpCodeVisible = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Verify your Phone Number'),
      ),
      body: Container(
        height: height,
        width: width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/background2.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        //margin: const EdgeInsets.all(15),
        child: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  color: Colors.transparent,
                  elevation: 8,
                  shadowColor: Colors.black,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(30, 15, 30, 15),
                    child: TextField(
                      cursorColor: Colors.white,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                      ),
                      controller: phoneController,
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white, width: 3.0),
                        ),
                        labelText: 'Phone Number',
                        labelStyle: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                  ),
                ),
                SizedBox(
                  height: 7.0,
                ),
                Visibility(
                  visible: otpCodeVisible,
                  child: Card(
                    color: Colors.transparent,
                    elevation: 8,
                    shadowColor: Colors.black,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(30, 15, 30, 15),
                      child: TextField(
                        cursorColor: Colors.white,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.0,
                        ),
                        controller: otpCodeController,
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 3.0),
                          ),
                          labelText: 'OTP',
                          labelStyle: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        keyboardType: TextInputType.phone,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.0),
                ElevatedButton(
                  onPressed: () {
                    if (otpCodeVisible) {
                      verifyCode();
                    } else {
                      verifyNumber();
                    }
                  },
                  child: Text(
                    otpCodeVisible ? 'Upload Confirm' : 'Get OTP',
                    style: TextStyle(fontSize: 24.0),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void verifyNumber() async {
    _auth.verifyPhoneNumber(
        phoneNumber: phoneController.text.trim(),
        verificationCompleted: (PhoneAuthCredential credential) async {
          if (_auth.currentUser!.phoneNumber.toString() == phNumber) {
            Navigator.pushReplacement((context),
                MaterialPageRoute(builder: (context) => UploadComplete()));
            Fluttertoast.showToast(
                    msg: "Locations and Photos Uploaded Successfully!")
                .catchError((error) => Fluttertoast.showToast(msg: "$error"));
          }
          /*await _auth.signInWithCredential(credential).then((value) {
            print('you are logged in');
            Navigator.pushReplacement((context),
                MaterialPageRoute(builder: (context) => UploadComplete()));
          });*/
        },
        verificationFailed: (FirebaseAuthException exception) {
          print(exception.message);
        },
        codeSent: (String verificationId, int? resendToken) {
          verificationIDReceived = verificationId;
          otpCodeVisible = true;
          setState(() {});
        },
        codeAutoRetrievalTimeout: (String verificationID) {});
  }

  void verifyCode() async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationIDReceived,
        smsCode: otpCodeController.text);
    if (credential.smsCode == otpCodeController.text &&
        credential.verificationId == verificationIDReceived) {
      Navigator.pushReplacement(
          (context), MaterialPageRoute(builder: (context) => UploadComplete()));
      Fluttertoast.showToast(msg: "Locations and Photos Uploaded Successfully!")
          .catchError((error) => Fluttertoast.showToast(msg: "$error"));
    }
    /*await _auth.signInWithCredential(credential).then((value) {
      print('You are logged in');
      Navigator.pushReplacement(
          (context), MaterialPageRoute(builder: (context) => UploadComplete()));
    });*/
  }
}
