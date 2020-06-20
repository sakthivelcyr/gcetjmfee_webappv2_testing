import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gcetjmfee_webappv2/stu_record.dart';
import 'package:gcetjmfee_webappv2/style.dart';
import 'package:gcetjmfee_webappv2/title.dart';

class UIScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              title(size, 'Home Page'),
              StudentRecord(),
            ],
          ),
        ),
      ),
    );
  }
}
