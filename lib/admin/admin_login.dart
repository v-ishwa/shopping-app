import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/admin/admin_home.dart';
import 'package:shopping_app/widgets/support_widget.dart';
import '../widgets/responsive_container.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController userPasswordController = TextEditingController();

  void adminLogin() async {
    final String userName = userNameController.text.trim();
    final String userPassword = userPasswordController.text.trim();

    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection("Admin")
          .where("username", isEqualTo: userName)
          .get();

      if (snapshot.docs.isEmpty) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Invalid Username")));
        return;
      }
      final adminDoc = snapshot.docs.first.data() as Map<String, dynamic>?;

      if (adminDoc?["password"] == userPassword) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Welcome Back, Admin"),
            backgroundColor: Colors.green,
          ),
        );

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const AdminHome()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Invalid Password"),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: ${e.toString()}"),
          backgroundColor: Colors.red,
        ),
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
                    color: Theme.of(context).colorScheme.surface,
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
                    color: Theme.of(context).colorScheme.surface,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextFormField(
                    obscureText: true,
                    controller: userPasswordController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Password",
                    ),
                  ),
                ),
                SizedBox(height: 60),
                GestureDetector(
                  onTap: () => adminLogin(),
                  child: Center(
                    child: Container(
                      width: screenWidth > 500 ? 250 : screenWidth / 2,
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
