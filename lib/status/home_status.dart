// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class HomeStatus extends StatefulWidget {
  HomeStatus({super.key, required this.sheikhName});
  String sheikhName;
  @override
  State<HomeStatus> createState() => _HomeStatusState();
}

class _HomeStatusState extends State<HomeStatus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.webhook_rounded,
            ),
          )
        ],
        centerTitle: true,
        title: Text(
          widget.sheikhName,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
      ),
      body: Container(margin: const EdgeInsets.all(20),
        child: Image.asset('assets/status/1.png',fit: BoxFit.cover,),
          // add designed image here..
          // we can add 2  textField: start and end. of the audio status.
          ),
    );
  }
}
