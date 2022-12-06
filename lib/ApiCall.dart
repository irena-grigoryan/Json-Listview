import 'dart:convert';
import 'UniversityModel.dart';
import 'package:http/http.dart' as http;

Future<List<UniversityModel>> getUniversityData() async {
  var response = await http.get(
      Uri.parse('http://universities.hipolabs.com/search?country=Georgia'));
  if (response.statusCode == 200) {
    List jsonResponse = jsonDecode(response.body);
    return jsonResponse.map((data) => UniversityModel.fromJson(data)).toList();
  } else {
    throw Exception();
  }
}
