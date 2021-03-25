import 'package:dwm14/components/field.dart';
import 'package:dwm14/constants/firebase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String email = '';
  String password = '';
  String errorValidation = '';

  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Center(
        child: Column(
          children: [
            Text('Login'),
            SizedBox(height: 10),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  FieldText(
                    onSaved: (value) {
                      setState(() {
                        email = value;
                      });
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Empty';
                      } else if (!RegExp(
                              r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-z]+$")
                          .hasMatch(value)) {
                        return "Invalid Email";
                      }
                      return null;
                    },
                    label: 'Email',
                    placeholder: 'Enter you Email',
                  ),
                  TextFormField(
                    obscureText: true,
                    onSaved: (value) {
                      password = value;
                    },
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Empty';
                      } else if (value.length < 8) {
                        return 'Passwort too short';
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                        labelText: 'Password', hintText: 'Enter your password'),
                  ),
                  SizedBox(height: 10),
                  Text(errorValidation),
                  SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        try {
                          await firebaseAuth.signInWithEmailAndPassword(
                              email: email, password: password);
                          print('Succeed to login');
                          Navigator.pushReplacementNamed(context, '/home');
                        } on FirebaseAuthException catch (error) {
                          if (error.code == 'user-not-found') {
                            setState(() {
                              errorValidation = 'Email or password is invalid';
                            });
                          } else if (error.code == 'wrong-password') {
                            setState(() {
                              errorValidation = 'Email or password is invalid';
                            });
                          }
                        } catch (error) {
                          print(error);
                        }
                      }
                    },
                    child: Text('Submit'),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
}
