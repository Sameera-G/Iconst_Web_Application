import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lconst/model/my_encryption.dart';
import 'package:lconst/model/user_model.dart';
import 'package:lconst/screens/home_screen.dart';
import 'package:lconst/screens/individualdata.dart';

class UserList extends StatefulWidget {
  const UserList({super.key});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  String? firstName, name;
  late List<String> _allResults;

  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('users').snapshots();

  @override
  void initState() {
    super.initState();
  }

  getUsersPastTripsStreamSnapshots() async {
    var data = await FirebaseFirestore.instance
        .collection('users')
        .where("firtName", isGreaterThanOrEqualTo: firstName)
        .get();
    setState(() {
      _allResults = data.docs.cast<String>();
    });
    return _allResults;
  }

  /*getUserData() async {
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
  }*/

  QuerySnapshot<Object>? data;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Registered Users'),
      ),
      body: Container(
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
                    color: Colors.black38,
                    elevation: 8,
                    //shadowColor: Colors.black,
                    child: Container(
                      width: width,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        image: DecorationImage(
                          image: NetworkImage(
                              'https://images.unsplash.com/photo-1554752191-b9e763720f91?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=873&q=80'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: null,
                    ),
                  ),
                ),
                /* Card(
                  color: Colors.black38,
                  elevation: 8,
                  //shadowColor: Colors.black,
                  child: Container(
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("images/logom.png"),
                                fit: BoxFit.cover,
                              ),
                              color: Colors.transparent,
                            ),
                          ),
                          /* TextField(
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.search),
                              hintText: 'search...',
                            ),
                            onChanged: (val) {
                              setState(() {
                                firstName = val;
                              });
                            },
                          ), */
                        ],
                      ),
                    ),
                  ),
                ),  */
                Expanded(
                  child: Card(
                    color: Colors.black54,
                    elevation: 8,
                    //shadowColor: Colors.black,
                    child: Container(
                      width: width,
                      decoration: BoxDecoration(
                        color: Colors.transparent,
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
                                  color: Colors.white,
                                  fontSize: 30.0,
                                ),
                                textAlign: TextAlign.justify,
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
              stream: _usersStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                return ListView(
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;
                    return Card(
                      color: Colors.black38,
                      elevation: 8,
                      //shadowColor: Colors.black,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.transparent,
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
                                title: Text(
                                  MyEncryptionDecryption.decryptionAES(
                                      data['firstName'].toString()),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                  ),
                                ),
                                subtitle: Text(
                                  MyEncryptionDecryption.decryptionAES(
                                      data['secondName'].toString()),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20.0,
                                  ),
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => UserData(
                                              userInfo:
                                                  data['uid'].toString())));
                                  print(data);
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
            ),
            /*Card(
              color: Colors.black38,
              elevation: 8,
              //shadowColor: Colors.black,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                ),
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 5),
                      Text(''),
                    ],
                  ),
                ),
              ),
            ),*/
            /*StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('users').snapshots(),
              builder: (context, snapshot) {
                return (snapshot.connectionState == ConnectionState.waiting)
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        itemCount: snapshot.data?.docs.length,
                        itemBuilder: ((context, index) {
                          var data = snapshot.data!.docs[index].data()
                              as Map<String, dynamic>;
                          if (firstName!.isEmpty) {
                            return ListTile(
                              title: Text(
                                MyEncryptionDecryption.decryptionAES(
                                    data['firstName'].toString()),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(
                                    'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80'), // put a background image
                              ),
                            );
                          }
                          if (data['firstName']
                              .toString()
                              .toLowerCase()
                              .contains(firstName!.toLowerCase())) {
                            GestureDetector(
                              onTap: () {
                                print(data['mobileNumber'].toString());
                              },
                              child: ListTile(
                                title: Text(
                                  MyEncryptionDecryption.decryptionAES(
                                      data['firstName'].toString()),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=387&q=80'), // put a background image
                                ),
                              ),
                            );
                          }
                          return Container();
                        }));
              },
            ),*/

            /*SingleChildScrollView(
              child: ListView.builder(
                itemCount: items.length,
                itemBuilder: (context, index) {
                  return Card(
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
                            ListTile(
                      title: Text(''),
                      subtitle: Text(MyEncryptionDecryption.decryptionAES(
                          data['firstName'].toString())),
                    );
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}
