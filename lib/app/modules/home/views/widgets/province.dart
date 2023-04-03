import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../controllers/home_controller.dart';
import '../../province_model.dart';

class Provinsi extends GetView<HomeController> {
  const Provinsi({super.key, required this.tipe});

  final String tipe;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: DropdownSearch<Province>(
        dropdownDecoratorProps: DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
            border: const OutlineInputBorder(),
            label: tipe == "asal"
                ? const Text("Provinsi Asal")
                : const Text("Provinsi Tujuan"),
          ),
        ),
        asyncItems: (String filter) async {
          Uri url = Uri.parse("https://api.rajaongkir.com/starter/province");

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

            var listAllProvince =
                data["rajaongkir"]["results"] as List<dynamic>;

            var models = Province.fromJsonList(listAllProvince);
            return models;
          } catch (err) {
            print(err);
            return List<Province>.empty();
          }
        },
        clearButtonProps: const ClearButtonProps(
          color: Colors.red,
          icon: Icon(Icons.clear),
          padding: EdgeInsets.all(8),
          isVisible: true,
        ),
        itemAsString: (Province province) => province.province as String,
        onChanged: (value) {
          if (value != null) {
            if (tipe == "asal") {
              controller.hiddenKotaAsal.value = false;
              controller.provIdAsal.value = int.parse(value.provinceId!);
            } else {
              controller.hiddenKotaTujuan.value = false;
              controller.provIdTujuan.value = int.parse(value.provinceId!);
            }
          } else {
            if (tipe == "asal") {
              controller.hiddenKotaAsal.value = true;
              controller.provIdAsal.value = 0;
            } else {
              controller.hiddenKotaTujuan.value = true;
              controller.provIdTujuan.value = 0;
            }
          }
          controller.showButton();
        },
      ),
    );
  }
}
