import 'package:read_text/app/core/model/text_model.dart';
import 'package:translator/translator.dart';

class TranslatorService {
  Future<TextModel> translateText(String sourceText) async {
    GoogleTranslator translator = GoogleTranslator();
    try {
      Translation translatedText =
          await translator.translate(sourceText, from: 'en', to: 'pt');
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
