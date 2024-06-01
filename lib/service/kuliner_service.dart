import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class KulinerService {
  final String baseUrl = 'http://10.0.2.2:8000/api/';
  final String endpoint = 'kuliner';

  Uri getUri(String path) {
    return Uri.parse("$baseUrl$path");
  }

  // Add Data
  Future<http.Response> addKuliner(Map<String, String> data, File? file) async {
    var request = http.MultipartRequest(
      'POST',
      getUri(endpoint),
    )
      ..fields.addAll(data)
      ..headers['Content-Type'] = 'application/json';

    if (file != null) {
      request.files.add(await http.MultipartFile.fromPath('gambar', file.path));
    } else {
      request.files.add(http.MultipartFile.fromString('gambar', ''));
    }

    return await http.Response.fromStream(await request.send());
  }

  // Get data from Api
  Future<List<dynamic>> fetchKuliner() async {
    var response = await http.get(
        getUri(
          endpoint,
        ),
        headers: {
          "Accept": "application/json",
        });

    if (response.statusCode == 200) {
      final Map<String, dynamic> decodeResponse = jsonDecode(response.body);
      return decodeResponse['kuliner'];
    } else {
      throw Exception('Failed to load Kuliner: ${response.reasonPhrase}');
    }
  }
}
