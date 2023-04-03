import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import '../../city_model.dart';
import '../../controllers/home_controller.dart';

class Kota extends GetView<HomeController> {
  const Kota({
    super.key,
    required this.provId,
    required this.tipe,
  });

  final int provId;
  final String tipe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: DropdownSearch<City>(
        dropdownDecoratorProps: DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
            border: OutlineInputBorder(),
            label: tipe == "asal"
                ? Text("Kota / Kabupaten Asal")
                : Text("Kota / Kabupaten Tujuan"),
          ),
        ),
        asyncItems: (String filter) async {
          Uri url = Uri.parse(
              "https://api.rajaongkir.com/starter/city?province=$provId");

          try {
            final response = await http.get(
              url,
              headers: {
                "key": "b1001cc0089b53bc6c7f628d7112ce2e",
              },
            );

            var data = json.decode(response.body) as Map<String, dynamic>;

            var statusCode = data["rajaongkir"]["status"]["code"];

            if (statusCode != 200) {
              throw data["rajaongkir"]["status"]["description"];
            }

            var listAllCity = data["rajaongkir"]["results"] as List<dynamic>;

            var models = City.fromJsonList(listAllCity);
            return models;
          } catch (err) {
            print(err);
            return List<City>.empty();
          }
        },
        clearButtonProps: const ClearButtonProps(
          color: Colors.red,
          icon: Icon(Icons.clear),
          padding: EdgeInsets.all(8),
          isVisible: true,
        ),
        itemAsString: (City city) => "${city.type} ${city.cityName}",
        onChanged: (value) {
          if (value != null) {
            if (tipe == "asal") {
              controller.kotaIdAsal.value = int.parse(value.cityId!);
            } else {
              controller.kotaIdTujuan.value = int.parse(value.cityId!);
            }
          } else {
            if (tipe == "asal") {
              print("Tidak Memilih kota / kabupaten asal apapun");
              controller.kotaIdAsal.value = 0;
            } else {
              print("Tidak Memilih kota / kabupaten tujuan apapun");
              controller.kotaIdTujuan.value = 0;
            }
          }
          controller.showButton();
        },
      ),
    );
  }
}
