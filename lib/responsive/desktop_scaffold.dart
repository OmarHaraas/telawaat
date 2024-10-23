import 'package:flutter/material.dart';
import '/constants.dart';
import '/content_page.dart';

class DesktopScaffold extends StatefulWidget {
  const DesktopScaffold({super.key});

  @override
  State<DesktopScaffold> createState() => _DesktopScaffoldState();
}

class _DesktopScaffoldState extends State<DesktopScaffold> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: myDefaultBackgroundColor,
      //
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBarWindowButtons(),
      ),
      //
      body: Row(children: [
        // Open Drawer
        myDrawer,

        // The rest of body
        Expanded(
          flex: 2,
          child: Container(
            color: Colors.grey[900],
            child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(8)),
                  color: Colors.white,
                ),
                child: Container(
                  margin: const EdgeInsets.only(top: 8),
                  child: const ContentPage(),
                )),
          ),
        ),
        ///////////-----------------------------------------
        const Expanded(child: SizedBox()) // nothing here
      ]),
    );
  }
}

class AppBarWindowButtons extends StatelessWidget {
  const AppBarWindowButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        // MinimizeWindowButton(colors: WindowButtonColors()),
        // MaximizeWindowButton(colors: WindowButtonColors()),
        // CloseWindowButton(colors:  WindowButtonColors()),
      ],
    );
  }
}
