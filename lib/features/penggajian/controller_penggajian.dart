import 'dart:developer';

import 'package:get/get.dart';
import 'package:penggajian/features/penggajian/api_penggajian.dart';
import 'package:penggajian/response/penggajian.dart';

class ControllerPenggajian extends GetxController
    with StateMixin<List<Penggajian>> {
  final ApiPenggajian api;
  ControllerPenggajian({required this.api});

  final listData = List<Penggajian>.empty().obs;
  var loading = false.obs;
  final List gajiBulan = [
    25000000,
    29166666,
    30000000,
    20000000,
    30000000,
    30000000
  ];

  @override
  void onInit() async {
    // TODO: implement onInit
    await getData();
    calculation();
    super.onInit();
  }

  getData() async {
    loading.value = true;
    try {
      var r = await api.getDataKaryawan();
      log('data : $r');
      if (r != null) {
        var result = r;
        var resultListData = (result as List)
            .map((result) => Penggajian.fromJson(result))
            .toList();
        if (resultListData.isNotEmpty) {
          listData.clear();
          listData.addAll(resultListData);
        }
        loading.value = false;
      }
    } catch (e) {
      print(e.toString());
      loading.value = false;
    }
  }

  calculation() {
    listData.forEach((item) {
      //Penghasilan Bruto//
      item.penghasilanBulanan = item.penghasilanBulanan! * 12;

      //Penghasilan Netto//
      var ptkp = 0;
      var totalAsuransi = item.asuransi! * 12;
      double netto = 0.0;
      if (item.statusPerkawinan == "TK") {
        ptkp = 25000000;
      } else {
        if (item.statusPerkawinan == "K0") {
          ptkp = 50000000;
        } else {
          if (item.statusPerkawinan == "K1") {
            ptkp = 75000000;
          } else {
            if (item.statusPerkawinan == "BK") {
              ptkp = 15000000;
              totalAsuransi;
            } else {
              if (item.statusPerkawinan == "SK") {
                ptkp = 30000000;
                totalAsuransi;
              }
            }
          }
        }
      }
      netto = (item.penghasilanBulanan! - totalAsuransi - ptkp) / 12;
      item.penghasilanNetto = netto.round();

      //Pajak Penghasilan
      double pajak = 0.0;
      var layer1 = 50000000 * 0.05;
      double layer2 = 0.0;
      var nettoTahun = item.penghasilanNetto!.floor() * 12;

      if (item.negara == "Indonesia" && nettoTahun <= 50000000) {
        pajak = 0.05;
        layer2 = ((item.penghasilanNetto!.floor() * 12) - 50000000) * pajak;
        item.pajakPenghasilan = ((layer1 + layer2) / 12).floor();
      } else {
        if (item.negara == "Indonesia" && nettoTahun <= 250000000) {
          pajak = 0.10;
          layer2 = ((item.penghasilanNetto!.floor() * 12) - 50000000) * pajak;
          item.pajakPenghasilan = ((layer1 + layer2) / 12).floor();
        } else {
          if (item.negara == "Indonesia" && nettoTahun >= 250000000) {
            pajak = 0.15;
            layer2 = ((item.penghasilanNetto!.floor() * 12) - 50000000) * pajak;
            item.pajakPenghasilan = ((layer1 + layer2) / 12).floor();
          } else {
            if (item.negara == "Vietnam" && nettoTahun <= 50000000) {
              pajak = 0.025;
              layer2 =
                  ((item.penghasilanNetto!.floor() * 12) - 50000000) * pajak;
              item.pajakPenghasilan = ((layer1 + layer2) / 12).floor();
            } else {
              if (item.negara == "Vietnam" && nettoTahun >= 50000000) {
                pajak = 0.075;
                layer2 =
                    ((item.penghasilanNetto!.floor() * 12) - 50000000) * pajak;
                item.pajakPenghasilan = ((layer1 + layer2) / 12).floor();
              }
            }
          }
        }
      }
    });
  }
}
