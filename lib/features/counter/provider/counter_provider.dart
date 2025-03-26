import 'dart:developer';

import 'package:counter_app/features/counter/models/counter_model.dart';
import 'package:counter_app/features/counter/services/counter_services.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class CounterProvider with ChangeNotifier {
  List<Counter> _counters = [];
  List<Counter> get counters => _counters;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // Fetch counters from API
  Future<void> fetchCounters() async {
    _isLoading = true;
    notifyListeners();

    try {
      Response response = await CounterServices().getCounters();
      if (response.statusCode == 200) {
        log('Api response: ${response.data.toString()}');
        final List<dynamic> data = response.data as List<dynamic>;
        _counters = data.map((counter) => Counter.fromJson(counter)).toList();
      }
    } catch (e) {
      log(e.toString());
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Add a new counter
  Future<void> addCounter(String title, int count) async {
    try {
      Response response = await CounterServices().createCounter(
        title: title,
        count: count,
      );

      if (response.statusCode == 201) {
        log("Counter created successfully: ${response.data}");
        Counter newCounter = Counter.fromJson(response.data);

        // Add new counter to the list
        _counters.add(newCounter);
        notifyListeners();
      }
    } catch (e) {
      log("Error creating counter: $e");
    }
  }

  Future<void> incrementCounter({required String counterId}) async {
    try {
      final response = await CounterServices().incrementCounter(
        counterId: counterId,
      );
      if (response.statusCode == 200) {
        log("Api Response: ${response.data.toString()}");
        await fetchCounters();
      }
    } catch (e) {
      log(e.toString());
    } finally {
      notifyListeners();
    }
  }
}
