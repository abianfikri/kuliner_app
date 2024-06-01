import 'dart:convert';
import 'dart:io';

import 'package:flutter_kuliner_app/model/kuliner_model.dart';
import 'package:flutter_kuliner_app/service/kuliner_service.dart';

class KulinerController {
  final kulinerService = KulinerService();

  // Get All data from API to UI
  Future<List<KulinerModel>> getDataKuliner() async {
    try {
      List<dynamic> kulinerData = await kulinerService.fetchKuliner();

      List<KulinerModel> kuliner =
          kulinerData.map((e) => KulinerModel.fromMap(e)).toList();

      return kuliner;
    } catch (e) {
      throw Exception('Failed to get kuliner: $e');
    }
  }

  // Add Kuliner
  Future<Map<String, dynamic>> addPersonData(
      KulinerModel kulinerModel, File? file) async {
    Map<String, String> data = {
      "uid": kulinerModel.uid.toString(),
      "namaKuliner": kulinerModel.namaKuliner,
      "alamatKuliner": kulinerModel.alamatKuliner,
      "catatanReview": kulinerModel.catatanReview,
      "rating": kulinerModel.rating.toString(),
    };

    try {
      var response = await kulinerService.addKuliner(data, file);
      if (response.statusCode == 201) {
        return {'success': true, "message": "Data berhasil disimpan"};
      } else {
        if (response.headers['content-type']!.contains('application/json')) {
          var decodedJson = jsonDecode(response.body);
          return {
            'success': false,
            "message": decodedJson['message'] ?? 'Terjadi Kesalahan',
          };
        }

        var decodedJson = jsonDecode(response.body);
        return {
          'success': false,
          'message':
              decodedJson['message'] ?? 'Terjadi Kesalahan saat Menyimpan Data'
        };
      }
    } catch (e) {
      return {"success": false, "message": 'Terjadi Kesalahan: $e'};
    }
  }
}
