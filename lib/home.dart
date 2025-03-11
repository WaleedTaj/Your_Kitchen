import 'dart:convert';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:your_kitchen/model.dart';
import 'package:flutter_gradient_app_bar/flutter_gradient_app_bar.dart';
import 'package:your_kitchen/recipeView.dart';
import 'package:your_kitchen/search.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isLoading = true;
  List recipeCatList = [
    {"image": "assets/images/Meat.png", "heading": "Meat"},
    {"image": "assets/images/Chicken.png", "heading": "Chicken"},
    {"image": "assets/images/Pizzas.png", "heading": "Pizzas"},
    {"image": "assets/images/Tikka.png", "heading": "Tikka"},
    {"image": "assets/images/Burgers.png", "heading": "Burgers"},
    {"image": "assets/images/Fries.png", "heading": "Fries"},
    {"image": "assets/images/Salads.png", "heading": "Salads"},
    {"image": "assets/images/Vegetables.png", "heading": "Vegetables"},
    {"image": "assets/images/Sweets.png", "heading": "Sweets"},
    {"image": "assets/images/Cakes.png", "heading": "Cakes"},
    {"image": "assets/images/Roti.png", "heading": "Roti"},
    {"image": "assets/images/Juices.png", "heading": "Juices"},
    {"image": "assets/images/Bottles.png", "heading": "Bottles"},
  ];
  List<RecipeModel> recipeList = <RecipeModel>[];
  TextEditingController searchController = new TextEditingController();

  getRecipe(String query) async {
    String url =
        "https://api.edamam.com/search?q=$query&app_id=Your_APP_ID&app_key=Your_API_KEY";
    Response response = await get(Uri.parse(url));
    Map data = jsonDecode(response.body);

    data['hits'].forEach((element) {
      RecipeModel recipeModel =
          RecipeModel(); // Creating Object of RecipeModel class from model.dart
      recipeModel = RecipeModel.fromMap(element['recipe']);
      recipeList.add(recipeModel);
      setState(() {
        isLoading = false;
      });
    });
    //
    // recipeList.forEach((Recipe) {
    //   print(Recipe.appLabel);
    //   print(Recipe.appCalories);
    // });
  }

  List searches = [
    "Ladoo",
    "Sweets",
    "Vegetable",
    "Chicken",
    "Meat",
    "Juice",
    "Pizza",
    "Burger",
    "Salan",
    "Simosa",
    "Cake",
    "Biscuit",
    "Ice Cream",
    "Bottles",
    "Milk Shake",
    "Tikka",
    "Roti",
    "Naan",
    "Tasty"
  ];
  final Random random = new Random();
  @override
  void initState() {
    super.initState();
    String randomSearch = searches[random.nextInt(searches.length)];
    getRecipe(randomSearch);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: GradientAppBar(
            gradient: LinearGradient(colors: [
              Color(0xff071938),
              Color(0xff213A50),
            ], begin: Alignment.bottomRight, end: Alignment.topLeft),
          )),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
              Color(0xff213A50),
              Color(0xff071938),
            ])),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.fromLTRB(15, 10, 1, 0),
                  child: Row(
                    children: <Widget>[
                      CircleAvatar(
                        radius: 45,
                        backgroundColor: Colors.white,
                        backgroundImage: AssetImage("assets/images/image3.png"),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            "Your Kitchen",
                            style: TextStyle(
                                fontSize: 48,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'AsapCondensed',
                                color: Colors.white),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SafeArea(
                  child: // Search Container
                      Container(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
                    decoration: BoxDecoration(
                      border: Border.all(width: 3, color: Colors.white),
                      color: Colors.white70,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.search,
                          size: 30,
                          color: Colors.blue,
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Expanded(
                          child: TextField(
                            // inputFormatters: [LengthLimitingTextInputFormatter(20)],
                            controller: searchController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Let's Cook Something...",
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if ((searchController.text).replaceAll(" ", "") ==
                                "") {
                              print("Blank Search");
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      Search(searchController.text),
                                ),
                              );
                            }
                          },
                          child: Container(
                            child: Text(
                              "Search",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w500),
                            ),
                            margin: EdgeInsets.fromLTRB(3, 0, 7, 0),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "WHAT DO YOU WANT TO COOK TODAY?",
                        style: TextStyle(
                            fontSize: 35,
                            fontFamily: "AnekLatin",
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Let's Cook Something New!",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                Divider(
                  indent: 50,
                  endIndent: 50,
                  thickness: 1,
                  height: 10,
                  color: Colors.black87,
                ),
                Container(
                  padding: EdgeInsets.only(left: 15, top: 5),
                  alignment: Alignment.topLeft,
                  child: Stack(
                    children: [
                      Text(
                        "Categories:",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 35,
                            fontFamily: "AnekLatin"),
                      ),
                      Positioned(
                        bottom:
                            1, // Adjust this value to control the space between the text and the underline
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 2.3, // Thickness of the underline
                          color: Colors.white60, // Color of the underline
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 180,
                  child: ListView.builder(
                      itemCount: recipeCatList.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Container(
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Search(
                                    recipeCatList[index]["heading"],
                                  ),
                                ),
                              );
                            },
                            child: Card(
                              margin:
                                  EdgeInsets.only(top: 20, left: 14, right: 10),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              elevation: 0.0,
                              child: Stack(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.asset(
                                      recipeCatList[index]["image"],
                                      fit: BoxFit.cover,
                                      height: 190,
                                      width: 190,
                                    ),
                                  ),
                                  Positioned(
                                      right: 0,
                                      left: 0,
                                      top: 0,
                                      bottom: 0,
                                      child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 10),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 3, color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: Colors.black54,
                                        ),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              recipeCatList[index]["heading"],
                                              style: TextStyle(
                                                  fontFamily: "AnekLatin",
                                                  color: Colors.white,
                                                  fontSize: 35),
                                            ),
                                          ],
                                        ),
                                      ))
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                ),
                Divider(
                  indent: 50,
                  endIndent: 50,
                  thickness: 1,
                  height: 30,
                  color: Colors.black87,
                ),
                Container(
                  padding: EdgeInsets.only(left: 15, top: 5),
                  alignment: Alignment.topLeft,
                  child: Stack(
                    children: [
                      Text(
                        "Suggested For You:",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontFamily: "AnekLatin"),
                      ),
                      Positioned(
                        bottom:
                            1, // Adjust this value to control the space between the text and the underline
                        left: 0,
                        right: 0,
                        child: Container(
                          height: 2.3, // Thickness of the underline
                          color: Colors.white60, // Color of the underline
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: isLoading
                      ? CircularProgressIndicator(color: Colors.blue)
                      : ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: recipeList.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        RecipeView(recipeList[index].appUrl),
                                  ),
                                );
                              },
                              child: Card(
                                margin: EdgeInsets.fromLTRB(15, 0, 15, 18),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                elevation: 0.0,
                                // shadowColor: Colors.white,
                                child: Stack(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 3, color: Colors.white),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Image.network(
                                          recipeList[index].appImgUrl,
                                          fit: BoxFit.fill,
                                          width: double.infinity,
                                          height: 250,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 0,
                                      right: 0,
                                      bottom: 0,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 3, color: Colors.white),
                                          color: Colors.black54,
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(20),
                                            bottomRight: Radius.circular(20),
                                          ),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                            vertical: 5, horizontal: 10),
                                        child: Center(
                                          child: Text(
                                            recipeList[index].appLabel,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 18),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      right: 0,
                                      height: 35,
                                      width: 100,
                                      child: Container(
                                        // padding: EdgeInsets.symmetric(horizontal: 15,vertical: 3),
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              width: 3, color: Colors.white),
                                          color: Colors.black54,
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(20),
                                            bottomLeft: Radius.circular(10),
                                          ),
                                        ),
                                        child: Center(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.local_fire_department,
                                                color: Colors.white,
                                                size: 20,
                                              ),
                                              SizedBox(
                                                width: 2,
                                              ),
                                              Text(
                                                recipeList[index]
                                                    .appCalories
                                                    .toString()
                                                    .substring(0, 6),
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
