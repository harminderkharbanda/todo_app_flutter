import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app_flutter/providers/todo_provider.dart';

void main() {
  late ProviderContainer container;
  late TodoListNotifier notifier;
  setUp(() {
    container = ProviderContainer();
    notifier = container.read(todoProvider.notifier);
  });
  
  test('initial list is empty', () {
    expect(notifier.state, []);
  });

  test('add todo', () {
    notifier.addTodo('test todo');
    expect(notifier.state[0].content, 'test todo');
  });
  
  test('delete todo', () {
    notifier.addTodo('test todo');
    expect(notifier.state[0].content, 'test todo');

    notifier.deleteTodo(0);
    expect(notifier.state, []);
  });

  test('complete todo', () {
    notifier.addTodo('test todo');
    expect(notifier.state[0].content, 'test todo');

    notifier.completeTodo(0);
    expect(notifier.state[0].completed, true);
  });

}