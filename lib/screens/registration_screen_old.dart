import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lconst/model/my_encryption.dart';
import 'package:lconst/model/user_model.dart';
import 'package:lconst/screens/login_screen.dart';
import 'package:lconst/screens/verify.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  //form validation checking auth - then post the values to firestore
  final _auth = FirebaseAuth.instance;
  //form key defninig
  final _formKey = GlobalKey<FormState>();
  //controllers for the text fields
  final firstNameEditingController = TextEditingController();
  final secondNameEditingController = TextEditingController();
  final emailEditingController = TextEditingController();
  final homeAddressEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();
  final confirmPassEditingController = TextEditingController();
  final mobileEditingController = TextEditingController();
  var fName, sName, hAddress, mNumber, eMailEnc;

  //loding indicator
  bool loadingprogress = false;

  @override
  Widget build(BuildContext context) {
    //*********************************************************************************** */
    //first name text field design
    final firstNameField = TextFormField(
      autofocus: false,
      controller: firstNameEditingController,
      validator: (value) {
        RegExp regex = RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return ("First Name Cannot be empty");
        }
        if (!regex.hasMatch(value)) {
          return ("Please Enter a Valid Name (Min 3 Characters");
        }
        setState(() {
          fName = MyEncryptionDecryption.encryptionAES(value).base64;
        });
        return null;
      },
      onSaved: (value) {
        value = firstNameEditingController.text;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        prefixIcon: const Icon(
          Icons.account_circle,
        ),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: 'First Name',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
    //**************************************************************************** */
    //second name field design
    final secondNameField = TextFormField(
      autofocus: false,
      controller: secondNameEditingController,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Second Name Cannot be empty");
        }
        setState(() {
          sName = MyEncryptionDecryption.encryptionAES(value).base64;
        });
        return null;
      },
      onSaved: (value) {
        value = secondNameEditingController.text;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        prefixIcon: const Icon(
          Icons.account_circle_outlined,
        ),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: 'Second Name',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
    //****************************************************************************** */
    // email controller design
    final emailField = TextFormField(
      autofocus: false,
      controller: emailEditingController,
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Please Enter Your Email");
        }
        // reg expression for email validation
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
          return ("Please Enter a valid email");
        }
        setState(() {
          eMailEnc = MyEncryptionDecryption.encryptionAES(value).base64;
        });
        return null;
      },
      onSaved: (value) {
        value = emailEditingController.text;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        prefixIcon: const Icon(
          Icons.email,
        ),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: 'Email',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
    //************************************************************************* */
    //home address
    final homeAddressField = TextFormField(
      autofocus: false,
      controller: homeAddressEditingController,
      validator: (value) {
        RegExp regex = RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return ("Address Cannot be empty");
        }
        if (!regex.hasMatch(value)) {
          return ("Please Enter a Valid Address");
        }
        setState(() {
          hAddress = MyEncryptionDecryption.encryptionAES(value).base64;
        });
        return null;
      },
      onSaved: (value) {
        value = homeAddressEditingController.text;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        prefixIcon: const Icon(
          Icons.account_circle,
        ),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: 'Home Address',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
    //******************************************************* */
    //mobile number
    final mobileNumberField = TextFormField(
      autofocus: false,
      controller: mobileEditingController,
      validator: (value) {
        RegExp regex = RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return ("Mobile Number Cannot be empty");
        }
        if (!regex.hasMatch(value)) {
          return ("Please Enter a Valid Mobile Number");
        }
        setState(() {
          mNumber = MyEncryptionDecryption.encryptionAES(value).base64;
        });
        return null;
      },
      onSaved: (value) {
        value = mobileEditingController.text;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        prefixIcon: const Icon(
          Icons.account_circle,
        ),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: 'Mobile Number',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
    //password field design
    final passwordField = TextFormField(
      autofocus: false,
      controller: passwordEditingController,
      obscureText: true,
      validator: (value) {
        RegExp regex = RegExp(r'^.{6,}$');
        if (value!.isEmpty) {
          return ("Please Enter your Password");
        }
        if (!regex.hasMatch(value)) {
          return ("Please Enter a Valid Password (Min 6 Characters");
        }
        return null;
      },
      onSaved: (value) {
        passwordEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        prefixIcon: const Icon(
          Icons.password,
        ),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: 'Password',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
    //****************************************************************************** */
    //confirm password field design
    final confirmPasswordField = TextFormField(
      autofocus: false,
      controller: confirmPassEditingController,
      obscureText: true,
      validator: (value) {
        if (confirmPassEditingController.text !=
            passwordEditingController.text) {
          return "Password Do not Match";
        }
        return null;
      },
      onSaved: (value) {
        confirmPassEditingController.text = value!;
      },
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        prefixIcon: const Icon(
          Icons.password_outlined,
        ),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: 'Confirm Password',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
    //**************************************************************************** */
    //sign up button
    final signUpButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      //button color
      color: Colors.amber,
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          signUp(emailEditingController.text, passwordEditingController.text);
        },
        child: const Text(
          'Sign Up',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
    //****************************************************************************** */
    //design
    //double height = MediaQuery.of(context).size.height;
    return Scaffold(
      //backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Registration Form'),
      ),
      body: Center(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/background2.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          //margin: const EdgeInsets.all(30),
          //color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    //top logo of the bank
                    SizedBox(
                      height: 200,
                      child: Image.asset('images/logom.png'),
                    ),
                    const SizedBox(
                      height: 40.0,
                    ),
                    firstNameField,
                    const SizedBox(
                      height: 20.0,
                    ),
                    secondNameField,
                    const SizedBox(
                      height: 20.0,
                    ),
                    emailField,
                    const SizedBox(
                      height: 20.0,
                    ),
                    homeAddressField,
                    const SizedBox(
                      height: 20.0,
                    ),
                    mobileNumberField,
                    const SizedBox(
                      height: 20.0,
                    ),
                    passwordField,
                    const SizedBox(
                      height: 20.0,
                    ),
                    confirmPasswordField,
                    const SizedBox(
                      height: 20.0,
                    ),
                    loadingprogress
                        ? const CircularProgressIndicator(
                            color: Colors.amber,
                            backgroundColor: Color.fromARGB(255, 243, 240, 240),
                            strokeWidth: 5.0,
                          )
                        : signUpButton,
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already Have an Account?',
                          style: TextStyle(color: Colors.white),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen())),
                          child: Text('Login Here!'),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text(
                          "Want to know more? ",
                          style: TextStyle(color: Colors.white),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const RegistrationScreen()));
                          },
                          child: const Text(
                            'Terms & Conditions',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.w600,
                              fontSize: 15.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void signUp(String email, String password) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        loadingprogress = true;
      });
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) => {postDetailsToFirestore()})
          .catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
        setState(() {
          loadingprogress = false;
        });
      });
      setState(() {
        loadingprogress = false;
      });
    }
  }

  postDetailsToFirestore() async {
    //calling our firestore
    //callingn our user model
    //sending these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    UserModel userModel = UserModel();
    //wrting all the values

    //encrypting
    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.firstName = fName.toString();
    userModel.secondName = sName.toString();
    userModel.homeAddress = hAddress.toString();
    userModel.mobileNumber = mNumber.toString();

    /*userModel.email = user!.email;
    userModel.homeAddress = userModel.uid = user.uid;
    userModel.firstName = firstNameEditingController.text;
    userModel.secondName = secondNameEditingController.text;
    userModel.homeAddress = homeAddressEditingController.text;
    userModel.mobileNumber = mobileEditingController.text;*/

    //add to database

    await firebaseFirestore
        .collection("users")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Please Verify you Email :)");
    Navigator.pushReplacement(
        (context), MaterialPageRoute(builder: (context) => Verification()));
    //(route) => false);
  }
}
