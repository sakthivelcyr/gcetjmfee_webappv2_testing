import 'package:flutter/material.dart';
import 'package:gcetjmfee_webappv2/gen_bill.dart';
import 'package:gcetjmfee_webappv2/pay_his.dart';
import 'package:gcetjmfee_webappv2/pending_dues.dart';
import 'package:gcetjmfee_webappv2/stu_record.dart';

import './style.dart';

Widget title(Size size, String head, BuildContext context) {
  return Container(
    color: Colors.black87,
    width: size.width,
    height: size.height / 10,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: size.width / 2,
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text('GCETJ MESS FEE SYSTEM', style: Style.style),
              Text(head, style: Style.substyle)
            ],
          ),
        ),
        Container(
          width: size.width - size.width / 1.6,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              FlatButton(
                child: Text(
                  'Home',
                  style: Style.substyle,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                splashColor: Colors.white,
                onPressed: () => {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) =>
                          StudentRecord(),
                    ),
                  ),
                },
              ),
              FlatButton(
                child: Text(
                  'Generate Bill',
                  style: Style.substyle,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                splashColor: Colors.white,
                onPressed: () => {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) =>
                          GenerateBill(),
                    ),
                  ),
                },
              ),
              FlatButton(
                child: Text(
                  'Payment History',
                  style: Style.substyle,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                splashColor: Colors.white,
                onPressed: () => {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) =>
                          PaymentHistory(),
                    ),
                  ),
                },
              ),
              FlatButton(
                child: Text(
                  'Pending Dues',
                  style: Style.substyle,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                splashColor: Colors.white,
                onPressed: () => {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation1, animation2) =>
                          PendingDues(),
                    ),
                  ),
                },
              ),
              FlatButton(
                child: Text(
                  'Verification',
                  style: Style.substyle,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                splashColor: Colors.white,
                onPressed: () => {
                  print('about is pressed'),
                },
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
