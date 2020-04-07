import 'dart:io';

import 'package:http/http.dart' as http;
class NetworkHelper{
  final String url;
  final String publicKey = "5a7ec58775ac8842507c93b12d960906";

  NetworkHelper(this.url);

  Future<http.Response> getData() async {
    http.Response response = await http.get(url);
    return response;
  }

}