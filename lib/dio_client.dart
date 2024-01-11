import 'package:dio/dio.dart';

final dioClient = Dio(
  BaseOptions(
    baseUrl: 'http://localhost:8080',
  ),
);
