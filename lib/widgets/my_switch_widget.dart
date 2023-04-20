library my_widgets;

import 'dart:developer' as dev;

import 'package:flutter/material.dart';

class MySwitchWidget extends StatefulWidget {
  const MySwitchWidget(
      {Key? key, required this.onEnable, required this.onDisable})
      : super(key: key);

  final Function onEnable;
  final Function onDisable;

  @override
  State<MySwitchWidget> createState() => _MySwitchWidgetState();
}

class _MySwitchWidgetState extends State<MySwitchWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<Color?> _colorAnimation;
  late Animation<double> _elevationAnimation;
  var isEnabled = false;

  @override
  void initState() {
    dev.log('_MySwitchWidgetState.initState()',
        name: 'widgets.my_switch_widget.dart');
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    _colorAnimation =
        ColorTween(begin: Colors.grey.shade200, end: Colors.indigo).animate(
            CurvedAnimation(parent: _animationController, curve: Curves.ease));
    _elevationAnimation = Tween<double>(begin: 0, end: 6).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeIn));
    if (isEnabled) {
      _animationController.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    dev.log('_MySwitchWidgetState.build($context)',
        name: 'widgets.my_switch_widget.dart');
    final borderRadius = BorderRadius.circular(12.0);
    return AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Material(
            elevation: _elevationAnimation.value,
            color: _colorAnimation.value,
            borderRadius: borderRadius,
            child: InkWell(
              onTap: () {
                if (isEnabled) {
                  widget.onDisable();
                  _animationController.reverse();
                  isEnabled = !isEnabled;
                } else {
                  widget.onEnable();
                  _animationController.forward();
                  isEnabled = !isEnabled;
                }
              },
              borderRadius: borderRadius,
              child: Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(borderRadius: borderRadius),
              ),
            ),
          );
        });
  }
}
