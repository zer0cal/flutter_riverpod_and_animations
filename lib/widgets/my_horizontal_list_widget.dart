library my_widgets;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_and_animations/providers/static_providers.dart';

class MyHorizontalListWidget extends ConsumerStatefulWidget {
  const MyHorizontalListWidget({
    Key? key,
  }) : super(key: key);

  @override
  ConsumerState createState() => _MyHorizontalListWidgetState();
}

class _MyHorizontalListWidgetState
    extends ConsumerState<MyHorizontalListWidget> {
  @override
  Widget build(BuildContext context) {
    final list = ref.watch(filteredTodoListProvider);
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: list.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.all(2.0),
            color: Colors.greenAccent,
            child: Text(list[index].toString()),
          );
        });
  }
}
