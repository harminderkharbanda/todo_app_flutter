import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app_flutter/pages/add.dart';

import '../models/todo.dart';
import '../providers/todo_provider.dart';
import 'completed.dart';

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Todo> todos = ref.watch(todoProvider);
    List<Todo> activeTodos = todos.where((todo) => todo.completed == false).toList();
    List<Todo> completedTodos = todos.where((todo) => todo.completed == true).toList();
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo App"),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: activeTodos.length + 1,
          itemBuilder: (context, index) {
            if (activeTodos.isEmpty) {
              return Padding(
                padding: const EdgeInsets.only(top: 300.0),
                child: const Center(
                  child: Text("Add a Todo using below button"),
                ),
              );
            }
             if (index == activeTodos.length) {
              if (completedTodos.isEmpty) {
                return Container();
              } else {
                return Center(
                  child: TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => CompletedTodos()));
                      },
                      child: Text("Completed Todos")),
                );
              }
            }
            return Slidable(
              startActionPane: ActionPane(
                motion: const ScrollMotion(),
                children: [
                  SlidableAction(
                    onPressed: (context) => ref.read(todoProvider.notifier).deleteTodo(activeTodos[index].todoId),
                    icon: Icons.delete,
                    backgroundColor: Colors.red,
                      borderRadius: BorderRadius.circular(10)
                  )
                ]
              ),
              endActionPane: ActionPane(
                  motion: ScrollMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (context) => ref.read(todoProvider.notifier).completeTodo(activeTodos[index].todoId),
                      icon: Icons.check,
                      backgroundColor: Colors.green,
                      borderRadius: BorderRadius.circular(10),
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
                  child: ListTile(title: Text(activeTodos[index].content))
              )
            );
          }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddTodo()));
        },
        tooltip: 'Increment',
        backgroundColor: Colors.black,
        child: const Icon(Icons.add, color: Colors.white,),
      ),
    );
  }
}