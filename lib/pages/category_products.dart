import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/services/database.dart';
import 'package:shopping_app/widgets/support_widget.dart';

class CategoryProducts extends StatefulWidget {
  String category;
  CategoryProducts({super.key, required this.category});

  @override
  State<CategoryProducts> createState() => _CategoryProductsState();
}

class _CategoryProductsState extends State<CategoryProducts> {
  Stream? categoryStream;

  Future<void> getOnTheLoad() async {
    categoryStream = await DatabaseMethods().getProducts(widget.category);
    setState(() {});
  }

  @override
  void initState() {
    getOnTheLoad();
    super.initState();
  }

  Widget allProducts() {
    return StreamBuilder(
      stream: categoryStream,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? GridView.builder(
                itemCount: snapshot.data!.docs.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.6,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.docs[index];
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    margin: EdgeInsets.only(right: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Image.asset(
                          ds["image"],
                          height: 150,
                          width: 150,
                          fit: BoxFit.cover,
                        ),
                        Text(ds["name"], style: AppWidget.semiBoldTextStyle()),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Text(
                              ds["price"],
                              style: TextStyle(
                                color: Color(0xfffd6f3e),
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 40),
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
                    ),
                  );
                },
              )
            : Container();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      appBar: AppBar(
        title: Text("Category Products"),
        backgroundColor: Color(0xfff2f2f2),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Column(children: [Expanded(child: allProducts())]),
      ),
    );
  }
}
