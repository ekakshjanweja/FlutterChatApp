import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? email;
  String? name;
  String? imageUrl;
  String? uid;
  String? phoneNumber;
  Timestamp? date;

  UserModel({
    required this.email,
    required this.name,
    required this.imageUrl,
    required this.uid,
    required this.phoneNumber,
    required this.date,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    imageUrl = json['imageUrl'];
    uid = json['uid'];
    phoneNumber = json['phoneNumber'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['name'] = name;
    data['imageUrl'] = imageUrl;
    data['uid'] = uid;
    data['phoneNumber'] = phoneNumber;
    data['date'] = date;

    return data;
  }
}

  
  

  // factory UserModel.fromJson(DocumentSnapshot snapshot) {
  //   return UserModel(
  //     email: snapshot['email'],
  //     name: snapshot['name'],
  //     imageUrl: snapshot['imageUrl'],
  //     uid: snapshot['uid'],
  //     phoneNumber: snapshot['phoneNumber'],
  //     date: snapshot['date'],
  //   );
  // }

