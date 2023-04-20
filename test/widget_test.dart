// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets.dart in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_and_animations/providers/static_providers.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod/riverpod.dart';

void main() {
  testWidgets('update the UI when incrementing the state', (tester) async {
    await tester.pumpWidget(const ProviderScope(
      child: CounterTestApp(),
    ));

    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    await tester.tap(find.byType(TextButton));
    await tester.pump();

    expect(find.text('1'), findsOneWidget);
    expect(find.text('0'), findsNothing);
  });

  testWidgets('the counter state is not shared between tests',
      (widgetTester) async {
    await widgetTester.pumpWidget(const ProviderScope(child: CounterTestApp()));

    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);
  });

  test('defaults to 0 and notify listeners when value changes', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    container.listen(counterProvider, (previous, next) {},
        fireImmediately: true);
  });
}

class CounterTestApp extends ConsumerWidget {
  const CounterTestApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      home: ListView(
        children: [
          Center(child: Text(ref.watch(counterProvider).toString())),
          TextButton(
              onPressed: () {
                ref.read(counterProvider.notifier).increment();
              },
              child: const Text('increment')),
        ],
      ),
    );
  }
}
