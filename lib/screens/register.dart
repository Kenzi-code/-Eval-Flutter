import 'package:dwm14/constants/firebase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String name = '';
  String email = '';
  String password = '';
  String errorValidation = '';

  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Center(
                child: Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        children: [
          Text('Register'),
          SizedBox(height: 10),
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  onSaved: (value) {
                    setState(() {
                      name = value;
                    });
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Empty';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: 'Name', hintText: 'Enter your name'),
                ),
                TextFormField(
                  onSaved: (value) {
                    setState(() {
                      email = value;
                    });
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Empty';
                    } else if (!RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-z]+$")
                        .hasMatch(value)) {
                      return "Invalid Email";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      labelText: 'Email', hintText: 'Enter your email'),
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
                        UserCredential userCredential =
                            await firebaseAuth.createUserWithEmailAndPassword(
                                email: email, password: password);
                        if (userCredential.user != null) {
                          final docReference = firestore.collection('users');
                          docReference.add({
                            'name': name,
                            'email': userCredential.user.email
                          }).catchError((error) {
                            setState(() {
                              errorValidation =
                                  'Failed to add your credentials';
                            });
                          });
                        }
                        print('Succeed to register');
                      } on FirebaseAuthException catch (error) {
                        if (error.code == 'weak-password') {
                          setState(() {
                            errorValidation = 'Password too weak';
                          });
                        } else if (error.code == 'email-already-in-use') {
                          setState(() {
                            errorValidation = 'Email already used';
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
    ))));
  }
}
