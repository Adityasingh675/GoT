import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:got_app/got.dart';

class EpisodesPage extends StatelessWidget {
  final List<Episodes> episodes;
  final MyImage myimage;
  EpisodesPage({this.episodes, this.myimage});
  BuildContext _context;

  showSummary(String summary) {
    showDialog(
      context: _context,
      builder: (context) => Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Text(summary),
            ),
          ),
        ),
      ),
    );
  }

  Widget myBody() {
    return GridView.builder(
      itemCount: episodes.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, childAspectRatio: 1.0),
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            showSummary(episodes[index].summary);
          },
          child: Card(
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  episodes[index].image.original,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Text(
                        episodes[index].name,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  left: 0.0,
                  top: 0.0,
                  child: Container(
                    color: Colors.redAccent,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "${episodes[index].season} - ${episodes[index].number}",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _context = context;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        title: Row(
          children: [
            Hero(
              tag: 'pic',
              child: CircleAvatar(
                backgroundImage: NetworkImage(myimage.original),
              ),
            ),
            SizedBox(width: 10.0),
            Text("Episodes"),
          ],
        ),
      ),
      body: myBody(),
    );
  }
}
