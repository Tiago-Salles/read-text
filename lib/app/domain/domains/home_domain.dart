import 'package:flutter/foundation.dart';
import 'package:read_text/app/core/model/text_model.dart';
import 'package:read_text/app/core/services/translator_service.dart';

class HomeDomain {
  TranslatorService translatorService;
  HomeDomain({required this.translatorService});

  ValueNotifier<TextModel> textListenable =
      ValueNotifier<TextModel>(TextModel());
  ValueNotifier<bool> readOnlyListenable = ValueNotifier<bool>(false);
  void translate(String sourceText, String? languageFrom) async {
    try {
      await translatorService
          .translateText(sourceText, languageFrom)
          .then((textModel) {
        textListenable.value = textModel;
      });
    } catch (e) {
      rethrow;
    }
  }
}
