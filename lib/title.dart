import 'package:flutter/material.dart';
import './style.dart';

Widget title(Size size, String head) {
  return Container(
    color: Colors.black87,
    width: size.width,
    height: size.height / 11,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: size.width / 1.5,
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
          width: size.width - size.width / 1.5,
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
                  print('home is pressed'),
                },
              ),
              FlatButton(
                child: Text(
                  'Status',
                  style: Style.substyle,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                splashColor: Colors.white,
                onPressed: () => {
                  print('Status is pressed'),
                },
              ),
              FlatButton(
                child: Text(
                  'Verify',
                  style: Style.substyle,
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                splashColor: Colors.white,
                onPressed: () => {
                  print('verify is pressed'),
                },
              ),
              FlatButton(
                child: Text(
                  'About',
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
