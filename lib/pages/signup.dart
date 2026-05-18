import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:random_string/random_string.dart';
import 'package:shopping_app/pages/bottom_nav.dart';
import 'package:shopping_app/services/database.dart';
import './login.dart';
import "../widgets//support_widget.dart";

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void signup() async {
    final String email = emailController.text.trim();
    final String password = passwordController.text.trim();
    final String name = nameController.text.trim();
    if (email.isNotEmpty && password.isNotEmpty) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        // print('user: $userCredential');
        String id = userCredential.user!.uid;
        Map<String, dynamic> userInfoMap = {
          "name": name,
          "email": email,
          "id": id,
          "image": "https://picsum.photos/seed/picsum/200/300",
        };
        await DatabaseMethods().addUserInfo(userInfoMap, id);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("User Registered Successfully"),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => BottomNav()),
        );
      } on FirebaseException catch (e) {
        String errorMessage = "An Error Occurred";

        if (e.code == "weak-password") {
          errorMessage = "The password provided is too weak.";
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(errorMessage), backgroundColor: Colors.red),
          );
        } else if (e.code == "email-already-in-use") {
          errorMessage = "Email already in use";
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(errorMessage), backgroundColor: Colors.red),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            margin: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset("images/login.png"),
                Center(
                  child: Text("Sign Up", style: AppWidget.semiBoldTextStyle()),
                ),
                SizedBox(height: 20),
                Center(
                  child: Text(
                    "Please enter the details below to\n                    continue",
                    style: AppWidget.lightTextStyle(),
                  ),
                ),
                SizedBox(height: 40),
                Text("Name", style: AppWidget.semiBoldTextStyle()),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.only(left: 20),
                  decoration: BoxDecoration(
                    color: Color(0xfff4f5f9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your name";
                      }
                      return null;
                    },
                    controller: nameController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Name",
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text("Email", style: AppWidget.semiBoldTextStyle()),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.only(left: 20),
                  decoration: BoxDecoration(
                    color: Color(0xfff4f5f9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your email";
                      }
                      return null;
                    },
                    controller: emailController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Email",
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text("Password", style: AppWidget.semiBoldTextStyle()),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.only(left: 20),
                  decoration: BoxDecoration(
                    color: Color(0xfff4f5f9),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your Password";
                      }
                      return null;
                    },
                    controller: passwordController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Password",
                    ),
                  ),
                ),
                SizedBox(height: 20),

                GestureDetector(
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      signup();
                    }
                  },
                  child: Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2,
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          "Sign up",
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
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: AppWidget.lightTextStyle(),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                      ),
                      child: Text(
                        "Sign in",
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
    );
  }
}
