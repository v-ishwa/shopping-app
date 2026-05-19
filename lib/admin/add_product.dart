import 'package:flutter/material.dart';
import 'package:shopping_app/widgets/support_widget.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final List<String> categoryItem = ["Watch", "Laptop", "TV", "Headphone"];

  String? item;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back_ios_new_outlined),
        ),
        title: Text("Add Product", style: AppWidget.semiBoldTextStyle()),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 20, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Upload the Product Image", style: AppWidget.lightTextStyle()),
            SizedBox(height: 20),
            Center(
              child: Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1.5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Icon(Icons.camera_alt_outlined, size: 30),
              ),
            ),
            SizedBox(height: 20),
            Text("Product Name", style: AppWidget.lightTextStyle()),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xffececf8),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                decoration: InputDecoration(border: InputBorder.none),
              ),
            ),
            SizedBox(height: 40),
            Text("Product Name", style: AppWidget.lightTextStyle()),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xffececf8),
                borderRadius: BorderRadius.circular(10),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  hint: Text(
                    "Select Category",
                    style: AppWidget.lightTextStyle(),
                  ),
                  value: item,
                  iconSize: 36,
                  items: categoryItem
                      .map(
                        (item) => DropdownMenuItem(
                          value: item,
                          child: Text(item, style: AppWidget.lightTextStyle()),
                        ),
                      )
                      .toList(),
                  onChanged: (value) => setState(() {
                    item = value;
                  }),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
