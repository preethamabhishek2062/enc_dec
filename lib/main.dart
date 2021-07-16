import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => Firstscreen(),
        '/Encrypt1': (context) => Encrypt1(),
        '/Encrypt2': (context) => Encrypt2(),
        '/Decrypt1': (context) => Decrypt1()
      },
    );
  }
}

class Firstscreen extends StatelessWidget {
  const Firstscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('EncDec'),
      ),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/Encrypt1');
                },
                child: Text('Encrypt'),
                style: ElevatedButton.styleFrom(
                    primary: Colors.blue[900],
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    textStyle:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: 50.0, width: double.infinity),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/Decrypt1');
                },
                child: Text('Decrypt'),
                style: ElevatedButton.styleFrom(
                    primary: Colors.blue[900],
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    textStyle:
                        TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Encrypt1 extends StatefulWidget {
  const Encrypt1({Key? key}) : super(key: key);

  @override
  _Encrypt1State createState() => _Encrypt1State();
}

class _Encrypt1State extends State<Encrypt1> {
  String imagePath = "";
  String buttonName = "Select Image";

  final picker = ImagePicker();
  bool button = true;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text('Encryption'),
      ),
      body: Center(
        child: Column(
          children: [
            imagePath != ""
                ? Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      height: 400.0,
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Image.file(File(imagePath)),
                    ),
                  )
                : Container(),
            ElevatedButton(
              onPressed: () async {
                if (button == true) {
                  final pickedFile =
                      await picker.getImage(source: ImageSource.gallery);

                  if (pickedFile != null && button == true) {
                    setState(() {
                      imagePath = pickedFile.path;
                      buttonName = "Next";
                      button = false;
                    });
                  }
                } else {
                  setState(() {
                    Navigator.pushNamed(context, '/Encrypt2');
                  });
                }
              },
              child: Text(buttonName),
              style: ElevatedButton.styleFrom(
                textStyle: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Decrypt1 extends StatelessWidget {
  const Decrypt1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: Text('Decryption'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Go to homescreen'),
          style: ElevatedButton.styleFrom(
            textStyle: TextStyle(fontSize: 20.0),
          ), //Instead of this we need to add Pick an Image text
        ),
      ),
    );
  }
}

class Encrypt2 extends StatefulWidget {
  const Encrypt2({Key? key}) : super(key: key);

  @override
  _Encrypt2State createState() => _Encrypt2State();
}

class _Encrypt2State extends State<Encrypt2> {
  bool password = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Encryption')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    hintText: "Enter Secret Message",
                    labelText: "Secret Message",
                    labelStyle: TextStyle(
                      fontSize: 24,
                      color: Colors.blue,
                    ),
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.text,
                  maxLength: 50,
                  maxLines: 2,
                ),
                TextField(
                  decoration: InputDecoration(
                    hintText: "Enter Password",
                    labelText: "Password",
                    labelStyle: TextStyle(
                      fontSize: 24,
                      color: Colors.blue,
                    ),
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                          password ? Icons.remove_red_eye : Icons.security),
                      onPressed: () {
                        setState(() {
                          password = !password;
                        });
                      },
                    ),
                  ),
                  obscureText: password,
                  keyboardType: TextInputType.text,
                  maxLength: 10,
                  maxLines: 1,
                ),
              ],
            ),
          ),
        ));
  }
}
