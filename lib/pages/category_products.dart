import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/pages/product_detail.dart';
import 'package:shopping_app/services/database.dart';
import 'package:shopping_app/widgets/support_widget.dart';

class CategoryProducts extends StatefulWidget {
  final String category;
  const CategoryProducts({super.key, required this.category});

  @override
  State<CategoryProducts> createState() => _CategoryProductsState();
}

class _CategoryProductsState extends State<CategoryProducts> {
  Stream<QuerySnapshot>? categoryStream;

  void getOnTheLoad() {
    categoryStream = DatabaseMethods().getProducts(widget.category);
    setState(() {});
  }

  @override
  void initState() {
    getOnTheLoad();
    super.initState();
  }

  Widget allProducts() {
    return StreamBuilder<QuerySnapshot>(
      stream: categoryStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasData) {
          if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text(
                "No products found in this category.",
                style: AppWidget.semiBoldTextStyle(),
              ),
            );
          }

          int crossAxisCount =
              (MediaQuery.of(context).size.width / 200).floor().clamp(2, 6);

          return GridView.builder(
            itemCount: snapshot.data!.docs.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              childAspectRatio: 0.6,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              DocumentSnapshot ds = snapshot.data!.docs[index];
              Map<String, dynamic> data = ds.data() as Map<String, dynamic>;
              String name = data.containsKey("name") ? data["name"] : "Unknown";
              String image = data.containsKey("image")
                  ? data["image"]
                  : "images/headphone2.png";
              String price = data.containsKey("price") ? data["price"] : "0";
              String detail = data.containsKey("detail")
                  ? data["detail"]
                  : "No details.";

              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetail(
                        name: name,
                        image: image,
                        price: price,
                        detail: detail,
                      ),
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surface,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(child: Image.asset(image, fit: BoxFit.contain)),
                    SizedBox(height: 10),
                    Text(
                      name,
                      style: AppWidget.semiBoldTextStyle(),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "\$$price",
                          style: TextStyle(
                            color: Color(0xfffd6f3e),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Color(0xfffd6f3e),
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: Icon(Icons.add, color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),)
              );
            },
          );
        } else {
          return Center(child: Text("Error fetching products."));
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text("Category Products"),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: Container(
        margin: EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Column(children: [Expanded(child: allProducts())]),
      ),
    );
  }
}
