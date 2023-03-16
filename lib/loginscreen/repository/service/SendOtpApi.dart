import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

import '../models/LoginModel.dart';
import '../models/VerifyModel.dart';

part 'SendOtpApi.g.dart';

@RestApi(baseUrl: 'https://saral-staging.ccdms.in')
abstract class AuthApi {
  factory AuthApi(Dio dio) = _AuthApi;

  @POST('/zila/api/login')
  @Headers({"content-Type": "application/json", "Accept": "application/json"})
  Future<List<LoginModel>> loginUser(@Body() Map<String, dynamic> data);

  @POST("/zila/api/submit_otp")
  @Headers({"content-Type": "application/json", "Accept": "application/json"})
  Future<List<VerifyModel>> verifyUser(@Body() Map<String, dynamic> data);

}
