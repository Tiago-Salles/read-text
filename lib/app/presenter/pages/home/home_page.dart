import 'package:flutter/material.dart';
import 'package:read_text/app/core/app_module/app_modules.dart';
import 'package:read_text/app/core/model/text_model.dart';
import 'package:read_text/app/core/utils/languages_utils.dart';
import 'package:read_text/app/domain/domains/home_domain.dart';
import 'package:read_text/app/presenter/pages/home/widgets/word_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeDomain homeDomain;
  late TextEditingController textController;

  @override
  void initState() {
    homeDomain = AppModules.homeDomain;
    textController = TextEditingController();

    super.initState();
  }

  List<String> moreThanOneWordList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BodyHomePage(
        homeDomain: homeDomain,
        moreThanOneWordList: moreThanOneWordList,
      ),
      bottomSheet: HomeBottomSheet(
        homeDomain: homeDomain,
        moreThanOneWordList: moreThanOneWordList,
      ),
    );
  }
}

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

class BodyHomePage extends StatefulWidget {
  const BodyHomePage({
    Key? key,
    required this.homeDomain,
    required this.moreThanOneWordList,
  }) : super(key: key);
  final HomeDomain homeDomain;
  final List<String> moreThanOneWordList;

  @override
  State<BodyHomePage> createState() => _BodyHomePageState();
}

class _BodyHomePageState extends State<BodyHomePage> {
  late TextEditingController fullTextController;

  @override
  void initState() {
    fullTextController = TextEditingController();
    super.initState();
  }

  bool selectedWord = false;
  String item = LanguageUtils.languages["en"]!;
  String language = "en";
  List<DropdownMenuItem<String>> dropDownItems = [];

  @override
  Widget build(BuildContext context) {
    for (String language in LanguageUtils.languages.values) {
      dropDownItems.add(
        DropdownMenuItem(
          value: language,
          onTap: () {},
          enabled: true,
          child: SizedBox(
            child: Text(language),
          ),
        ),
      );
    }

    return SingleChildScrollView(
      child: ValueListenableBuilder<bool>(
          valueListenable: widget.homeDomain.readOnlyListenable,
          builder: (context, readOnly, _) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    DropdownButton<String>(
                      value: item,
                      items: dropDownItems,
                      onChanged: (itemValue) {
                        setState(() {
                          item = itemValue!;
                          LanguageUtils.languages.forEach((key, value) {
                            if (value == itemValue) {
                              language = key;
                            }
                          });
                        });
                      },
                    ),
                    const SizedBox(width: 50),
                    Container(
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.blue[200],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextButton(
                        onPressed: () {
                          bool readOnly =
                              !widget.homeDomain.readOnlyListenable.value;
                          widget.homeDomain.readOnlyListenable.value = readOnly;
                        },
                        child: Text(
                          readOnly == false
                              ? "Modo leitura"
                              : "Adicionar texto",
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.all(10),
                  height: 600,
                  width: MediaQuery.of(context).size.width,
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
                    child: readOnly
                        ? ReadModeComponent(
                            wordsToSeparete: fullTextController.text,
                            homeDomain: widget.homeDomain,
                            language: language,
                            moreThanOneWordList: widget.moreThanOneWordList,
                          )
                        : TextFormField(
                            maxLines: null,
                            controller: fullTextController,
                            decoration: const InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ),
                  ),
                ),
              ],
            );
          }),
    );
  }
}

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
