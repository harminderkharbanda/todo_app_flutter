import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../models/todo.dart';
import '../providers/todo_provider.dart';

class CompletedTodos extends ConsumerWidget {
  const CompletedTodos({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Todo> todos = ref.watch(todoProvider);
    List<Todo> completedTodos = todos.where((todo) => todo.completed == true).toList();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Completed Todos"),
      ),
      body: Center(
        child: ListView.builder(
            itemCount: completedTodos.length,
            itemBuilder: (context, index) {
              return Slidable(

                  startActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      children: [
                        SlidableAction(

                            onPressed: (context) => ref.read(todoProvider.notifier).deleteTodo(completedTodos[index].todoId),
                            icon: Icons.delete,
                            backgroundColor: Colors.red,
                            borderRadius: BorderRadius.circular(10)
                        )
                      ]
                  ),
                  child: Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: ListTile(title: Text(completedTodos[index].content))));
            }),
      ),
    );
  }
}