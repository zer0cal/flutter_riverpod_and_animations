library my_widgets;

import 'dart:developer' as dev;

import 'package:flutter/material.dart';

class MyButtonWidget extends StatelessWidget {
  const MyButtonWidget({Key? key, required this.title, required this.onPress})
      : super(key: key);

  final String title;
  final Function onPress;

  @override
  Widget build(BuildContext context) {
    dev.log('MyButtonWidget.build($context)',
        name: 'widgets.my_button_widget.dart', time: DateTime.now());
    final borderRadius = BorderRadius.circular(8.0);
    return Center(
      child: Material(
        elevation: 0,
        color: Colors.redAccent,
        borderRadius: borderRadius,
        child: InkWell(
          focusColor:
              Colors.purpleAccent, // po przejściu do przycisku za pomocą tab
          hoverColor: Colors.greenAccent, // po najechaniu myszką
          highlightColor: Colors.amberAccent, // po przyciśnięciu
          splashColor: Colors.blueAccent, // efekt po przyciśnięciu
          borderRadius: borderRadius,
          onTap: () {
            onPress();
          },
          child: Container(
              padding: const EdgeInsets.all(4.0),
              height: 40,
              width: 220,
              decoration: BoxDecoration(
                borderRadius: borderRadius,
              ),
              child: Center(
                child: Text(
                  title,
                  style: const TextStyle(color: Colors.white),
                ),
              )),
        ),
      ),
    );
  }
}
