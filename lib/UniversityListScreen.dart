import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'UniversityModel.dart';
import 'package:http/http.dart' as http;
import 'CountryData.dart';

class UniversityListScreen extends StatefulWidget {
  final List<CountryData> universityModel;
  int index;
  UniversityListScreen(
      {Key? key, required this.index, required this.universityModel})
      : super(key: key);

  @override
  State<UniversityListScreen> createState() => _UniversityListScreenState();
}

class _UniversityListScreenState extends State<UniversityListScreen> {
  List<UniversityModel> universities = [];

  showDialogBox() => showCupertinoDialog<String>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text('No internet connection'),
          content:
              const Text('Please check your internet connection and try again'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {});
              },
              child: const Text('Retry'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              child: const Text('Back'),
            ),
          ],
        ),
      );

  Future<List<UniversityModel>> getUniversityData() async {
    var serverURL = 'http://universities.hipolabs.com/search?country=';
    var key = widget.universityModel[widget.index].names;
    var url = '$serverURL$key';
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        return jsonResponse
            .map((data) => UniversityModel.fromJson(data))
            .toList();
      }
    } on SocketException {
      showDialogBox();
    }
    return universities = [];
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
            Color.fromARGB(255, 223, 136, 255),
          ])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: FutureBuilder<List<UniversityModel>>(
          future: getUniversityData(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return RefreshIndicator(
                onRefresh: getUniversityData,
                child: ListView.builder(
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
                ),
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
