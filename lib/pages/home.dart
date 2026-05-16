import 'package:flutter/material.dart';
import 'package:shopping_app/widgets/support_widget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List categories = [
    "images/headphone_icon.png",
    "images/laptop.png",
    "images/watch.png",
    "images/TV.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      body: Container(
        margin: EdgeInsets.only(top: 50, left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Hey Vishwa", style: AppWidget.boldTextStyle()),
                    Text("Good Morning", style: AppWidget.lightTextStyle()),
                  ],
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    "images/boy.jpg",
                    height: 70,
                    width: 70,
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              // width: MediaQuery.of(context).size.width,
              child: TextField(
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Search Products",
                  hintStyle: AppWidget.lightTextStyle(),
                  prefixIcon: Icon(Icons.search, color: Colors.black),
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Categories", style: AppWidget.semiBoldTextStyle()),
                Text(
                  "see all",
                  style: TextStyle(
                    color: Color(0xfffd6f3e),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Container(
                  alignment: Alignment.center,
                  height: 130,
                  margin: EdgeInsets.only(right: 20),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Color(0xfffd6f3e),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    "All",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: 130,
                    child: ListView.separated(
                      separatorBuilder: (context, index) => SizedBox(width: 20),
                      physics: BouncingScrollPhysics(),
                      itemCount: categories.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return CategoryTile(image: categories[index]);
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("All Products", style: AppWidget.semiBoldTextStyle()),
                Text(
                  "see all",
                  style: TextStyle(
                    color: Color(0xfffd6f3e),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Container(
              alignment: Alignment.center,
              height: 240,
              child: ListView(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                children: [
                  Container(
                    margin: EdgeInsets.only(right: 20),
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Image.asset(
                          "images/headphone2.png",
                          height: 150,
                          width: 150,
                          fit: BoxFit.cover,
                        ),
                        Text(
                          "Headphones",
                          style: AppWidget.semiBoldTextStyle(),
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Text(
                              "\$100",
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
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Image.asset(
                          "images/headphone2.png",
                          height: 150,
                          width: 150,
                          fit: BoxFit.cover,
                        ),
                        Text(
                          "Headphones",
                          style: AppWidget.semiBoldTextStyle(),
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Text(
                              "\$100",
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
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Image.asset(
                          "images/headphone2.png",
                          height: 150,
                          width: 150,
                          fit: BoxFit.cover,
                        ),
                        Text(
                          "Headphones",
                          style: AppWidget.semiBoldTextStyle(),
                        ),
                        SizedBox(height: 10),
                        Row(
                          children: [
                            Text(
                              "\$100",
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
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryTile extends StatelessWidget {
  final String image;

  const CategoryTile({super.key, required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(image, height: 50, width: 50, fit: BoxFit.cover),
          Icon(Icons.arrow_forward),
        ],
      ),
    );
  }
}
