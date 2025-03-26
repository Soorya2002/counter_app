import 'package:counter_app/features/counter/provider/counter_provider.dart';
import 'package:counter_app/features/counter/presentation/widgets/show_bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context
          .read<CounterProvider>()
          .fetchCounters(); // Fetch counters initially
    });
  }

  void _refreshCounters() {
    context.read<CounterProvider>().fetchCounters(); // Refresh after adding
  }

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
        title: Center(child: Text('Counter')),
      ),
      body: Consumer<CounterProvider>(
        builder: (context, counterProvider, _) {
          return counterProvider.isLoading
              ? Center(child: CircularProgressIndicator())
              : counterProvider.counters.isEmpty
              ? Center(child: Text("No counters found"))
              : ListView.builder(
                itemCount: counterProvider.counters.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(counterProvider.counters[index].title ?? ""),
                    trailing: Text(
                      counterProvider.counters[index].count.toString(),
                    ),
                    onTap: () {
                      context.pushNamed(
                        'counterdetail',
                        extra: counterProvider.counters[index],
                      );
                    },
                  );
                },
              );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ShowBottomSheet.show(context, onCounterAdded: _refreshCounters);
        },
        backgroundColor: Colors.blue,
        child: Text('+', style: TextStyle(fontSize: 30, color: Colors.white)),
      ),
    );
  }
}
