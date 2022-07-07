import 'package:flutter/material.dart';
import 'package:read_text/app/core/model/text_model.dart';
import 'package:read_text/app/domain/domains/home_domain.dart';

class HomeBottomSheet extends StatelessWidget {
  const HomeBottomSheet({
    Key? key,
    required this.homeDomain,
    required this.moreThanOneWordList,
  }) : super(key: key);

  final HomeDomain homeDomain;
  final List<String> moreThanOneWordList;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 120,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.blue[200],
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(60),
        ),
      ),
      child: ValueListenableBuilder<TextModel?>(
        valueListenable: homeDomain.textListenable,
        builder: (context, textModel, widget) {
          if (textModel?.translatedText == null) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "Escolha uma palavra para traduzir",
                ),
              ],
            );
          } else {
            return Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: SingleChildScrollView(
                    child: Text(
                      "${textModel?.translatedText}",
                    ),
                  ),
                ),
                const SizedBox(width: 30),
                IconButton(
                  onPressed: () {
                    moreThanOneWordList.clear();
                    TextModel textModel = TextModel();
                    homeDomain.textListenable.value = textModel;
                  },
                  iconSize: 50,
                  icon: const Icon(Icons.highlight_remove_sharp),
                )
              ],
            );
          }
        },
      ),
    );
  }
}
