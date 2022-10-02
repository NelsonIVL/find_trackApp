import 'package:flutter/material.dart';

class CircularButton extends StatelessWidget {
  final Color bgColor;
  final String? asset;
  final Function? function;

  CircularButton({super.key, required this.bgColor, this.asset, this.function});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            function;
          },
          child: CircleAvatar(
            radius: 25,
            backgroundColor: Theme.of(context).canvasColor,
            child: Image.asset("${asset}"),
          ),
        ),
        SizedBox(
          height: 12,
        ),
      ],
    );
  }
}
