import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:dw_barbearia/src/core/restClient/interceptors/auth_interceptor.dart';

final class RestClient extends DioForNative {
  RestClient()
      : super(
          BaseOptions(
            baseUrl: 'http//10.0.0.114',
            connectTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 60),
          ),
        ) {
    interceptors.addAll([
      LogInterceptor(requestBody: true, responseBody: true),
      AuthInterceptor(),
    ]);
  }

  RestClient get auth {
    options.extra['DIO_AUTH_KEY'] = true;
    return this;
  }

  RestClient get unAuth {
    options.extra['DIO_AUTH_KEY'] = false;
    return this;
  }
}
