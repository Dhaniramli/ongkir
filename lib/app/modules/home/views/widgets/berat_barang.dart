import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/home_controller.dart';

class BeratBarang extends GetView<HomeController> {
  const BeratBarang({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            onChanged: (value) {
              controller.ubahBerat(value);
            },
            autocorrect: false,
            controller: controller.beratC,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(
              labelText: "Berat Barang",
              border: OutlineInputBorder(),
            ),
          ),
        ),
        const SizedBox(width: 20),
        SizedBox(
          width: 150.0,
          child: DropdownSearch<String>(
            popupProps: const PopupProps.menu(
              showSelectedItems: true,
              // disabledItemFn: (String s) => s.startsWith('I'),
            ),
            items: [
              "ton",
              "kwintal",
              "ons",
              "lbs",
              "pound",
              "kg",
              "hg",
              "dag",
              "gram",
              "dg",
              "cg",
              "mg",
            ],
            dropdownDecoratorProps: const DropDownDecoratorProps(
              dropdownSearchDecoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Satuan",
              ),
            ),
            selectedItem: "gram",
            onChanged: (value) {
              controller.ubahSatuan(value!);
            },
          ),
        ),
      ],
    );
  }
}
