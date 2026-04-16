import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'signup.dart';
import 'main.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isPasswordHidden = true;
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
                  Text('Login', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),),
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
                    obscureText: isPasswordHidden,
                    decoration: InputDecoration(
                      labelText: 'password',
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isPasswordHidden = !isPasswordHidden;
                            });
                          },
                          icon: Icon(isPasswordHidden ? Icons.visibility_off : Icons.visibility))
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
                  // Login button
                  ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          try {
                            await FirebaseAuth.instance
                                .signInWithEmailAndPassword(
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                            );
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        HomeScreen()));
                            print("Logged in");

                          } on FirebaseAuthException catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(e.message ?? "Login failed")),
                            );
                          }
                        }},
                      child: Text('Login')),
                  SizedBox(height: 20),
                  Text('Do not have an account?'),
                  TextButton(onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignUp()));
                  }, child: Text('Signup'))
                ],
              )
          ),
        )
    );
  }
}

