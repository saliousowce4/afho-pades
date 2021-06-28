import 'dart:async';
import 'dart:convert';
import 'package:appafhopades/constants/constants.dart';
import 'package:appafhopades/models/electeur.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ElecteurListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(body: FutureBuilder<List<Electeur>>(
      future: _fetchElecteurs(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Electeur> data = snapshot.data;
          return _ElecteurListView(data);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return CircularProgressIndicator();
      },
    ));
  }

  Future<List<Electeur>> _fetchElecteurs() async {
    final electeurListAPIUrl = 'https://dry-garden-22624.herokuapp.com/api/client/electeur';
    final response = await http.get(electeurListAPIUrl);

    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((job) => new Electeur.fromJson(job)).toList();
    } else {
      throw Exception('Failed to load jobs from API');
    }
  }

  ListView _ElecteurListView(data) {
    return ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return _tile(data[index].nom, data[index].prenom, Icons.work);
        });
  }

  ListTile _tile(String title, String subtitle, IconData icon) => ListTile(
    title: Text(title,
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 20,
        )),
    subtitle: Text(subtitle),
    leading: Icon(
      icon,
      color: kPrimaryColor,
    ),

  );

}