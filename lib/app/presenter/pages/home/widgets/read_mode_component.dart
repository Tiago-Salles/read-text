import 'package:flutter/material.dart';
import 'package:read_text/app/domain/domains/home_domain.dart';
import 'package:read_text/app/presenter/pages/home/widgets/word_button.dart';

class ReadModeComponent extends StatelessWidget {
  const ReadModeComponent({
    Key? key,
    required this.wordsToSeparete,
    required this.homeDomain,
    required this.language,
    required this.moreThanOneWordList,
  }) : super(key: key);

  final String wordsToSeparete;
  final HomeDomain homeDomain;
  final String language;
  final List<String> moreThanOneWordList;

  @override
  Widget build(BuildContext context) {
    List<String> words = wordsToSeparete.split(" ");
    List<Widget> children = [];

    for (String word in words) {
      children.add(
        WordButton(
          homeDomain: homeDomain,
          word: word,
          language: language,
          moreThanOneWordList: moreThanOneWordList,
        ),
      );
    }

    return Wrap(
      children: children,
    );
  }
}
