import 'package:retrofit/dio.dart';

import 'models.dart';
import 'rest_client.dart';

class Api {
  static Future<HttpResponse<dynamic>> submitData(SubmitData submitData) async {
    return await restClient.submitData(submitData);
  }
}
