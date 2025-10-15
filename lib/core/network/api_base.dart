import 'package:dio/dio.dart';
import 'package:emovie/core/constants/app_config.dart';

class ApiBase {
  static final Dio _dio = Dio();

  /// Cambiar esto cuando publiques
  static const bool isProduction = false;

  /// Inicializa configuración (baseUrl + headers)
  static Future<void> configureDio() async {
    _dio.options.baseUrl = AppConfig.tmdbBaseUrl;

    await _updateAuthorizationHeader();
  }

  /// Actualiza headers con autorización para TMDb
  static Future<void> _updateAuthorizationHeader() async {
    // Si necesitas almacenar algún token local para TMDb (por ejemplo un session id), lo harías aquí
    // Por ahora, usamos solo el API read token como Bearer token
    final headers = <String, String>{
      'Content-Type': 'application/json;charset=utf-8',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${AppConfig.tmdbApiReadToken}',
    };
    _dio.options.headers = headers;
  }

  /// Realiza GET genérico a ruta de TMDb con query params opcionales
  static Future<dynamic> get(String endpoint,
      {Map<String, dynamic>? queryParameters}) async {
    await configureDio();
    try {
      final resp = await _dio.get(endpoint, queryParameters: queryParameters);
      return resp.data;
    } on DioException catch (e) {
      print('[API ERROR GET] ${e.message}');
      if (e.response != null) {
        print('Status: ${e.response?.statusCode}');
        print('Response: ${e.response?.data}');
      }
      rethrow; // evita el warning y mantiene el stack trace original
    }
  }

  /// Realiza POST genérico
  static Future<dynamic> post(String endpoint,
      {Map<String, dynamic>? data}) async {
    await configureDio();
    try {
      final resp = await _dio.post(endpoint, data: data);
      return resp.data;
    } on DioException catch (e) {
      print('[API ERROR POST] ${e.message}');
      if (e.response != null) {
        print('Status: ${e.response?.statusCode}');
        print('Response: ${e.response?.data}');
      }
      rethrow;
    }
  }
}
