import 'package:dio/dio.dart';

class CounterServices {
  final Dio _dio = Dio(); // Create a Dio instance

  // Base API URL
  final String baseUrl = "https://counter-app-backend.onrender.com/api";

  // Fetch counters
  Future<Response> getCounters() async {
    try {
      final Response response = await _dio.get('$baseUrl/counter');
      return response;
    } catch (e) {
      throw Exception('failed to fetch counters: $e');
    }
  }

  // create counter
  Future<Response> createCounter({
    required String title,
    required int count,
  }) async {
    try {
      final Response response = await _dio.post(
        '$baseUrl/counter',
        data: {'title': title, 'count': count},
      );
      return response;
    } catch (e) {
      throw Exception('failed to create counter: $e');
    }
  }

  // Update counter value
  Future<Response> incrementCounter({required String counterId}) async {
    try {
      final response = await _dio.put('$baseUrl/counter/$counterId/increment');
      return response;
    } catch (e) {
      throw Exception("Failed to create counter: $e");
    }
  }
}
