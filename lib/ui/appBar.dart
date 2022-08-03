import 'package:flutter/material.dart';

appBar() {
  return AppBar(
    centerTitle: true,
    title: const Text(
      'Gallery',
      style: TextStyle(
          color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
    ),
    flexibleSpace: Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            Color(0xFF1A3C59),
            Color(0xFF40BCA1),
          ],
        ),
      ),
    ),
  );
}
