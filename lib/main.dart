import 'package:flutter/material.dart';
import 'package:gcetjmfee_webappv2/pending_dues.dart';
import 'package:gcetjmfee_webappv2/stu_record.dart';
import 'package:gcetjmfee_webappv2/style.dart';

void main() {
  runApp(MyApp());
}

String errtxt = '';

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
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

String password = '';

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextEditingController pass = TextEditingController();

    String validatePassword(String value) {
      if (value != 'gcetj123') {
        return "Password wrong";
      }
      return null;
    }

    Widget inputBox(String label, TextInputType t, Icon icon) {
      return Container(
        width: MediaQuery.of(context).size.width / 8,
        height: MediaQuery.of(context).size.width / 40,
        child: TextFormField(
          keyboardType: t,
          controller: pass,
          autofocus: false,
          onChanged: (value) {
            print(value);
            password = value;
          },
          style: TextStyle(color: Colors.white),
          obscureText: true,
          decoration: InputDecoration(
            //errorText: validatePassword(pass.text),
            //errorText: (validator) ? 'Password Wrong' : '',
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(4.0)),
              borderSide: BorderSide(color: Colors.white, width: 2),
            ),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                borderSide: BorderSide(color: Colors.white, width: 3)),
            labelText: label,
            hintText: label,

            labelStyle: TextStyle(color: Colors.white),
            suffixIcon: icon,
          ),
          cursorColor: Colors.pink,
          showCursor: true,
        ),
      );
    }

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
                    inputBox('Password', TextInputType.number,
                        Icon(Icons.person, size: 28, color: Colors.white)),
                    SizedBox(width: MediaQuery.of(context).size.width / 80),
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
                        setState(() {
                          errtxt = '';
                        });
                        if (password == 'gcetj123')
                          Navigator.pushReplacement(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation1, animation2) =>
                                  StudentRecord(),
                            ),
                          );
                        else
                          setState(() {
                            errtxt = 'Password Wrong';
                          });
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.width / 80),
              Center(
                child: Text(errtxt, style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
