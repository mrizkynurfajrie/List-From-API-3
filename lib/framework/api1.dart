import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class Api1 {
  String baseUrl = 'https://64115154e96e5254e2d20a03.mockapi.io/apipenggajian/';

  Future<dynamic> apiJSONGet(
    String url,
  ) async {
    Map<String, String> headers = {
      'content-Type': 'application/json',
    };
    log('headers = $headers');
    log('url = $baseUrl$url');

    http.Response r =
        await http.get(Uri.parse(baseUrl + url), headers: headers);
    log("status codenya ${r.statusCode}");
    var data = json.decode(r.body);
    // log('data : $data');
    // logApi(url: url, res: r, method: "GET");
    return data;
  }

  Future<dynamic> apiJSONPost(String url, Map<String, dynamic> params) async {
    Map<String, String> headers = {
      'content-Type': 'application/json',
    };
    log('headers = $headers');
    log('url = $baseUrl$url');

    var r = await http.post(Uri.parse(baseUrl + url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(params),
        encoding: Encoding.getByName("utf-8"));
    var data = jsonDecode(r.body);
    log("status codenya ${r.statusCode}");

    // log(data.toString());
    return data;
  }
}
