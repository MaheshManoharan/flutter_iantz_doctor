import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'screens.dart';
import 'package:google_sign_in/google_sign_in.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase/firebase.dart';

class StartScreen extends StatefulWidget {
  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  // Future<UserCredential> googleSignIn() async {
  //   GoogleSignIn googleSignIn = GoogleSignIn();
  //   GoogleSignInAccount googleUser = await googleSignIn.signIn();
  //   if (googleUser != null) {
  //     GoogleSignInAuthentication googleAuth = await googleUser.authentication;

  //     if (googleAuth.idToken != null && googleAuth.accessToken != null) {
  //       final AuthCredential credential = GoogleAuthProvider.credential(
  //           accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

  //       final UserCredential user =
  //           await _auth.signInWithCredential(credential);

  //       await Navigator.pushReplacementNamed(context, "/");

  //       return user;
  //     } else {
  //       throw StateError('Missing Google Auth Token');
  //     }
  //   } else
  //     throw StateError('Sign in Aborted');
  // }

  navigateToLogin() async {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  navigateToRegister() async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SignUp(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // const SizedBox(
              //   height: 35,
              // ),
              Container(
                height: 300,
                width: 300,
                child: const Image(
                  image: AssetImage('assets/appointment.jpg'),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: navigateToLogin,
                    child: const Text('LOGIN'),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  ElevatedButton(
                    onPressed: navigateToRegister,
                    child: const Text('REGISTER'),
                  ),
                  const SizedBox(
                    height: 59,
                  ),
                ],
              ),
              SignInButton(
                Buttons.Google,
                text: "Sign up with Google",
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
