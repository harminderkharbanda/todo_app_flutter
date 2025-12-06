import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app_flutter/providers/todo_provider.dart';

class AddTodo extends ConsumerWidget {
  const AddTodo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController controller = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Todo'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: controller,
                decoration: const InputDecoration(
                  hintText: 'Enter a todo',
                  border: OutlineInputBorder()
                ),
              ),
            ),
            TextButton(onPressed: () {
              ref.read(todoProvider.notifier).addTodo(controller.text);
              Navigator.of(context).pop();
            }, child: Text("Add Todo"))
          ],
        ),
      )
    );
  }
}
