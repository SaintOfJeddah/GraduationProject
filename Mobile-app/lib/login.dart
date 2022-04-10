import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'constants.dart';

class login extends StatefulWidget {
  login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  var email;
  var password;
  List post = [];
  addPost() async {
    var url = "http://10.0.2.2:8090/login";

    var res = await http.post(
      Uri.parse(url),
      body: {
        "email": "$email",
        "password": "$password",
      },
    );

    var resBody = jsonDecode(res.body);

    setState(() {
      post.add(resBody);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Color(0XFFF6F8FB),
          width: double.infinity,
          child: Container(
            margin: EdgeInsets.all(25),
            width: double.infinity,
            child: ListView(
              children: [
                SizedBox(
                  height: 40,
                ),
                Image.asset("images/logo.png", height: 80, width: 200),
                SizedBox(
                  height: 80,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 70.0,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 40),
                        child: TextField(
                          onChanged: (value) {
                            setState(() {
                              email = value;
                            });
                          },
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.email_outlined,
                              color: Colors.grey,
                            ),
                            hintText: 'Email',
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20.0),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(32.0)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(32.0)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(32.0)),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 40),
                        child: TextField(
                          onChanged: (value) {
                            //Do something with the user input.
                            setState(() {
                              password =
                                  md5.convert(utf8.encode(value)).toString();
                            });
                          },
                          obscureText: true,
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.lock_sharp,
                              color: Colors.grey,
                            ),
                            hintText: 'Password',
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 20.0),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(32.0)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(32.0)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1.0),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(32.0)),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed("ResetPassword");
                        },
                        child: Text(
                          "Forgot Password?",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0Xff336CFB),
                              fontSize: 15),
                        ),
                      ),
                      SizedBox(
                        height: 3.0,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 16.0),
                        child: Material(
                          color: Color(0xFF336CFB),
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                          elevation: 5.0,
                          child: MaterialButton(
                            onPressed: () async {
                              //Implement login functionality.
                              print(email);
                              print(password);
                              await addPost();
                              if (post[0]["status"] == 200) {
                                Navigator.of(context).pushNamed("Home");
                              } else {
                                print(email);
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text("${post[0]['message']}"),
                                  ),
                                );
                                Future.delayed(
                                    const Duration(milliseconds: 3000), () {
                                  setState(() {
                                    Navigator.of(context).pushNamed("login");
                                  });
                                });
                              }
                            },
                            minWidth: 100.0,
                            height: 40.0,
                            child: Text(
                              'Log In',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don’t have an account?"),
                          SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.of(context).pushNamed("Register");
                            },
                            child: Text(
                              "Sign up!",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0Xff336CFB),
                                  fontSize: 15),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
