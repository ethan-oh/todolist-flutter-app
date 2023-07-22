import 'package:flutter/material.dart';

class MeMoPage extends StatefulWidget {
  const MeMoPage({super.key});

  @override
  State<MeMoPage> createState() => _MeMoPageState();
}

class _MeMoPageState extends State<MeMoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Memo'),
      ),
    );
  }
}