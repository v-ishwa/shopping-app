import 'package:flutter/material.dart';
import 'package:shopping_app/pages/order.dart';
import 'package:shopping_app/services/database.dart';
import 'package:shopping_app/services/shared_pref.dart';
import "../widgets/support_widget.dart";

class ProductDetail extends StatefulWidget {
  final String image, name, price, detail;
  const ProductDetail({
    super.key,
    required this.image,
    required this.name,
    required this.price,
    required this.detail,
  });

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  bool isOrdering = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Container(
        padding: EdgeInsets.only(top: 50),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Center(child: Image.asset(widget.image, height: 400)),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    margin: EdgeInsets.only(left: 20),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.arrow_back_ios_new_outlined,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 20,
                  bottom: 20,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(widget.name, style: AppWidget.boldTextStyle()),
                        Text(
                          "\$${widget.price}",
                          style: TextStyle(
                            color: Color(0xfffd6f3e),
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Text("Details", style: AppWidget.semiBoldTextStyle()),
                    SizedBox(height: 10),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Text(
                          widget.detail,
                          style: AppWidget.lightTextStyle(),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: isOrdering
                          ? null
                          : () async {
                              setState(() => isOrdering = true);
                              // Add a small delay so the loading indicator is visible
                              // even if the database operation is very fast.
                              await Future.delayed(
                                const Duration(milliseconds: 500),
                              );
                              String? id = await SharedPreferenceHelper()
                                  .getUserId();
                              if (id != null) {
                                Map<String, dynamic> orderInfoMap = {
                                  "Product": widget.name,
                                  "Price": widget.price,
                                  "Image": widget.image,
                                };
                                await DatabaseMethods().addOrder(
                                  orderInfoMap,
                                  id,
                                );
                                if (!context.mounted) return;
                                setState(() => isOrdering = false);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Order placed successfully!"),
                                    backgroundColor: Colors.green,
                                  ),
                                );
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Order(),
                                  ),
                                );
                              } else {
                                if (context.mounted) {
                                  setState(() => isOrdering = false);
                                }
                              }
                            },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: isOrdering
                              ? Color(0xfffd6f3e).withOpacity(0.7)
                              : Color(0xfffd6f3e),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        width: double.infinity,
                        child: Center(
                          child: isOrdering
                              ? const SizedBox(
                                  height: 22,
                                  width: 22,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2.5,
                                  ),
                                )
                              : const Text(
                                  "Buy Now",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
