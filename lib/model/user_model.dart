//import 'package:flutter/foundation.dart';

class UserModel {
  String? uid;
  String? email;
  String? firstName;
  String? secondName;
  String? homeAddress;
  String? mobileNumber;
  /*String? img1lat;
  String? img1long;
  String? img2lat;
  String? img2long;
  String? img3lat;
  String? img3long;*/

  UserModel({
    this.uid,
    this.email,
    this.firstName,
    this.secondName,
    this.homeAddress,
    this.mobileNumber,
    /*this.img1lat,
      this.img1long,
      this.img2lat,
      this.img2long,
      this.img3lat,
      this.img3long*/
  });

//taking data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      firstName: map['firstName'],
      secondName: map['secondName'],
      homeAddress: map['homeAddress'],
      mobileNumber: map['mobileNumber'],
      /*img1lat: map[' img1lat'],
      img1long: map['img1long'],
      img2lat: map['img2lat'],
      img2long: map['img2long'],
      img3lat: map['img3lat'],
      img3long: map['img3long'],*/
    );
  }

  get location => null;

  //sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'secondName': secondName,
      'homeAddress': homeAddress,
      'mobileNumber': mobileNumber,
      /*'img1lat': img1lat,
      'img1long': img1long,
      'img2lat': img2lat,
      'img2long': img2long,
      'img3lat': img3lat,
      'img3long': img3long,*/
    };
  }
}
