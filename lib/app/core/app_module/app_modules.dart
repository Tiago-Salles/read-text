import 'package:read_text/app/core/services/translator_service.dart';
import 'package:read_text/app/domain/domains/home_domain.dart';

class AppModules {
  static final TranslatorService translatorService = TranslatorService();
  static final HomeDomain homeDomain =
      HomeDomain(translatorService: translatorService);
}
