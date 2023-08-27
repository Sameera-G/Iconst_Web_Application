import 'package:flutter/material.dart';

class ShowImg extends StatefulWidget {
  const ShowImg({super.key, required String text});
  @override
  State<ShowImg> createState() => _ShowImgState();
}

late String text = '';

class _ShowImgState extends State<ShowImg> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Construction Progress Images'),
      ),
      body: Center(
        child: Container(
          child: Image.network(text),
        ),
      ),
    );
  }
}
