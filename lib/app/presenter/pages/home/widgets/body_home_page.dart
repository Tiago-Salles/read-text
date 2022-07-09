import 'package:flutter/material.dart';
import 'package:read_text/app/core/utils/languages_utils.dart';
import 'package:read_text/app/domain/domains/home_domain.dart';
import 'package:read_text/app/presenter/pages/home/widgets/read_mode_component.dart';

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
  List<DropdownMenuItem<String>> dropdownItems = [];

  @override
  Widget build(BuildContext context) {
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
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color.fromARGB(255, 194, 207, 222),
                    ),
                    child: DropdownButton<String>(
                      borderRadius: BorderRadius.circular(20),
                      value: item,
                      items: LanguageUtils.languages.values
                          .map(
                            (value) => DropdownMenuItem(
                              value: value,
                              onTap: () {},
                              enabled: true,
                              child: SizedBox(
                                child: Text(
                                  value,
                                  style: TextStyle(
                                    color: Colors.black54,
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
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
                  ),
                  const SizedBox(width: 50),
                  Container(
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 61, 137, 200),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextButton(
                      onPressed: () {
                        bool readOnly =
                            !widget.homeDomain.readOnlyListenable.value;
                        widget.homeDomain.readOnlyListenable.value = readOnly;
                      },
                      child: Text(
                        readOnly == false ? "Modo leitura" : "Adicionar texto",
                        style: TextStyle(color: Colors.white),
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
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(20),
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
                          cursorColor: Colors.white,
                          style: TextStyle(
                            color: Colors.white,
                          ),
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
        },
      ),
    );
  }
}
