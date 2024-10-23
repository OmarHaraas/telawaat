import 'package:flutter/material.dart';
import '/constants.dart';
import '/content_page.dart';

class MobileScaffold extends StatefulWidget {
  const MobileScaffold({super.key});

  @override
  State<MobileScaffold> createState() => _MobileScaffoldState();
}

class _MobileScaffoldState extends State<MobileScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myDefaultBackgroundColor,
      appBar: myAppBar,
      drawer: myDrawer,
      body: const ContentPage(),
    );
  }
}
