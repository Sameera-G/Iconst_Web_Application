import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lconst/model/my_encryption.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String? name;
  CollectionReference _firebaseFirestore =
      FirebaseFirestore.instance.collection('users');
  User? snapshots = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("images/background2.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: GridView.count(
          primary: false,
          padding: const EdgeInsets.all(10),
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          crossAxisCount: 2,
          children: [
            Column(
              children: [
                Expanded(
                  child: Card(
                    color: Colors.black54,
                    elevation: 8,
                    //shadowColor: Colors.black,
                    child: Container(
                      width: width,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("images/logom.png"),
                          fit: BoxFit.none,
                        ),
                        //color: Colors.transparent,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 5),
                            TextField(
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.search),
                                hintText: 'search...',
                              ),
                              onChanged: (val) {
                                setState(() {
                                  name = val;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Card(
                    color: Colors.black54,
                    elevation: 8,
                    //shadowColor: Colors.black,
                    child: Container(
                      width: width,
                      decoration: BoxDecoration(
                          //color: Colors.transparent,
                          ),
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 5),
                            Padding(
                              padding: EdgeInsets.all(15.0),
                              child: Text(
                                "Welcome to the customer view section. In this section, all the registered customers can be seen. Click on oen of the customers' name to see their progress photo locations and the uploaded additional documents. For more information on the system, please call the system administrator.",
                                style: TextStyle(
                                    fontSize: 30.0, color: Colors.white),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            StreamBuilder<QuerySnapshot>(
                stream: (name == null || name!.trim() == "")
                    ? FirebaseFirestore.instance.collection('users').snapshots()
                    : FirebaseFirestore.instance
                        .collection('users')
                        .where('users', isGreaterThanOrEqualTo: name)
                        .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    print(snapshot.data);
                    return ListView(
                      children:
                          snapshot.data!.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic> data =
                            document.data()! as Map<String, dynamic>;
                        return Card(
                          color: Colors.black54,
                          elevation: 8,
                          //shadowColor: Colors.black,
                          child: Container(
                            decoration: BoxDecoration(
                                //color: Colors.transparent,
                                ),
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const SizedBox(height: 5),
                                  ListTile(
                                    leading: Icon(
                                      Icons.verified_user,
                                      color: Colors.white,
                                    ),
                                    trailing: IconButton(
                                        onPressed: () {
                                          data.clear();
                                        },
                                        icon: Icon(Icons.delete)),
                                    title: Row(
                                      children: [
                                        Text(
                                          MyEncryptionDecryption.decryptionAES(
                                              document['firstName'].toString()),
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        SizedBox(
                                          width: 10.0,
                                        ),
                                        Text(
                                          MyEncryptionDecryption.decryptionAES(
                                              document['secondName']
                                                  .toString()),
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ],
                                    ),
                                    subtitle: Text(
                                      MyEncryptionDecryption.decryptionAES(
                                          document['homeAddress'].toString()),
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onTap: () {
                                      snapshots =
                                          FirebaseAuth.instance.currentUser;
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  }
                }),

            /*StreamBuilder<QuerySnapshot>(
                stream: _firebaseFirestore.snapshots().asBroadcastStream(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    print(snapshot.data);
                    return ListView(children: [
                      ...snapshot.data!.docs
                          .where((QueryDocumentSnapshot<Object?> element) =>
                              element['firstName']
                                  .toString()
                                  .toLowerCase()
                                  .contains(name!.toLowerCase()))
                          .map((QueryDocumentSnapshot<Object?> data) {
                        final String title = data.get('firstName');
                        final String stitle = data.get('secondName');
                        final String number = data.get('phoneNumber');
    
                        return ListTile(
                          onTap: () {},
                          title:
                              Text(MyEncryptionDecryption.decryptionAES(title)),
                          leading: CircleAvatar(
                            backgroundColor: Colors.amber,
                          ),
                          subtitle:
                              Text(MyEncryptionDecryption.decryptionAES(stitle)),
                        );
                      })
                    ]);
                  }
                })*/
          ]),
    );
  }
}
