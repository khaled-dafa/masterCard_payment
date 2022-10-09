import 'package:dio/dio.dart';

class ApiHelper {
  late Dio dio;
  ApiHelper() {
    final optionDio = BaseOptions(
      baseUrl: 'http://api.tuxedo.dev.dafa.sa:3000/',
      headers: {
        'Authorization':
            'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJwaG9uZV9udW1iZXIiOiI5NjY1NzA0MjIxMjQiLCJpZCI6IjEiLCJpYXQiOjE2NDA2OTU2MzF9.-A6qoI05wN5KQUPYNBqqxecGLSior3xUEwMAQ-EgrmI',
      },
    );
    dio = Dio(optionDio);
  }
}
