import 'dart:convert';
import 'package:flutter/material.dart';
import 'ApiCall.dart';
import 'UniversityModel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HttpScreen(),
    );
  }
}

class HttpScreen extends StatelessWidget {
  const HttpScreen({super.key});

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
        body: SafeArea(
          child: Center(
            child: FutureBuilder<List<UniversityModel>>(
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
                              style:
                                  const TextStyle(fontWeight: FontWeight.w500),
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
                return const CircularProgressIndicator();
              },
            ),
          ),
        ),
      ),
    );
  }
}
