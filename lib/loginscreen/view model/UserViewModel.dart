import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import '../repository/models/LoginModel.dart';
import '../repository/models/VerifyModel.dart';
import '../repository/service/SendOtpApi.dart';

class LoginViewModel with ChangeNotifier {
  AuthApi? _authApi;
  bool _isLoading = false;
  LoginModel? _loginModel;
  String? _errorMessage;
  VerifyModel? _verifyModel;
  String? _token;

  bool get isLoading => _isLoading;

  LoginModel? get loginModel => _loginModel;

  String? get errorMessage => _errorMessage;

  VerifyModel? get verifyModel => _verifyModel;
  Future<void> loginUser({required String mobileNum}) async {
    try {
      _isLoading = true;
      notifyListeners();
      _authApi = AuthApi(Dio());
      final response = await _authApi!.loginUser({'phone_number': mobileNum});
      if (response.isNotEmpty == true) {
        _isLoading = false;
        notifyListeners();
        _loginModel = response.first;
        _token = _loginModel?.identification_token;
      } else {
        _errorMessage = "Something went wrong, Please try again later!";
      }
    } on DioError catch (e) {
      if (e.response != null) {
        final error = jsonDecode(e.response!.toString());
        _errorMessage = error['message'] ?? "Something went wrong, Please try again later!";
      } else {
        _errorMessage = "Something went wrong, Please try again later!";
      }
    } catch (e) {
      _errorMessage = "Something went wrong, Please try again later!";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> verifyUser({required String otp}) async {
    try {
      _isLoading = true;
      notifyListeners();
      if (_token == null) {
        print('------------demo2222');
        throw Exception('Identification token is null');
      }
      final response = await _authApi!.verifyUser({'identification_token': _token!, 'otp': otp });
      if (response.isNotEmpty) {
        _verifyModel = response.first;
      } else {
        _errorMessage = "Something went wrong, Please try again later!";
      }
    } on DioError catch (e) {
      if (e.response != null) {
        final error = jsonDecode(e.response!.toString());
        _errorMessage = error['message'] ?? "Something went wrong, Please try again later!";
      } else {
        _errorMessage = "Something went wrong, Please try again later!";
      }
    } catch (e) {
      _errorMessage = "Something went wrong, Please try again later!";
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
