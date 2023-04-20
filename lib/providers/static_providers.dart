library my_providers;

import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_and_animations/models/todo_model.dart';

// colors
final colorOfAnimatedBoxProvider =
    StateNotifierProvider<AnimatedBoxNotifier, Color>(
        (ref) => AnimatedBoxNotifier(ref));

class AnimatedBoxNotifier extends StateNotifier<Color> {
  AnimatedBoxNotifier(this.ref) : super(Colors.blue);

  final Ref ref;

  void changeColor(Color color) {
    dev.log('changeColor($color)',
        name: 'providers.static_providers.dart', time: DateTime.now());
    state = color;
  }
}

final cityProvider = Provider<String>((ref) => 'Olsztyn');

final weatherProvider = FutureProvider<int>((ref) async {
  final city = ref.watch(cityProvider);

  return fetchWeather(city: city);
});

Future<int> fetchWeather({required String city}) async {
  dev.log('fetchWeather($city)',
      name: 'providers.static_providers.dart', time: DateTime.now());
  await Future.delayed(const Duration(seconds: 2));
  return 20;
}

class TodoListNotifier extends StateNotifier<List<Todo>> {
  TodoListNotifier() : super([Todo(id: 0, label: 'cos tam', completed: false)]);

  void add(Todo todo) => state.add(todo);
}

final todoListProvider = StateNotifierProvider<TodoListNotifier, List<Todo>>(
    (ref) => TodoListNotifier());

enum Filter {
  none,
  completed,
  uncompleted,
}

final filerProvider = StateProvider<Filter>((ref) => Filter.none);

final filteredTodoListProvider = Provider<List<Todo>>((ref) {
  final filter = ref.watch(filerProvider);
  final todos = ref.watch(todoListProvider);

  switch (filter) {
    case Filter.none:
      return todos;
    case Filter.completed:
      return todos.where((todo) => todo.completed).toList();
    case Filter.uncompleted:
      return todos.where((todo) => !todo.completed).toList();
  }
});

final helloWorldProvider = Provider<String>((ref) => 'Hello world');

final titleProvider = Provider<String>((ref) => 'Riverpod and animations');

final counterProvider =
    StateNotifierProvider<CounterNotifier, int>((ref) => CounterNotifier(ref));

final enabledButtonCountProvider =
    StateNotifierProvider<EnabledButtonNotifier, int>(
        (ref) => EnabledButtonNotifier());

class EnabledButtonNotifier extends StateNotifier<int> {
  EnabledButtonNotifier() : super(0);

  void increase() => state++;

  void decrease() => state--;
}

class CounterNotifier extends StateNotifier<int> {
  CounterNotifier(this.ref) : super(0);

  final Ref ref;

  void increment() => state++;
}

final streamProvider = StreamProvider<double>((ref) async* {
  double n = 1;
  while (true) {
    Future.delayed(const Duration(seconds: 1));
    yield n++;
  }
});
