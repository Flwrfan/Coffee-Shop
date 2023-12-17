import 'package:coffee_shop/view/americanoCoffeePage.dart';
import 'package:coffee_shop/view/cappucinoCoffeePage.dart';
import 'package:coffee_shop/view/latteCoffeePage.dart';
import 'package:coffee_shop/home.dart';
// import 'package:flutter_testing/view/components/otherPage.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return HomeContent();
  }
}

class HomeContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Halaman Menu',
          style: TextStyle(fontSize: 17.5),
        ),
        backgroundColor: Color.fromARGB(255, 10, 5, 1),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    height: height * 0.3,
                    width: width,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("images/lungo.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withOpacity(0.0),
                            Colors.black.withOpacity(0.0),
                            Colors.black.withOpacity(0.1),
                            Colors.black.withOpacity(0.5),
                            Colors.black.withOpacity(1.0),
                          ],
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 90,
                    left: 20,
                    child: RichText(
                      text: TextSpan(
                        text: "Enjoy Your",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                          fontSize: 20,
                        ),
                        children: [
                          TextSpan(
                            text: "\nCoffee Everyday",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 24,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Transform.translate(
                offset: Offset(0.0, -(height * 0.3 - height * 0.26)),
                child: Container(
                  width: width,
                  padding: EdgeInsets.only(top: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: DefaultTabController(
                    length: 3,
                    child: Column(
                      children: <Widget>[
                        TabBar(
                          labelColor: Colors.black,
                          labelStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                          unselectedLabelColor: Colors.grey[400],
                          unselectedLabelStyle: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 17,
                          ),
                          indicatorSize: TabBarIndicatorSize.label,
                          indicatorColor: Colors.transparent,
                          tabs: <Widget>[
                            Tab(
                              child: Text("Americano"),
                            ),
                            Tab(
                              child: Text("Cappucino"),
                            ),
                            Tab(
                              child: Text("Latte"),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 20,
                            right: 20,
                            bottom: 10,
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(vertical: 3),
                              prefixIcon: Padding(
                                padding: const EdgeInsets.only(
                                  left: 15,
                                  right: 15,
                                ),
                                child: Icon(
                                  Icons.search,
                                  size: 30,
                                ),
                              ),
                              hintText: "Search your coffee",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                  width: 1.0,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: height * 0.6,
                          child: TabBarView(
                            children: <Widget>[
                              AmericanoCoffeePage(),
                              CappucinoCoffeePage(),
                              LatteCoffeePage(),
                            ],
                          ),
                        ),
                      ],
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
