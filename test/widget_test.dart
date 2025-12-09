// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:todo_app_flutter/main.dart';
import 'package:todo_app_flutter/models/todo.dart';
import 'package:todo_app_flutter/pages/completed.dart';
import 'package:todo_app_flutter/pages/home.dart';
import 'package:todo_app_flutter/providers/todo_provider.dart';

void main() {
  // testWidgets('Counter increments smoke test', (WidgetTester tester) async {
  //   // Build our app and trigger a frame.
  //   await tester.pumpWidget(const MyApp());
  //
  //   // Verify that our counter starts at 0.
  //   expect(find.text('0'), findsOneWidget);
  //   expect(find.text('1'), findsNothing);
  //
  //   // Tap the '+' icon and trigger a frame.
  //   await tester.tap(find.byIcon(Icons.add));
  //   await tester.pump();
  //
  //   // Verify that our counter has incremented.
  //   expect(find.text('0'), findsNothing);
  //   expect(find.text('1'), findsOneWidget);
  // });

  testWidgets('default state', (tester) async {
    await tester.pumpWidget(ProviderScope(child: const MyApp()));
    Finder defaultText = find.text("Add a Todo using below button");
    expect(defaultText, findsOneWidget);
  });

  testWidgets('completed todos show in completed screen', (tester) async {
    TodoListNotifier notifier = TodoListNotifier(<Todo>[Todo(todoId: 0, content: "record video", completed: true)]);
    await tester.pumpWidget(ProviderScope(
      overrides: [
        todoProvider.overrideWith((ref) => notifier)
      ],
        child: MaterialApp(home: const CompletedTodos())));

    Finder finder = find.text("record video");
    expect(finder, findsOneWidget);
  });
  
  testWidgets('slide and delete a todo', (tester) async {
    TodoListNotifier notifier = TodoListNotifier(<Todo>[Todo(todoId: 0, content: "record video", completed: false)]);
    await tester.pumpWidget(ProviderScope(
        overrides: [
          todoProvider.overrideWith((ref) => notifier)
        ],
        child: MaterialApp(home: const MyHomePage())));

    Finder finder = find.text("record video");
    expect(finder, findsOneWidget);

    Finder draggableWidget = find.byKey(ValueKey("0"));
    Finder deleteButton = find.byKey(ValueKey("0delete"));

    await tester.timedDrag(draggableWidget, const Offset(200,0), Duration(seconds: 2));
    await tester.pump();
    await tester.tap(deleteButton);
    await tester.pump();

    Finder defaultText = find.text("Add a Todo using below button");
    expect(defaultText, findsOneWidget);
    
  });
}
