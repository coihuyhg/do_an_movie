import 'package:flutter/material.dart';

class Notifi extends StatefulWidget {
  const Notifi({Key? key}) : super(key: key);

  @override
  State<Notifi> createState() => _NotifiState();
}

class _NotifiState extends State<Notifi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notifications',
          style: (TextStyle(fontSize: 26, color: Color(0xFF0F1B2B))),
        ),
        backgroundColor: Color(0xFFFFFFFF),
      ),
      body: const Center(
        child: Text('Notification'),
      ),
    );
  }
}
