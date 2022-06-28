import 'package:read_text/app/core/model/text_model.dart';
import 'package:translator/translator.dart';

class TranslatorService {
  Future<TextModel> translateText(
      String sourceText, String? languageFrom) async {
    GoogleTranslator translator = GoogleTranslator();
    try {
      Translation translatedText =
          await translator.translate(sourceText, from: languageFrom!, to: 'pt');
      TextModel textModel = TextModel(
        translatedText: translatedText.text,
        source: translatedText.source,
        sourceLanguage: translatedText.source,
      );
      return textModel;
    } catch (e) {
      rethrow;
    }
  }
}
