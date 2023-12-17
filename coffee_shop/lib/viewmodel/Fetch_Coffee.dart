import 'dart:convert';
import 'package:coffee_shop/model/coffeeModel.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class Repository {
  var apiUrl = 'https://coffee-shop-6b6ff-default-rtdb.firebaseio.com/jsondata/datacoffee.json?auth=Gtv0pY1JtyRURVkZk8jgL4wuHOV60Zh04ust4A96';
  // var apiUrl = 'http://192.168.147.138:8000/api/dongeng';
  Future<List<coffeeModel>> fetchData() async {
    Response response = await http.get(Uri.parse(apiUrl));
    List<coffeeModel> dataCoffee;
    if (response.statusCode == 200) {
      List<dynamic> listJson = json.decode(response.body)["datacoffee"];
      dataCoffee = listJson.map((e) => coffeeModel.fromJson(e)).toList();
      // Map<String, dynamic> listJson = json.decode(response.body);
      // dataGunung = listJson.values.map((e) {
      //   return Gunung.fromJson(e);
      // }).toList();
      print(dataCoffee);
      return dataCoffee;
    } else {
      throw Exception('Failed to load data');
    }
  }
}