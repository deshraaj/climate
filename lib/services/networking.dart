import 'dart:convert';
import 'package:clima/utilities/utils.dart';
import 'package:http/http.dart';

class Networking {
  Networking(this.url);

  final String url;

  Future getData() async {
    Response response = await get(
      Uri.parse(url),
    );
    var n = response.statusCode;
    if (n == 200) {
      return jsonDecode(response.body);
    } else {
      Utils.toastMessage('Status cond $n');
    }
  }
}
