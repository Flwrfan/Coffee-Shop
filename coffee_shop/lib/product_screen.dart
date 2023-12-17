import 'package:flutter/material.dart';
import 'colors.dart';

class ProductScreen extends StatelessWidget {
  List<String> sizes = [
    "S",
    "M",
    "L",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 1.6,
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(30),
                bottomLeft: Radius.circular(30),
              ),
              image: DecorationImage(
                image: AssetImage(
                  "images/coffee2.jpg",
                ),
                fit: BoxFit.cover,
                opacity: 0.9,
              ),
            ),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: colors.grayC1r,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: colors.grayC1r,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            Icons.favorite,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Container(
                  height: 120,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Cappucino",
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1,
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "With Fresh Milk",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                        ),
                      ),
                      //SizedBox(
                      //  height: 10,
                      // ),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: colors.pC1r,
                            size: 25,
                          ),
                          SizedBox(width: 10),
                          Text(
                            "4.5",
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Description : ",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "A cappucino is a coffee-based drink made primarly from espresso and milk. A cappucino is a coffee-based drink made primarly from espresso and milk",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
                // SizedBox(
                // height: 10,
                //  ),
                Text(
                  "Size : ",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                // SizedBox(
                // height: 5,
                //  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    for (int i = 0; i < 3; i++)
                      Container(
                        margin: EdgeInsets.all(10),
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 45),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: i == 0 ? colors.pC1r : colors.grayC1r,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            sizes[i],
                            style: TextStyle(
                              color: colors.grayC1r,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        height: 80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Price",
                  style: TextStyle(
                    color: colors.grayC1r,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "\$",
                      style: TextStyle(
                        color: colors.pC1r,
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      "4.20",
                      style: TextStyle(
                        color: colors.grayC1r,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 18, horizontal: 80),
              decoration: BoxDecoration(
                color: colors.pC1r,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Text(
                "Buy Now",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
