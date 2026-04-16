import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login_page.dart';
import 'main.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: 50),
                  Text('Create User', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),),
                  SizedBox(height: 20),
                  // name
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                        labelText: 'name',
                        border: OutlineInputBorder()
                    ),
                  ),
                  SizedBox(height: 20),
                  // email
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                        labelText: 'email',
                        border: OutlineInputBorder()
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter a valid email';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 20),
                  // password
                  TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'password',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty){
                        return 'Enter your password';
                      }
                      if (value.length < 6){
                        return 'Minimum 6 characters is required';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 30),
                  // submit button
                  ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          try {
                            // 🔐 Create user
                            UserCredential userCredential =
                            await FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                            );

                            // 🆔 Get user ID
                            String uid = userCredential.user!.uid;

                            // 💾 Save to Firestore
                            await FirebaseFirestore.instance
                                .collection('users')
                                .doc(uid)
                                .set({
                              'name': nameController.text.trim(),
                              'email': emailController.text.trim(),
                            });
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        HomeScreen()));
                            print("User created");

                          } on FirebaseAuthException catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(e.message ?? "Signup failed")),
                            );

                          }

                        }},
                      child: Text('Submit')),
                  SizedBox(height: 20),
                  Text('Already have an account'),
                  TextButton(onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                      child: Text('Login')),
                ],
              )
          ),
        )
    );
  }
}
