//import 'package:flutter/foundation.dart';

class UserModel2 {
  String? img1lat;
  String? img1long;
  String? img2lat;
  String? img2long;
  String? img3lat;
  String? img3long;

  UserModel2(
      {this.img1lat,
      this.img1long,
      this.img2lat,
      this.img2long,
      this.img3lat,
      this.img3long});

//taking data from server
  factory UserModel2.fromMap(map) {
    return UserModel2(
      img1lat: map['img1lat'],
      img1long: map['img1long'],
      img2lat: map['img2lat'],
      img2long: map['img2long'],
      img3lat: map['img3lat'],
      img3long: map['img3long'],
    );
  }

  //sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'img1lat': img1lat,
      'img1long': img1long,
      'img2lat': img2lat,
      'img2long': img2long,
      'img3lat': img3lat,
      'img3long': img3long,
    };
  }
}
