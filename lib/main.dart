import 'package:flutter/material.dart';

import 'responsive/desktop_scaffold.dart';
import 'responsive/mobile_scaffold.dart';
import 'responsive/responsive_layout.dart';

void main() {
  runApp(const MyApp(),); //new telawaat app in flutter! by: omar roshdy
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ResponsiveLayout(
        mobileScaffold: MobileScaffold(),
        desktopScaffold: DesktopScaffold(),
      ),
    );
  }
}
