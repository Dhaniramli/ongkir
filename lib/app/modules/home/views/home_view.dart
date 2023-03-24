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
        ],
      ),
    );
  }
}
