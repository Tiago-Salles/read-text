import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:read_text/app/core/app_module/app_modules.dart';
import 'package:read_text/app/core/model/text_model.dart';
import 'package:read_text/app/domain/domains/home_domain.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

StreamController<bool> readOnlyStreamController =
    StreamController<bool>.broadcast();

class _HomePageState extends State<HomePage> {
  late final HomeDomain homeDomain;
  late TextEditingController textController;
  late TextEditingController fullTextController;

  @override
  void initState() {
    homeDomain = AppModules.homeDomain;
    textController = TextEditingController();
    fullTextController = TextEditingController();
    super.initState();
  }

  bool readOnly = false;
  bool selectedWord = false;
  List<String> moreThanTwoWordsList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.blue[200],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextButton(
                    onPressed: () {
                      setState(() {
                        readOnly = !readOnly;
                      });

                      readOnlyStreamController.sink.add(readOnly);
                    },
                    child: Text(
                      readOnly == false ? "Modo leitura" : "Adicionar texto",
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.all(10),
              height: 600,
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 246, 197),
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 5,
                  )
                ],
              ),
              child: SingleChildScrollView(
                child: StreamBuilder<bool>(
                  stream: readOnlyStreamController.stream,
                  builder: (context, snapshot) {
                    if (snapshot.data == true) {
                      List<String> words = fullTextController.text.split(" ");
                      List<Widget> children = [];
                      Widget? wordButton;

                      for (String word in words) {
                        wordButton = GestureDetector(
                          onTap: () {
                            HapticFeedback.mediumImpact();
                            homeDomain.translate(word);
                          },
                          onLongPress: () {
                            if (moreThanTwoWordsList.contains("$word ")) {
                              if (moreThanTwoWordsList.length == 1) {
                                HapticFeedback.vibrate();
                                moreThanTwoWordsList.remove("$word ");
                                TextModel textModel = TextModel();
                                homeDomain.textStreamController.sink
                                    .add(textModel);
                              } else {
                                HapticFeedback.vibrate();
                                moreThanTwoWordsList.remove("$word ");
                                String phrase = moreThanTwoWordsList.join();
                                homeDomain.translate(phrase);
                              }
                            } else {
                              HapticFeedback.vibrate();
                              moreThanTwoWordsList.add("$word ");
                              String phrase = moreThanTwoWordsList.join();
                              homeDomain.translate(phrase);
                            }
                          },
                          child: Text(
                            "$word  ",
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black87,
                            ),
                          ),
                        );
                        children.add(wordButton);
                      }

                      return Wrap(
                        children: children,
                      );
                    } else {
                      return TextFormField(
                        readOnly: readOnly,
                        maxLines: null,
                        controller: fullTextController,
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: readOnly == true
                                  ? Colors.transparent
                                  : Colors.grey,
                            ),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(10),
        height: 120,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(60),
          ),
        ),
        child: StreamBuilder<TextModel?>(
          stream: homeDomain.textStreamController.stream,
          builder: (context, snapshot) {
            if (snapshot.data?.translatedText == null) {
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
                    color: Colors.black38,
                    padding: const EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: SingleChildScrollView(
                      child: Text(
                        "${snapshot.data?.translatedText}",
                      ),
                    ),
                  ),
                  const SizedBox(width: 30),
                  IconButton(
                    onPressed: () {
                      moreThanTwoWordsList.clear();
                      TextModel textModel = TextModel();
                      homeDomain.textStreamController.sink.add(textModel);
                    },
                    iconSize: 50,
                    icon: const Icon(Icons.highlight_remove_sharp),
                  )
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
