import 'package:flutter/material.dart';

import '../../utils/navigation.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: [
        const Text("Home Page"),
        MaterialButton(
            onPressed: () => Navigator.pushNamed(context, Navigation.gamepage),
            child: const Text("Start Game")),
      ],
    ));
  }
}
