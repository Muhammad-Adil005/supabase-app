import 'package:flutter/material.dart';
import 'package:supabase_app/home_screen/home_screen.dart';
import 'package:supabase_app/login_screen/login_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../main.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();

  //Sign Up User
  Future<void> signUp() async {
    try {
      await supabase.auth.signUp(
          password: passwordController.text.trim(),
          email: emailController.text.trim(),
          data: {
            'username': usernameController.text.trim()
          } // This is how we store user
          );
      if (!mounted) return;

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    } on AuthException catch (e) {
      debugPrint(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "SignUp",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.blue.shade50),
                    ),
                    child: TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        hintText: 'Enter your email',
                        prefixIcon: const Icon(Icons.email),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Colors.white70,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.white70),
                        ),
                        hintStyle: TextStyle(
                            fontSize: 12.0, color: Colors.blueGrey.shade300),
                        contentPadding: const EdgeInsets.all(12),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Colors.blue.shade50,
                        width: 1,
                      ),
                    ),
                    child: TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: 'Enter your password',
                        prefixIcon: const Icon(Icons.lock),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Colors.white70,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.white70),
                        ),
                        hintStyle: TextStyle(
                            fontSize: 12.0, color: Colors.blueGrey.shade300),
                        contentPadding: const EdgeInsets.all(12),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(
                        color: Colors.blue.shade50,
                      ),
                    ),
                    child: TextFormField(
                      controller: usernameController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        hintText: 'Enter your username',
                        prefixIcon: const Icon(Icons.person),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Colors.white70,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.white70),
                        ),
                        hintStyle: TextStyle(
                            fontSize: 12.0, color: Colors.blueGrey.shade300),
                        contentPadding: const EdgeInsets.all(12),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: GestureDetector(
                    onTap: signUp,
                    child: Container(
                      alignment: Alignment.center,
                      height: 45,
                      width: 360,
                      decoration: BoxDecoration(
                        color: Colors.purpleAccent,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Text(
                        "Sign Up",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()));
                    },
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "Already have an account?",
                            style: TextStyle(
                              color: Colors.blueGrey.shade300,
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          TextSpan(
                            text: ' ',
                            style: TextStyle(
                                color: Colors.indigo.shade300,
                                fontSize: 12,
                                fontWeight: FontWeight.w700),
                          ),
                          const TextSpan(
                            text: "SignIn",
                            style: TextStyle(
                                color: Colors.purpleAccent,
                                fontSize: 12,
                                fontWeight: FontWeight.w700),
                          )
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
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
