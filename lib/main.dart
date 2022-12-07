import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:json_listview/ApiCall.dart';
import 'CountryData.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

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
  late StreamSubscription subscription;
  bool isConnected = false;
  bool isAlertSet = false;

  @override
  void initState() {
    checkConnectivity();
    super.initState();
  }

  checkConnectivity() =>
      subscription = Connectivity().onConnectivityChanged.listen(
        (ConnectivityResult result) async {
          isConnected = await InternetConnectionChecker().hasConnection;
          if (!isConnected && isAlertSet == false) {
            showDialogBox();
            setState(() => isAlertSet = true);
          }
        },
      );

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  showDialogBox() => showCupertinoDialog<String>(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: const Text('No internet connection'),
          content:
              const Text('Please check your internet connection and try again'),
          actions: <Widget>[
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                setState(() => isAlertSet = false);
                isConnected = await InternetConnectionChecker().hasConnection;
                if (!isConnected && isAlertSet == false) {
                  showDialogBox();
                  setState(() => isAlertSet = true);
                }
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      );

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
                            builder: (context) => ApiCall(
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
