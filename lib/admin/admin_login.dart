import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/pages/bottom_nav.dart';
import 'package:shopping_app/widgets/support_widget.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController userPasswordController = TextEditingController();

  void adminLogin() async {
    await FirebaseFirestore.instance.collection("admin").get().then((snapshot) {
      for (var result in snapshot.docs) {
        if (result.data()["username"] != userNameController.text.trim()) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Invalid Username"),
              backgroundColor: Colors.red,
            ),
          );
        } else if (result.data()["password"] !=
            userPasswordController.text.trim()) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Invalid Password"),
              backgroundColor: Colors.red,
            ),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const BottomNav()),
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset("images/login.png"),
              Center(
                child: Text(
                  "Admin Panel",
                  style: AppWidget.semiBoldTextStyle(),
                ),
              ),
              SizedBox(height: 40),
              Text("Username", style: AppWidget.semiBoldTextStyle()),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.only(left: 20),
                decoration: BoxDecoration(
                  color: Color(0xfff4f5f9),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextFormField(
                  controller: userNameController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Username",
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
                  controller: userPasswordController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Password",
                  ),
                ),
              ),
              SizedBox(height: 60),
              GestureDetector(
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
            ],
          ),
        ),
      ),
    );
  }
}
