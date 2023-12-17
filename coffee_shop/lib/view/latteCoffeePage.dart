// ignore_for_file: must_be_immutable

import 'package:coffee_shop/model/coffeeModel.dart';
import 'package:coffee_shop/viewmodel/Fetch_Coffee.dart';
import 'package:coffee_shop/view/menuItemcard.dart';
import 'package:flutter/material.dart';

class LatteCoffeePage extends StatelessWidget {
  Repository repo = Repository();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: repo.fetchData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError || snapshot.data == null) {
          return Text('Error: Gagal mengambil data');
        } else {
          List<coffeeModel> menu = snapshot.data;

          // final AmericanoMenu = menu.where((item) => item.jenis == "americano").toList();
          // final CappucinoMenu = menu.where((item) => item.jenis == "cappucino").toList();
          final LatteMenu = menu.where((item) => item.jenis == "latte").toList();

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Tampilan OtherMenu
                Text(
                  '\t\t\t\tLatte Menu',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Container(
                  height: MediaQuery.of(context).size.height * 0.5,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: LatteMenu.length,
                    itemBuilder: (context, int index) {
                      return MenuItemCard(
                        index: index,
                        menuItem: LatteMenu[index],
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
