import 'package:counter_app/features/counter/provider/counter_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class CounterScreen extends StatelessWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final counterProvider = context.read<CounterProvider>();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.keyboard_arrow_left),
        ),
        title: Center(child: Text('Counter')),
      ),
      body: ListView.builder(
        itemCount: counterProvider.counters.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(counterProvider.counters[index].title),
            trailing: Text(counterProvider.counters[index].value.toString()),
            onTap: () {
              context.pushNamed(
                'counterdetail',
                extra: counterProvider.counters[index],
              );
            },
          );
        },
      ),
    );
  }
}
