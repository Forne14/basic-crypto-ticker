import 'dart:io';

import 'package:http/http.dart' as http;
class NetworkHelper{
  final String url;

  NetworkHelper(this.url);

  Future<http.Response> getData() async {
    http.Response response = await http.get(url);
    return response;
  }

}