//to upload the progress images with location
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lconst/model/my_encryption.dart';
import 'package:lconst/model/user_model.dart';
import 'package:lconst/screens/phnverfyaddoc.dart';
//import 'package:lconst/screens/phoneverifi.dart';

class ProgressUpload extends StatefulWidget {
  const ProgressUpload({
    Key? key,
  }) : super(key: key);

  @override
  State<ProgressUpload> createState() => _ProgressUploadState();
}

class _ProgressUploadState extends State<ProgressUpload> {
  //geotagging
  String location = 'Null, Press Button';
  String location2 = 'Null, Press Button';
  String location3 = 'Null, Press Button';
  String address = 'search';
  String address2 = 'search';
  String address3 = 'search';
  Position? position;
  Position? position1;
  Position? position3;
  bool loadingprogress = false;
  bool loadingprogress2 = false;
  bool loadingprogress3 = false;
  late String lat1, long1;
  late String lat2, long2;
  late String lat3, long3;
  String? downloadURL1, downloadURL2, downloadURL3;

  //Geolocator getter codes
  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
  }

  Future<Position> determinePosition2() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
  }

  Future<Position> determinePosition3() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
  }

  //gps finished

  //file assigning
  File? image, image2, image3;

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

  //pick image methods*******************************************************
  //image1*******************************************
  Future pickImage() async {
    setState(() {
      loadingprogress = true;
    });
    try {
      final image = await ImagePicker().pickImage(
        source: ImageSource.camera,
        imageQuality: 60,
      );

      if (image == null) return;

      final imageTemp = File(image.path);

      setState(() {
        this.image = imageTemp;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
    setState(() {
      loadingprogress = false;
    });
  }

  //image 2***********************************************************
  Future pickImage2() async {
    setState(() {
      loadingprogress2 = true;
    });
    try {
      final image2 = await ImagePicker().pickImage(
        source: ImageSource.camera,
        imageQuality: 60,
      );

      if (image2 == null) return;

      final imageTemp2 = File(image2.path);

      setState(() {
        this.image2 = imageTemp2;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
    setState(() {
      loadingprogress2 = false;
    });
  }

  //image 3*************************************************************
  Future pickImage3() async {
    setState(() {
      loadingprogress3 = true;
    });
    try {
      final image3 = await ImagePicker().pickImage(
        source: ImageSource.camera,
        imageQuality: 60,
      );

      if (image3 == null) return;

      final imageTemp3 = File(image3.path);

      setState(() {
        this.image3 = imageTemp3;
      });
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
    setState(() {
      loadingprogress3 = false;
    });
  }

  //getting the address of the position
  //address 1************************************
  Future<void> getAddressFromLatLong(Position position) async {
    List<Placemark> placemark =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    //print(placemark);
    Placemark place = placemark[1];
    address =
        '${place.street}, ${place.subAdministrativeArea}, ${place.administrativeArea}';
    setState(() {});
  }

  //addrss2************************************
  Future<void> getAddressFromLatLong2(Position position) async {
    List<Placemark> placemark =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    //print(placemark);
    Placemark place = placemark[1];
    address2 =
        '${place.street}, ${place.subAdministrativeArea}, ${place.administrativeArea}';
    setState(() {});
  }

  //address 3*****************************************************************
  Future<void> getAddressFromLatLong3(Position position) async {
    List<Placemark> placemark =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    //print(placemark);
    Placemark place = placemark[1];
    address3 =
        '${place.street}, ${place.subAdministrativeArea}, ${place.administrativeArea}';
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
              indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(5), // Creates border
                  color: Colors.redAccent),
              tabs: [
                Tab(
                    icon: image == null
                        ? Icon(Icons.photo_camera)
                        : Icon(Icons.done)),
                Tab(
                    icon: image2 == null
                        ? Icon(Icons.photo_camera)
                        : Icon(Icons.done)),
                Tab(
                    icon: image3 == null
                        ? Icon(Icons.photo_camera)
                        : Icon(Icons.done)),
                Tab(icon: Icon(Icons.upload)),
              ]),
          title: const Text('Upload Progress Images'),
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
              //First image *********************************************************
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: height * 0.03,
                        child: Text(
                          'Select your First Image Here!',
                          style: TextStyle(fontSize: 15.0, color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      TextButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.red)),
                        onPressed: (() => pickImage()),
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    child: SizedBox(
                      height: height * 0.6,
                      child: image != null
                          ? Image.file(image!)
                          : Container(
                              decoration: BoxDecoration(color: Colors.red[200]),
                              width: double.infinity,
                              //height: checkheight,
                              child: IconButton(
                                color: Colors.grey[800],
                                onPressed: () async {
                                  pickImage();
                                  Position position = await determinePosition();
                                  lat1 = position.latitude.toString();
                                  long1 = position.longitude.toString();

                                  /*lat1 = MyEncryptionDecryption.encryptionAES(
                                          position.latitude.toString())
                                      .base64;
                                  long1 = MyEncryptionDecryption.encryptionAES(
                                          position.longitude.toString())
                                      .base64;*/

                                  location =
                                      'Lat: ${position.latitude}, Long: ${position.longitude}';
                                  getAddressFromLatLong(position);
                                },
                                icon: Icon(
                                  Icons.add_a_photo,
                                ),
                              ),
                            ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Center(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'GPS Location',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            Text(
                              location,
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                'Address',
                                style: TextStyle(color: Colors.white),
                              ),
                              const SizedBox(
                                width: 10.0,
                              ),
                              Text(
                                address,
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                ],
              ),
              //Second Image ******************************************************
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: height * 0.03,
                        child: Text(
                          'Select your Second Image Here!',
                          style: TextStyle(fontSize: 15.0, color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      TextButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.red)),
                        onPressed: (() => pickImage2()),
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    child: SizedBox(
                      height: height * 0.6,
                      child: image2 != null
                          ? Image.file(image2!)
                          : Container(
                              decoration: BoxDecoration(color: Colors.red[200]),
                              width: double.infinity,
                              //height: checkheight,
                              child: IconButton(
                                  color: Colors.grey[800],
                                  onPressed: () async {
                                    pickImage2();
                                    Position position1 =
                                        await determinePosition2();
                                    lat2 = position1.latitude.toString();
                                    long2 = position1.longitude.toString();

                                    /*lat2 = MyEncryptionDecryption.encryptionAES(
                                            position1.latitude.toString())
                                        .base64;
                                    long2 =
                                        MyEncryptionDecryption.encryptionAES(
                                                position1.longitude.toString())
                                            .base64;*/

                                    location2 =
                                        'Lat: ${position1.latitude}, Long: ${position1.longitude}';
                                    getAddressFromLatLong2(position1);
                                  },
                                  icon: Icon(
                                    Icons.add_a_photo,
                                  )),
                            ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Center(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'GPS Location',
                              style: TextStyle(color: Colors.white),
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            Text(
                              location2,
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                'Address',
                                style: TextStyle(color: Colors.white),
                              ),
                              const SizedBox(
                                width: 10.0,
                              ),
                              Text(
                                address2,
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                ],
                //Third Image *****************************************************
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: height * 0.03,
                        child: Text(
                          'Select your Third Image Here!',
                          style: TextStyle(fontSize: 15.0, color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      TextButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.red)),
                        onPressed: (() => pickImage3()),
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    child: SizedBox(
                      height: height * 0.6,
                      child: image3 != null
                          ? Image.file(image3!)
                          : Container(
                              decoration: BoxDecoration(color: Colors.red[200]),
                              width: double.infinity,
                              //height: checkheight,
                              child: IconButton(
                                  color: Colors.grey[800],
                                  onPressed: () async {
                                    pickImage3();
                                    Position position3 =
                                        await determinePosition3();
                                    lat3 = position3.latitude.toString();
                                    long3 = position3.longitude.toString();

                                    /*lat3 = MyEncryptionDecryption.encryptionAES(
                                            position3.latitude.toString())
                                        .base64;
                                    long3 =
                                        MyEncryptionDecryption.encryptionAES(
                                                position3.longitude.toString())
                                            .base64;*/

                                    location3 =
                                        'Lat: ${position3.latitude}, Long: ${position3.longitude}';
                                    getAddressFromLatLong3(position3);
                                  },
                                  icon: Icon(
                                    Icons.add_a_photo,
                                  )),
                            ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Center(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text(
                              'GPS Location',
                              style: TextStyle(color: Colors.white),
                            ),
                            const SizedBox(
                              width: 10.0,
                            ),
                            Text(
                              location3,
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                'Address',
                                style: TextStyle(color: Colors.white),
                              ),
                              const SizedBox(
                                width: 10.0,
                              ),
                              Text(
                                address3,
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                ],
              ),
              //Upload Button starts here ***************************************
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50.0,
                  ),
                  Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(15.0)),
                      child: Card(
                        shadowColor: Colors.black,
                        color: Colors.black.withOpacity(0.6),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0)),
                          padding: EdgeInsets.all(10.0),
                          child: Text(
                            'After Selecting 3 Photos of your construction, please click the Upload Button. To make it visible, first you have to select all three photos',
                            style:
                                TextStyle(fontSize: 30.0, color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  image3 == null || image2 == null || image == null
                      ? const CircularProgressIndicator(
                          color: Colors.amber,
                          backgroundColor: Color.fromARGB(255, 243, 240, 240),
                          strokeWidth: 5.0,
                        )
                      : ElevatedButton(
                          onPressed: () async {
                            uploadImage1();
                            await Future.delayed(
                                const Duration(milliseconds: 500));
                            uploadImage2();
                            await Future.delayed(
                                const Duration(milliseconds: 500));
                            uploadImage3();
                            updateLocation();
                            //navigator
                            /*Navigator.pushReplacement(
                                (context),
                                MaterialPageRoute(
                                    builder: (context) => PhoneVerifi(
                                        phNumber: FirebaseAuth.instance
                                            .currentUser!.phoneNumber)));*/
                            Navigator.push(
                                (context),
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const PhoneVerifiAdDoc()));

                            print(position);
                          },
                          child: const Text(
                            'Upload Image',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                  SizedBox(
                    height: 50.0,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  FirebaseFirestore locations = FirebaseFirestore.instance;

  Future<void> updateLocation() {
    //encryption of data
    String elat1 = MyEncryptionDecryption.encryptionAES(lat1).base64;
    String elong1 = MyEncryptionDecryption.encryptionAES(long1).base64;
    String elat2 = MyEncryptionDecryption.encryptionAES(lat1).base64;
    String elong2 = MyEncryptionDecryption.encryptionAES(long1).base64;
    String elat3 = MyEncryptionDecryption.encryptionAES(lat1).base64;
    String elong3 = MyEncryptionDecryption.encryptionAES(long1).base64;
    // Call the user's CollectionReference to add a new user
    return locations
        .collection('users')
        .doc(loggedInUser.uid)
        .collection('collections')
        .doc('locationsdoc')
        .set({
          'img1lat': elat1,
          'img1long': elong1,
          'img2lat': elat2,
          'img2long': elong2,
          'img3lat': elat3,
          'img3long': elong3,
        })
        .then((value) => Fluttertoast.showToast(msg: "Confirm the OTP"))
        .catchError((error) => Fluttertoast.showToast(msg: "$error"));
  }

  //nw method of uploading images to firebase
  Future uploadImage1() async {
    final postID = DateTime.now().toString();
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    Reference ref = FirebaseStorage.instance
        .ref()
        .child('users/${loggedInUser.uid}/progress_images')
        .child('post_$postID');
    await ref.putFile(image!);
    downloadURL1 = await ref.getDownloadURL();
    print(downloadURL1);
    await firebaseFirestore
        .collection('users')
        .doc(loggedInUser.uid)
        .collection('progress_images')
        .add({
      'downloadURL1': downloadURL1,
    });
  }

  Future uploadImage2() async {
    final postID = DateTime.now().toString();
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    Reference ref = FirebaseStorage.instance
        .ref()
        .child('users/${loggedInUser.uid}/progress_images')
        .child('post_$postID');
    await ref.putFile(image2!);
    downloadURL2 = await ref.getDownloadURL();
    print(downloadURL2);
    await firebaseFirestore
        .collection('users')
        .doc(loggedInUser.uid)
        .collection('progress_images')
        .add({'downloadURL1': downloadURL2});
  }

  Future uploadImage3() async {
    final postID = DateTime.now().toString();
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    Reference ref = FirebaseStorage.instance
        .ref()
        .child('users/${loggedInUser.uid}/progress_images')
        .child('post_$postID');
    await ref.putFile(image3!);
    downloadURL3 = await ref.getDownloadURL();
    print(downloadURL3);
    await firebaseFirestore
        .collection('users')
        .doc(loggedInUser.uid)
        .collection('progress_images')
        .add({'downloadURL1': downloadURL3});
  }
}
