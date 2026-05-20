import 'package:flutter/material.dart';
import 'package:shopping_app/services/database.dart';
import 'package:shopping_app/widgets/support_widget.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final TextEditingController productNameController = TextEditingController();

  // Your default local asset path string
  final String selectedImage = "images/headphone2.png";

  final List<String> categoryItem = ["Watch", "Laptop", "TV", "Headphone"];
  String? item;

  void uploadItem() async {
    print("button clicked");
    final String productName = productNameController.text.trim();

    // Check if fields are actually filled out
    if (item != null && productName.isNotEmpty) {
      Map<String, dynamic> newProduct = {
        "name": productName,
        "image": selectedImage,
      };

      try {
        print("before querying");

        // Execute the database call
        await DatabaseMethods().addProduct(newProduct, item!);

        print("query success");

        // Guard to prevent context memory leaks if user backed out of the page
        if (!mounted) return;

        // FIXED: State UI resets MUST happen inside setState() to update the screen layout
        setState(() {
          productNameController.clear();
          item = null;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Product Added Successfully"),
            backgroundColor: Colors.green,
          ),
        );
      } catch (error) {
        // CATCH ALL BLOCKS: If Firestore fails or times out, it tells you why here
        print("CRITICAL FIRESTORE ERROR: $error");

        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Database Error: ${error.toString()}"),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Fill Out All the Fields"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void dispose() {
    productNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: const Icon(Icons.arrow_back_ios_new_outlined),
        ),
        title: Text("Add Product", style: AppWidget.semiBoldTextStyle()),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Upload the Product Image",
                style: AppWidget.lightTextStyle(),
              ),
              const SizedBox(height: 20),
              Center(
                child: Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 1.5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: Image.asset(selectedImage, fit: BoxFit.cover),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text("Product Name", style: AppWidget.lightTextStyle()),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xffececf8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: productNameController,
                  decoration: const InputDecoration(border: InputBorder.none),
                ),
              ),
              const SizedBox(height: 40),
              Text("Category", style: AppWidget.lightTextStyle()),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xffececf8),
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
                          (category) => DropdownMenuItem(
                            value: category,
                            child: Text(
                              category,
                              style: AppWidget.lightTextStyle(),
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (value) => setState(() {
                      item = value;
                    }),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Center(
                child: ElevatedButton(
                  onPressed: uploadItem,
                  child: Text(
                    "Add Product",
                    style: TextStyle(fontSize: 20, color: Colors.grey.shade600),
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
