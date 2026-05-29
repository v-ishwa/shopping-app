import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/services/database.dart';
import 'package:shopping_app/services/shared_pref.dart';
import '../widgets/support_widget.dart';

class Order extends StatefulWidget {
  const Order({super.key});

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  String? userId;
  Stream<QuerySnapshot>? orderStream;

  Future<void> getOnTheLoad() async {
    userId = await SharedPreferenceHelper().getUserId();
    if (userId != null) {
      orderStream = DatabaseMethods().getOrders(userId!);
      setState(() {});
    }
  }

  @override
  void initState() {
    getOnTheLoad();
    super.initState();
  }

  Widget allOrders() {
    return StreamBuilder<QuerySnapshot>(
      stream: orderStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasData) {
          if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text(
                "You haven't placed any orders yet.",
                style: AppWidget.semiBoldTextStyle(),
              ),
            );
          }

          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data!.docs[index];
                  Map<String, dynamic> data = ds.data() as Map<String, dynamic>;
                  String name = data.containsKey("Product") ? data["Product"] : "Unknown";
                  String image = data.containsKey("Image") ? data["Image"] : "images/headphone2.png";
                  String price = data.containsKey("Price") ? data["Price"] : "0";

                  return Container(
                    margin: EdgeInsets.only(bottom: 20),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          offset: Offset(0, 2),
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Image.asset(
                          image,
                          height: 80,
                          width: 80,
                          fit: BoxFit.contain,
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(name, style: AppWidget.semiBoldTextStyle()),
                              SizedBox(height: 5),
                              Text(
                                "\$$price",
                                style: TextStyle(
                                  color: Color(0xfffd6f3e),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.cancel, color: Colors.red),
                          onPressed: () async {
                            if (userId != null) {
                              await DatabaseMethods().deleteOrder(userId!, ds.id);
                            }
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          );
        } else {
          return Center(child: Text("Error fetching orders."));
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Text(
          "My Orders",
          style: AppWidget.boldTextStyle(),
        ),
        centerTitle: true,
      ),
      body: Container(
        margin: EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Column(
          children: [
            Expanded(child: allOrders()),
          ],
        ),
      ),
    );
  }
}