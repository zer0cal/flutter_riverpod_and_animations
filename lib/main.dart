import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_and_animations/models/todo_model.dart';
import 'package:flutter_riverpod_and_animations/providers/static_providers.dart';
import 'package:flutter_riverpod_and_animations/widgets/my_animated_box_widget.dart';
import 'package:flutter_riverpod_and_animations/widgets/my_button_widget.dart';
import 'package:flutter_riverpod_and_animations/widgets/my_card_widget.dart';
import 'package:flutter_riverpod_and_animations/widgets/my_horizontal_list_widget.dart';
import 'package:flutter_riverpod_and_animations/widgets/my_switch_widget.dart';

int id = 1;

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    dev.log('MyApp.build(context: $context, ref: $ref)',
        name: 'main.dart', time: DateTime.now());
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(title: Text(ref.watch(titleProvider))),
      body: ListView(children: <Widget>[
        Center(
          child: Text('futureProvider: ${ref.watch(weatherProvider).value}'),
        ),
        Center(child: Text(ref.watch(counterProvider).toString())),
        TextButton(
            onPressed: () {
              ref.read(counterProvider.notifier).increment();
              ref
                  .read(todoListProvider.notifier)
                  .add(Todo(id: id++, label: 'cos tam $id', completed: false));
            },
            child: const Text('increment')),
        const MyAnimatedBoxWidget(),
        TextButton(
          onPressed: () {
            ref
                .read(colorOfAnimatedBoxProvider.notifier)
                .changeColor(Colors.red);
          },
          child: const Text('change color to red'),
        ),
        TextButton(
          onPressed: () {
            ref
                .read(colorOfAnimatedBoxProvider.notifier)
                .changeColor(Colors.blue);
          },
          child: const Text('change color to blue'),
        ),
        const MyCardWidget(
          title: 'first card',
          body: 'body: lorem ipsum',
        ),
        const MyCardWidget(
            title: 'second card', body: 'lorem ipsum, lorem ipsum'),
        MyButtonWidget(
          title: 'BUTTON',
          onPress: () {
            dev.log('button pressed');
          },
        ),
        Center(
          child: Text(ref
              .watch(enabledButtonCountProvider.select((value) => value))
              .toString()),
        ),
        const SizedBox(height: 30, width: 300, child: MyHorizontalListWidget()),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MySwitchWidget(
                onEnable: () {
                  ref.watch(enabledButtonCountProvider.notifier).increase();
                },
                onDisable: () {
                  ref.watch(enabledButtonCountProvider.notifier).decrease();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MySwitchWidget(
                onEnable: () {
                  ref.watch(enabledButtonCountProvider.notifier).increase();
                },
                onDisable: () {
                  ref.watch(enabledButtonCountProvider.notifier).decrease();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MySwitchWidget(
                onEnable: () {
                  dev.log('message', name: 'test', error: 'c');
                  ref.watch(enabledButtonCountProvider.notifier).increase();
                },
                onDisable: () {
                  ref.watch(enabledButtonCountProvider.notifier).decrease();
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MySwitchWidget(
                onEnable: () {
                  ref.watch(enabledButtonCountProvider.notifier).increase();
                },
                onDisable: () {
                  ref.watch(enabledButtonCountProvider.notifier).decrease();
                },
              ),
            ),
          ],
        ),
      ]),
    ));
  }
}
