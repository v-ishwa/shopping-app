import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/pages/bottom_nav.dart';
import 'package:shopping_app/services/shared_pref.dart';
import "../widgets/support_widget.dart";
import './signup.dart';
import '../widgets/responsive_container.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void signin() async {
    final String email = emailController.text.trim();
    final String password = passwordController.text.trim();

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      String id = userCredential.user!.uid;
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection("users")
          .doc(id)
          .get();

      if (userDoc.exists && userDoc.data() != null) {
        var data = userDoc.data() as Map<String, dynamic>;
        await SharedPreferenceHelper().saveUserId(id);
        await SharedPreferenceHelper().saveUserName(
          data.containsKey("name") ? data["name"] : email.split('@')[0],
        );
        await SharedPreferenceHelper().saveUserEmail(
          data.containsKey("email") ? data["email"] : email,
        );
        await SharedPreferenceHelper().saveUserImage(
          data.containsKey("image") ? data["image"] : "boy.jpg",
        );
      } else {
        // Fallback for users without a Firestore document
        await SharedPreferenceHelper().saveUserId(id);
        await SharedPreferenceHelper().saveUserName(email.split('@')[0]);
        await SharedPreferenceHelper().saveUserEmail(email);
        await SharedPreferenceHelper().saveUserImage("boy.jpg");
      }

      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Logged in Successfully"),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const BottomNav()),
      );
    } on FirebaseAuthException catch (e) {
      String errorMessage = "An Error Occurred";

      if (e.code == "invalid-credential" ||
          e.code == "user-not-found" ||
          e.code == "wrong-password") {
        errorMessage = "Invalid email or password.";
      } else if (e.code == "invalid-email") {
        errorMessage = "Email is not valid.";
      } else if (e.code == "user-disabled") {
        errorMessage = "This user account has been disabled.";
      }

      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: SingleChildScrollView(
          child: ResponsiveContainer(
            maxWidth: 500,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Form(
              key: _formKey, // <-- FIXED: Added missing key assignment here
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxHeight: 250),
                      child: Image.asset("images/login.png", fit: BoxFit.contain),
                    ),
                  ),
                  Center(
                    child: Text("Sign In", style: AppWidget.semiBoldTextStyle()),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Text(
                      "Please enter the details below to\ncontinue",
                      style: AppWidget.lightTextStyle(),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 40),
                  Text("Email", style: AppWidget.semiBoldTextStyle()),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.only(left: 20),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Please enter your email";
                        }
                        return null;
                      },
                      controller: emailController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Email",
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text("Password", style: AppWidget.semiBoldTextStyle()),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.only(left: 20),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextFormField(
                      obscureText: true, // Hides password characters
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return "Please enter your password";
                        }
                        return null;
                      },
                      controller: passwordController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Password",
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Forgot Password?",
                        style: TextStyle(
                          color: Colors.green.shade700,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          signin();
                        }
                      },
                      child: Container(
                        width: screenWidth > 500 ? 250 : screenWidth / 2,
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Center(
                          child: Text(
                            "Sign in",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: AppWidget.lightTextStyle(),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const Signup()),
                        ),
                        child: const Text(
                          "Sign up",
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
