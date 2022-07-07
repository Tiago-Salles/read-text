import 'package:dio/dio.dart';
import 'package:read_text/app/core/data/infra/client_http.dart';

class DioClient implements IClientHttp {
  Dio dio = Dio();

  @override
  Future get() async {
    try {
      await dio.get("translate.googleapis.com", queryParameters: {
        'sl': "pt",
        'tl': "en",
        'hl': "en",
        'ie': 'UTF-8',
        'oe': 'UTF-8',
        'q': "love",
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future post() {
    // TODO: implement post
    throw UnimplementedError();
  }
}
