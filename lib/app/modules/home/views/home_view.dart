import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import 'widgets/berat_barang.dart';
import 'widgets/city.dart';
import 'widgets/province.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RAJA ONGKIR'),
        centerTitle: true,
        backgroundColor: Colors.orange,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Provinsi(tipe: "asal"),
          Obx(
            () => controller.hiddenKotaAsal.isTrue
                ? const SizedBox()
                : Kota(
                    provId: controller.provIdAsal.value,
                    tipe: "asal",
                  ),
          ),
          Provinsi(tipe: "tujuan"),
          Obx(
            () => controller.hiddenKotaTujuan.isTrue
                ? const SizedBox()
                : Kota(
                    provId: controller.provIdTujuan.value,
                    tipe: "tujuan",
                  ),
          ),
          BeratBarang(),
          Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: DropdownSearch<Map<String, dynamic>>(
              items: const [
                {"code": "jne", "name": "Jalur Nugraha Ekakurir (JNE)"},
                {"code": "tiki", "name": "Titipan Kilat (TIKI)"},
                {
                  "code": "pos",
                  "name": "Perusahaan Opsional Surat (POS)",
                },
              ],
              itemAsString: (item) => "${item['name']}",
              clearButtonProps: const ClearButtonProps(
                color: Colors.red,
                icon: Icon(Icons.clear),
                padding: EdgeInsets.all(8),
                isVisible: true,
              ),
              popupProps: PopupProps.menu(
                itemBuilder: (context, item, isSelected) => Container(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    "${item['name']}",
                    style: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                    ),
                  ),
                ),
                // showSelectedItems: true,
              ),
              dropdownDecoratorProps: const DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Kurir",
                ),
              ),
              // selectedItem: "jne",
              onChanged: (value) {
                if (value != null) {
                  controller.kurir.value = value["code"];
                  controller.showButton();
                } else {
                  controller.hiddenbutton.value = true;
                  controller.kurir.value = "";
                }
              },
            ),
          ),
          Obx(
            () => controller.hiddenbutton.isTrue
                ? const SizedBox()
                : ElevatedButton(
                    onPressed: () {},
                    child: const Text("CEK ONGKOS KIRIM"),
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        backgroundColor: Colors.orange),
                  ),
          ),
        ],
      ),
    );
  }
}
