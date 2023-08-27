import 'package:flutter/material.dart';

class Instructions extends StatefulWidget {
  const Instructions({Key? key}) : super(key: key);

  @override
  State<Instructions> createState() => _InstructionsState();
}

class _InstructionsState extends State<Instructions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Instructions'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/background2.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                buildQuoteCard0(),
                SizedBox(
                  height: 20.0,
                ),
                buildQuoteCard1(),
                SizedBox(
                  height: 20.0,
                ),
                buildQuoteCard2(),
                SizedBox(
                  height: 20.0,
                ),
                buildQuoteCard3(),
                SizedBox(
                  height: 20.0,
                ),
                buildQuoteCard4(),
                SizedBox(
                  height: 20.0,
                ),
                buildQuoteCard5(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget buildQuoteCard0() => Card(
      elevation: 8,
      shadowColor: Colors.amber,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            const SizedBox(height: 12),
            Text(
              'Instructions for using this App',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            )
          ]),
        ),
      ),
    );

Widget buildQuoteCard1() => Card(
      elevation: 8,
      shadowColor: Colors.amber,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Text(
              'Step 1',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 12),
            Text(
              'First, Sign up adding your information!. You will have to verify your email address. Click the link in the email you receive to your inbox.',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            )
          ]),
        ),
      ),
    );

Widget buildQuoteCard2() => Card(
      elevation: 8,
      shadowColor: Colors.amber,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Text(
              'Step 2',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 12),
            Text(
              'Go to Progress Upload Page and upload 3 photos of your construction, then you will be redirected to OTP verification page. Then verify your mobile phone adding the phone number and the OTP after it is received.',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            )
          ]),
        ),
      ),
    );

Widget buildQuoteCard3() => Card(
      elevation: 8,
      shadowColor: Colors.amber,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Text(
              'Step 3',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 12),
            Text(
              'After that, you will be redirected to the home screen, Then you can upload any additional documents you have like BOQs and Estimates. Then again, you will be redirected to the OTP verification window, then verify th phone number as explained in the above.',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            )
          ]),
        ),
      ),
    );

Widget buildQuoteCard4() => Card(
      elevation: 8,
      shadowColor: Colors.amber,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Text(
              'Step 4',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 12),
            Text(
              'You can view your uploaded data in the Your Profile page. A bank officer will check your information and contact you for the process',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            )
          ]),
        ),
      ),
    );

Widget buildQuoteCard5() => Card(
      elevation: 8,
      shadowColor: Colors.amber,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Text(
              'Additional information',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 12),
            Text(
              'Please make sure to switch on the Location services of yor mobile phone when prompted, your location will upload to the bank automatically',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            )
          ]),
        ),
      ),
    );

Widget buildQuoteCard6() => Card(
      elevation: 8,
      shadowColor: Colors.amber,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Text(
              'Incase you Forgot Password',
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 12),
            Text(
              'Click the forgot password link blow the password typing field in the login screen, then put your registered mobile number, then confirm the OTP you receive to your mobile number. Then you will be redirected to the password change request form, then add your registered Email and click the Reset button. Then you will receive an email to your email with the password reset link. Click that link and add your new password.',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            )
          ]),
        ),
      ),
    );
