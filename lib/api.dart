import 'dart:convert';

import 'constants.dart';
import 'models/photo.dart';
import 'package:http/http.dart' as http;

class PhotoAPI{

  Future<List<Photo>> fetchPhotos(int page) async {
    final response = await http.get(BASE_URL+'&page=$page');

    final parsed = jsonDecode(response.body).cast<Map<String, dynamic>>();

    return parsed.map<Photo>((json) => Photo.fromJson(json)).toList();
  }

}