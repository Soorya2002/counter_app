import 'package:counter_app/core/utils/storage_services.dart';
import 'package:counter_app/features/authentication/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    _checkUserToken();
    super.initState();
  }

  // check user token already exists
  Future<void> _checkUserToken() async {
    UserModel? user = await StorageServices().getUserData();
    if (user != null) {
      if (user.token != null) {
        if (mounted) {
          context.goNamed('counter');
        }
      }
    } else {
      if (mounted) {
        context.goNamed('login');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
