import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'screens.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _email, _password, _name;

  @override
  void initState() {
    super.initState();
    this.checkAuthentication();
  }

  signUp() async {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      try {
        FirebaseUser user = (await _auth.createUserWithEmailAndPassword(
          email: _email,
          password: _password,
        )).user;
        if (user != null) {
          UserUpdateInfo updateuser = UserUpdateInfo();
          updateuser.displayName = _name;
          user.updateProfile(updateuser);
        }
      } catch (e) {
        showError(e.toString());
      }
    }
  }

  checkAuthentication() async {
    _auth.onAuthStateChanged.listen((user) {
      if (user != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(),
          ),
        );
      }
    });
  }

  showError(String errorMessage) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text(errorMessage),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                height: 300,
                width: 300,
                child: const Image(
                  image: AssetImage('assets/login.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Container(
                          child: TextFormField(
                            // ignore: missing_return
                            validator: (input) {
                              if (input.isEmpty) {
                                return 'Enter Email';
                              }
                            },
                            decoration: const InputDecoration(
                              labelText: 'Email',
                              prefixIcon: Icon(Icons.email),
                            ),
                            onSaved: (input) => _email = input,
                          ),
                        ),
                        Container(
                          child: TextFormField(
                            // ignore: missing_return
                            validator: (input) {
                              if (input.isEmpty) {
                                return 'Enter Name';
                              }
                            },
                            decoration: const InputDecoration(
                              labelText: 'Name',
                              prefixIcon: Icon(Icons.person),
                            ),
                            onSaved: (input) => _name = input,
                          ),
                        ),
                        Container(
                          child: TextFormField(
                            // ignore: missing_return
                            validator: (input) {
                              if (input.length < 6) {
                                return 'Provide Minimum 6 character';
                              }
                            },
                            decoration: const InputDecoration(
                              labelText: 'Password',
                              prefixIcon: Icon(Icons.lock),
                            ),
                            obscureText: true,
                            onSaved: (input) => _password = input,
                          ),
                        ),
                        ElevatedButton(
                          onPressed: signUp,
                          child: Text(
                            'SignUp',
                            style: TextStyle(),
                          ),
                        )
                      ],
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
