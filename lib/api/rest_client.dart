import 'package:awesome_dio_interceptor/awesome_dio_interceptor.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:retrofit/retrofit.dart';

import 'models.dart';

part 'rest_client.g.dart';

final _dio = Dio();

final restClient = RestClient(_dio);

@RestApi(baseUrl: 'https://mcsa.dnarentalstudio.com/')
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  static Future<void> init() async {
    const timeOut = Duration(seconds: 30);
    _dio.options.headers['Content-Type'] = 'application/json';
    _dio.options.headers["Accept"] = "application/json";
    _dio.options.connectTimeout = timeOut;
    _dio.options.receiveTimeout = timeOut;
    _dio.options.validateStatus = (status) {
      return true;
    };
    _dio.interceptors.add(
      AwesomeDioInterceptor(
        logRequestTimeout: false,
        logRequestHeaders: true,
        logResponseHeaders: false,
        logger: debugPrint,
      ),
    );
  }

  @POST('public/api/gateone')
  @MultiPart()
  Future<HttpResponse<dynamic>> submitData(@Body() SubmitData deviceLog);
}
