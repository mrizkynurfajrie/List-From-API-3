import 'package:penggajian/framework/api1.dart';

class ApiPenggajian {
  Future<dynamic> getDataKaryawan() async {
    var r = await Api1().apiJSONGet('karyawan');
    return r;
  }
}
