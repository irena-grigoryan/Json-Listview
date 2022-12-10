import 'package:flutter/material.dart';
import 'package:json_listview/UniversityListScreen.dart';
import 'CountryData.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: CountryScreen(),
  ));
}

class CountryScreen extends StatefulWidget {
  @override
  State<CountryScreen> createState() => _CountryScreenState();
}

class _CountryScreenState extends State<CountryScreen> {
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
            child: ListView.builder(
              itemCount: countryData.length,
              itemBuilder: ((context, index) {
                return Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  margin: const EdgeInsets.all(6),
                  child: Padding(
                    padding: const EdgeInsets.all(14),
                    child: ListTile(
                      leading: SizedBox(
                        width: 60,
                        height: 60,
                        child: Image.network(countryData[index].ImageUrl),
                      ),
                      title: Text(
                        countryData[index].names,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      trailing: const Icon(Icons.arrow_forward_ios_rounded),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => UniversityListScreen(
                              index: index,
                              universityModel: countryData,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
