import 'package:counter_app/features/counter/models/counter_model.dart';
import 'package:counter_app/features/counter/provider/counter_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CounterDetail extends StatefulWidget {
  final Counter counter;
  const CounterDetail({super.key, required this.counter});

  @override
  State<CounterDetail> createState() => _CounterDetailState();
}

class _CounterDetailState extends State<CounterDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.keyboard_arrow_left),
        ),
        title: Center(child: Text(widget.counter.title)),
      ),
      body: Center(
        child: Consumer<CounterProvider>(
          builder: (context, counterProvider, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Counter Value: ${widget.counter.value}',
                  style: TextStyle(fontSize: 24),
                ),
                ElevatedButton(
                  onPressed: () {
                    counterProvider.incrementCounter(widget.counter.id);
                  },
                  child: Text('Increment'),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
