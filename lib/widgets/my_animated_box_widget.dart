library my_widgets;

import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_and_animations/providers/static_providers.dart';

class MyAnimatedBoxWidget extends ConsumerStatefulWidget {
  const MyAnimatedBoxWidget({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _MyAnimatedContainerWidgetState();
}

class _MyAnimatedContainerWidgetState extends ConsumerState<MyAnimatedBoxWidget>
    with TickerProviderStateMixin {
  late AnimationController _sizeAnimationController;
  late AnimationController _colorAnimationController;
  late Animation<double> _heightAnimation;
  late Animation<double> _widthAnimation;
  late Animation<Color?> _colorAnimation;
  @override
  void initState() {
    dev.log('_MyAnimatedContainerWidgetState.initState()',
        name: 'widgets.my_animated_box_widget.dart', time: DateTime.now());
    super.initState();
    // initialization of animation controllers
    _sizeAnimationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    _colorAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 3000));
    // initialization of animations
    _heightAnimation = Tween<double>(begin: 0, end: 200).animate(
        CurvedAnimation(
            parent: _sizeAnimationController, curve: Curves.easeInOutCubic));
    _widthAnimation = Tween<double>(begin: 100, end: 300).animate(
        CurvedAnimation(
            parent: _sizeAnimationController, curve: Curves.easeInOutCubic));
    _colorAnimation = ColorTween(
            begin: Colors.white, end: ref.read(colorOfAnimatedBoxProvider))
        .animate(_colorAnimationController);
    // size animation start
    _sizeAnimationController.forward();
    _colorAnimationController.forward();
  }

  void animateColor(Color oldColor, Color newColor) {
    dev.log(
        '_MyAnimatedContainerWidgetState.animateColor(old: $oldColor, new: $newColor)',
        name: 'widgets.my_animated_box_widget.dart',
        time: DateTime.now());
    _colorAnimation = ColorTween(begin: oldColor, end: newColor)
        .animate(_colorAnimationController);

    _colorAnimationController.reset();
    _colorAnimationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    dev.log('_MyAnimatedContainerWidgetState.builder($context)',
        name: 'widgets.my_animated_box_widget.dart', time: DateTime.now());
    ref.listen<Color>(colorOfAnimatedBoxProvider, (previous, next) {
      animateColor(previous!, next);
    });
    return AnimatedBuilder(
        animation: Listenable.merge(
            [_colorAnimationController, _sizeAnimationController]),
        builder: (context, child) {
          return Container(
            width: _widthAnimation.value,
            height: _heightAnimation.value,
            decoration: BoxDecoration(
                color: _colorAnimation.value,
                borderRadius: BorderRadius.circular(8.0)),
            // child: Text(_animation.value.toString()),
          );
        });
  }
}
