import 'dart:async';
import 'package:read_text/app/core/model/text_model.dart';
import 'package:read_text/app/core/services/translator_service.dart';

class HomeDomain {
  TranslatorService translatorService;
  HomeDomain({required this.translatorService});

  StreamController<TextModel> textStreamController =
      StreamController<TextModel>.broadcast();

  void translate(String sourceText) async {
    try {
      translatorService.translateText(sourceText).then((textModel) {
        textStreamController.sink.add(textModel);
      });
    } catch (e) {
      rethrow;
    }
  }
}
