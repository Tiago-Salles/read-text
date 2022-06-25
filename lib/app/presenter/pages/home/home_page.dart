import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:read_text/app/core/app_module/app_modules.dart';
import 'package:read_text/app/core/model/text_model.dart';
import 'package:read_text/app/domain/domains/home_domain.dart';
import 'package:read_text/app/presenter/pages/favorite/favorite_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              const SizedBox(height: 40),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
                child: Row(
                  children: [
                    InkWell(
                        onTap: () {},
                        child: Icon(
                          Iconsax.bookmark,
                          color: Colors.blue,
                        )),
                    Spacer(),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.blue[200],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            readOnly = !readOnly;
                          });
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
              ),
              Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(10),
                height: 500,
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
                child: TextFormField(
                  onTap: () {
                    homeDomain.translate(textController.text);
                  },
                  style: TextStyle(fontSize: 20),
                  readOnly: readOnly,
                  maxLines: null,
                  controller: fullTextController,
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color:
                            readOnly == true ? Colors.transparent : Colors.grey,
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color:
                            readOnly == true ? Colors.transparent : Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.blue[200],
                  borderRadius: BorderRadius.circular(30),
                ),
                child: TextFormField(
                  controller: textController,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.all(10),
                    child: StreamBuilder<TextModel>(
                      stream: homeDomain.textStreamController.stream,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          TextModel textModel = snapshot.data!;
                          return Text(textModel.translatedText);
                        } else {
                          return const Text("Pesquise uma palavra");
                        }
                      },
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      homeDomain.translate(textController.text);
                    },
                    child: const Text("Traduzir"),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text("Nova Palavra"),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
