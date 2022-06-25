import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class WordItem extends StatefulWidget {
  WordItem({Key? key}) : super(key: key);

  @override
  State<WordItem> createState() => _WordItemState();
}

class _WordItemState extends State<WordItem> {
  bool icon = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
        height: 100,
        width: 150,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 1.5,
              )
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'English',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'How are you?',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      'Tradução',
                      style: TextStyle(
                        color: Colors.teal,
                      ),
                    ),
                    Text(
                      'Como vai você?',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                GestureDetector(
                  child: Icon(
                    Icons.drag_handle,
                    size: 30,
                    color: color,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color? color;
}
