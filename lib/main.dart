import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:got_app/episodes_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'got.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String url =
      "http://api.tvmaze.com/singlesearch/shows?q=game-of-thrones&embed=episodes";

  GOT got;

  Widget myCard() {
    return SingleChildScrollView(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Hero(
                tag: 'pic',
                child: CircleAvatar(
                  radius: 100.0,
                  backgroundImage: NetworkImage(got.image.original),
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                got.name,
                style: GoogleFonts.roboto(
                  textStyle: TextStyle(
                    color: Colors.blue.shade600,
                    fontSize: 32.0,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              Text(
                "Runtime: ${got.runtime.toString()} minutes",
                style: GoogleFonts.roboto(
                  textStyle: TextStyle(
                    color: Colors.blue.shade600,
                    fontSize: 25.0,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: 12.0),
              Text(
                got.summary,
                style: GoogleFonts.roboto(
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 15.0,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: 12.0),
              RaisedButton(
                color: Colors.blue.shade800,
                child: Text(
                  "Episodes",
                  style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EpisodesPage(
                        episodes: got.eEmbedded.episodes,
                        myimage: got.image,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget myBody() {
    return (got == null)
        ? Center(child: CircularProgressIndicator())
        : myCard();
  }

  @override
  void initState() {
    super.initState();
    fetchEpisodes();
  }

  fetchEpisodes() async {
    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      var decodedJson = jsonDecode(response.body);
      print(decodedJson);
      got = GOT.fromJson(decodedJson);
    } else {
      print("Request failed: ${response.statusCode}");
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        title: Text('Game Of Thrones'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.refresh),
        onPressed: () {
          fetchEpisodes();
        },
      ),
      body: myBody(),
    );
  }
}
