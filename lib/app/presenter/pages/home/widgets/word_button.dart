import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:read_text/app/core/model/text_model.dart';
import 'package:read_text/app/domain/domains/home_domain.dart';

class WordButton extends StatelessWidget {
  const WordButton({
    Key? key,
    required this.homeDomain,
    required this.word,
    required this.language,
    required this.moreThanOneWordList,
  }) : super(key: key);

  final HomeDomain homeDomain;
  final String word;
  final String language;
  final List<String> moreThanOneWordList;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.mediumImpact();
        homeDomain.translate(word, language);
      },
      onLongPress: () {
        if (moreThanOneWordList.contains("$word ")) {
          if (moreThanOneWordList.length == 1) {
            HapticFeedback.vibrate();
            moreThanOneWordList.remove("$word ");
            TextModel textModel = TextModel();
            homeDomain.textListenable.value = textModel;
          } else {
            HapticFeedback.vibrate();
            moreThanOneWordList.remove("$word ");
            String phrase = moreThanOneWordList.join();
            homeDomain.translate(phrase, language);
          }
        } else {
          HapticFeedback.vibrate();
          moreThanOneWordList.add("$word ");
          String phrase = moreThanOneWordList.join();
          homeDomain.translate(phrase, language);
        }
      },
      child: Text(
        "$word  ",
        style: const TextStyle(
          fontSize: 18,
          color: Color.fromARGB(255, 221, 221, 221),
        ),
      ),
    );
  }
}
