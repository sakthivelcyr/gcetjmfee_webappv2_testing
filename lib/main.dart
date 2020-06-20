import 'package:flutter/material.dart';
import 'package:gcetjmfee_webappv2/style.dart';
import 'package:gcetjmfee_webappv2/uiScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GCE TJ - MESSFEE SYSTEM',
      theme: ThemeData(
        // primarySwatch: Colors.black,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: UIScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        color: Colors.black87,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                height: size.height / 1.5,
                alignment: Alignment.topCenter,
                child: Image.asset('images/clg.jpeg',
                    width: size.width, height: size.height, fit: BoxFit.fill),
              ),
              SizedBox(
                height: size.width / 20,
              ),
              Container(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 10.0),
                    Text(
                      'Goverment College Of Engineering - Thanjavur.'
                          .toUpperCase(),
                      style: Style.style,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10.0),
                    Text('MESS FEE SYSTEM', style: Style.substyle),
                  ],
                ),
              ),
              SizedBox(height: size.width / 80),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    MaterialButton(
                      child: Text('Get Start',
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.bold)),
                      color: Colors.white,
                      textColor: Colors.black,
                      padding: const EdgeInsets.only(
                          left: 20.0, right: 20.0, top: 10.0, bottom: 10.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      onPressed: () {
                        setState(
                          () {
                            print("get start is pressed");
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UIScreen()));
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
