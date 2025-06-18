import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  final String userId;
  final String name;

  const HomeScreen({super.key, required this.userId, required this.name});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text("User Logged In successfully"),
            const SizedBox(height: 20),
            Text("User ID: ${widget.userId}"),
            const SizedBox(height: 20),
            Text("Welcome ${widget.name}"),
          ],
        ),
      ),
    );
  }
}
