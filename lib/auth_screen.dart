import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isSigningUp = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Authentication Screen'),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff1f368c),
              Color(0xff4260d0),
              Color(0xff6a81d0),
              Color(0xff4260d0),
              Color(0xff1f368c), // Dark purple
              // Light purple
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  cursorColor: Colors.white, // Color of the cursor
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                    labelStyle:
                        TextStyle(color: Colors.white), // Color of the label
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.white), // Border color when enabled
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.white), // Border color when focused
                    ),
                  ),
                  style: const TextStyle(
                    color: Colors
                        .white, // Change this to the color you want for the input text
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                    labelStyle:
                        TextStyle(color: Colors.white), // Color for the label
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  style: const TextStyle(
                    color: Color(
                        0xffffffff), // Change this to the color you want for the input text
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    return null;
                  },
                ),
                // Change this to your desired color
                Visibility(
                  visible: _isSigningUp,
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      TextFormField(
                        controller: _confirmPasswordController,
                        decoration: const InputDecoration(
                          labelText: 'Confirm Password',
                          border: OutlineInputBorder(),
                          labelStyle: TextStyle(color: Colors.white),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please confirm your password';
                          }
                          if (value != _passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      if (_isSigningUp) {
                        try {
                          final response =
                              await Supabase.instance.client.auth.signUp(
                            email: _emailController.text,
                            password: _passwordController.text,
                          );
                          if (response.user != null) {
                            // User signed up successfully
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Account created successfully'),
                              ),
                            );
                            setState(() {
                              _isSigningUp = false;
                            });
                          } else {
                            // Error signing up
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Error creating account'),
                              ),
                            );
                          }
                        } catch (e) {
                          // Error signing up
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Error creating account'),
                            ),
                          );
                        }
                      } else {
                        try {
                          final response = await Supabase.instance.client.auth
                              .signInWithPassword(
                            email: _emailController.text,
                            password: _passwordController.text,
                          );
                          if (response.user != null) {
                            // User signed in successfully
                            Navigator.pushNamed(context, '/home');
                          } else {
                            // Error signing in
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Error signing in'),
                              ),
                            );
                          }
                        } catch (e) {
                          print(e);
                          // Error signing in
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Error signing in'),
                            ),
                          );
                        }
                      }
                    }
                  },
                  child: Text(_isSigningUp ? 'Create Account' : 'Sign In'),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _isSigningUp = !_isSigningUp;
                    });
                  },
                  child: Text(
                    _isSigningUp
                        ? 'Already have an account? Sign In'
                        : 'Don\'t have an account? Create Account',
                    style: const TextStyle(
                      color: Colors
                          .white, // Change this to the color you want for the input text
                    ),
                  ),
                ),
                Visibility(
                    visible: _isSigningUp,
                    child: const Text(
                      "(Please check you email to verify after you create account )\n",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
