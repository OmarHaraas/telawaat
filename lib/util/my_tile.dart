// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class MyTile extends StatelessWidget {
  MyTile({
    super.key,
    required this.onTap,
    required this.onTapStatus,
    required this.title,
    this.subTitle = "محمد أيوب",
    this.primaryColor = Colors.white,
  });
  Function()? onTap;
  Function()? onTapStatus;
  final String title;
  final String subTitle;
  final Color primaryColor;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(9),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.grey[800],
        ),
        height: 80,
        child: ListTile(
          title: Text(
            title,
            style: TextStyle(
              color: primaryColor,
              fontSize: 20,
            ),
            textAlign: TextAlign.right,
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(
                Icons.favorite_border_rounded,
                color: primaryColor,
              ),
              Text(
                subTitle,
                style: TextStyle(
                  color: primaryColor,
                ),
                textAlign: TextAlign.right,
              ),
            ],
          ),
          leading: IconButton(
              onPressed: () {
                // navigate to status screen
              },
              icon: Icon(
                Icons.deblur_outlined,
                color: primaryColor,
              )),
          onTap: onTap,
        ),
      ),
    );
  }
}
