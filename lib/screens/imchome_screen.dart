import 'package:flutter/material.dart';
import 'package:flutter_basic/components/gender_selector.dart';

class ImcHomeScreen extends StatefulWidget {
  const ImcHomeScreen({super.key});

  @override
  State<ImcHomeScreen> createState() => ImcHomeScreenState();
}

class ImcHomeScreenState extends State<ImcHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [GenderSelector()]);
  }
}
