// import 'package:flutter/material.dart';

// // ignore: must_be_immutable
// class ThrottlingGestureDetector extends StatelessWidget {
//   final Widget child;
//   final VoidCallback onTap;
//   final Duration throttleTime;

//   ThrottlingGestureDetector({
//     super.key,
//     required this.child,
//     required this.onTap,
//     this.throttleTime = const Duration(milliseconds: 300),
//   });

//   DateTime? _lastTap;

//   void _handleTap() {
//     final now = DateTime.now();
//     if (_lastTap != null && now.difference(_lastTap!) < throttleTime) {
//       return;
//     }
//     _lastTap = now;
//     onTap();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: _handleTap,
//       child: child,
//     );
//   }
// }
