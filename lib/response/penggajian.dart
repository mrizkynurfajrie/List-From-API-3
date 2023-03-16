// To parse this JSON data, do
//
//     final penggajian = penggajianFromJson(jsonString);

import 'dart:convert';

List<Penggajian> penggajianFromJson(String str) => List<Penggajian>.from(json.decode(str).map((x) => Penggajian.fromJson(x)));

String penggajianToJson(List<Penggajian> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Penggajian {
    Penggajian({
        this.nama,
        this.statusPerkawinan,
        this.penghasilanBulanan,
        this.negara,
        this.asuransi,
        this.penghasilanNetto,
        this.pajakPenghasilan,
        this.id,
    });

    String? nama;
    String? statusPerkawinan;
    int? penghasilanBulanan;
    String? negara;
    int? asuransi;
    int? penghasilanNetto;
    int? pajakPenghasilan;
    String? id;

    factory Penggajian.fromJson(Map<String, dynamic> json) => Penggajian(
        nama: json["nama"],
        statusPerkawinan: json["status_perkawinan"],
        penghasilanBulanan: json["penghasilan_bulanan"],
        negara: json["negara"],
        asuransi: json["asuransi"],
        penghasilanNetto: json["penghasilan_netto"],
        pajakPenghasilan: json["pajak_penghasilan"],
        id: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "nama": nama,
        "status_perkawinan": statusPerkawinan,
        "penghasilan_bulanan": penghasilanBulanan,
        "negara": negara,
        "asuransi": asuransi,
        "penghasilan_netto": penghasilanNetto,
        "pajak_penghasilan": pajakPenghasilan,
        "id": id,
    };
}
