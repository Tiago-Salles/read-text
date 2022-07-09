import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'widgets/word_item.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 248, 245, 245),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 248, 245, 245),
        elevation: 0,
        leading: Icon(
          Icons.navigate_before_outlined,
          color: Colors.black,
          size: 35,
        ),
        centerTitle: true,
        actions: [
          Container(
            decoration:
                BoxDecoration(color: Color(0XAAFFEDBF), shape: BoxShape.circle),
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.tune),
              color: Colors.black,
            ),
          )
        ],
        title: Text(
          'Favoritos',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        children: [
          Lottie.network(
            "https://assets5.lottiefiles.com/datafiles/SkdS7QDyJTKTdwA/data.json",
            controller: AnimationController(
              animationBehavior: AnimationBehavior.normal,
              duration: Duration(
                seconds: 1,
              ),
              vsync: this,
            ),
            height: 250,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                'PALAVRAS MARCADAS',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Flexible(
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: [
                WordItem(),
                WordItem(),
                WordItem(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
