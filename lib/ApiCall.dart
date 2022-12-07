import 'dart:convert';
import 'package:flutter/material.dart';
import 'UniversityModel.dart';
import 'package:http/http.dart' as http;
import 'CountryData.dart';

class ApiCall extends StatefulWidget {
  final List<CountryData> universityModel;
  int index;
  ApiCall({Key? key, required this.index, required this.universityModel})
      : super(key: key);

  @override
  State<ApiCall> createState() => _ApiCallState();
}

class _ApiCallState extends State<ApiCall> {
  Future<List<UniversityModel>> getUniversityData() async {
    var serverURL = 'http://universities.hipolabs.com/search?country=';
    var key = widget.universityModel[widget.index].names;
    var url = '$serverURL$key';
    var response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      List jsonResponse = jsonDecode(response.body);

      return jsonResponse
          .map((data) => UniversityModel.fromJson(data))
          .toList();
    } else {
      throw Exception();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
            Color.fromARGB(255, 138, 235, 255),
            Color.fromARGB(255, 223, 136, 255)
          ])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: FutureBuilder<List<UniversityModel>>(
          future: getUniversityData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    margin: const EdgeInsets.all(6),
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: ListTile(
                        title: Text(
                          snapshot.data![index].name.toString(),
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        subtitle:
                            Text(snapshot.data![index].country.toString()),
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: Container(
            width: 100,
            height: 60,
            decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(colors: [
                  Color.fromARGB(255, 223, 136, 255),
                  Color.fromARGB(255, 138, 235, 255),
                ])),
            child: const Icon(Icons.arrow_back_ios_rounded),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
