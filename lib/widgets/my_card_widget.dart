library my_widgets;

import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MyCardWidget extends ConsumerStatefulWidget {
  const MyCardWidget({Key? key, required this.title, required this.body})
      : super(key: key);
  final String title;
  final String body;

  @override
  ConsumerState<MyCardWidget> createState() => _MyCardWidgetState();
}

class _MyCardWidgetState extends ConsumerState<MyCardWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  late Widget _title;
  late Widget _body;

  bool _expanded = false;
  final _column = <Widget>[];

  @override
  void initState() {
    dev.log('_MyCardWidgetState.initState()',
        name: 'widgets.my_card_widget.dart', time: DateTime.now());
    _title = Row(
      children: [const Icon(Icons.flutter_dash), Text(widget.title)],
    );
    _body = Column(
      children: [Text(widget.body)],
    );
    _column.add(_title);
    super.initState();
    _animationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 700));
    _animation = Tween<double>(begin: 0, end: 120).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.ease));
  }

  @override
  Widget build(BuildContext context) {
    dev.log('_MyCardWidgetState.build($context)',
        name: 'widgets.my_card_widget.dart', time: DateTime.now());
    return AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Padding(
            padding: const EdgeInsets.all(2.0),
            child: RawMaterialButton(
              elevation: 0,
              fillColor: Colors.greenAccent.shade200,
              hoverColor: Colors.greenAccent.shade100,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
              onPressed: () {
                if (_expanded) {
                  _animationController.reverse();
                  _expanded = !_expanded;
                  _column.remove(_body);
                } else {
                  _animationController
                      .forward()
                      .then((value) => _column.add(_body));
                  _expanded = !_expanded;
                }
              },
              child: SizedBox(
                height: _animation.value + 50,
                width: 300,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: _column,
                  ),
                ),
              ),
            ),
          );
        });
  }
}
