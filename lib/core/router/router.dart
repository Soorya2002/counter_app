import 'package:counter_app/features/counter/models/counter_model.dart';
import 'package:counter_app/features/counter/screens/counter_detail.dart';
import 'package:counter_app/features/counter/screens/counter_screen.dart';
import 'package:counter_app/features/home/home_screen.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: '/', name: 'home', builder: (context, state) => HomeScreen()),
    GoRoute(
      path: '/counter',
      name: 'counter',
      builder: (context, state) => CounterScreen(),
    ),
    GoRoute(
      path: '/counterdetail',
      name: 'counterdetail',

      builder: (context, state) {
        final counter = state.extra as Counter;
        return CounterDetail(counter: counter);
      },
    ),
  ],
);
