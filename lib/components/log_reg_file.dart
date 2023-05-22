

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class log_reg_screen extends StatelessWidget {
  const log_reg_screen(
      {required this.color, required this.pagename, required this.text});
  final String text;
  final Color color;
  final String pagename;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: color,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: () {
            Navigator.pushNamed(context, pagename);
          },
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            text,
          ),
        ),
      ),
    );
  }
}
