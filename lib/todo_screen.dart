import 'package:appone/firestore_service.dart';
import 'package:appone/todo_model.dart';
import 'package:flutter/material.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final FirestoreService _service = FirestoreService();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  void _showTodoDialog({Todo? todo}) {
    if (todo != null) {
      _titleController.text = todo.title;
      _descController.text = todo.description;
    } else {
      _titleController.clear();
      _descController.clear();
    }

    showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: Text(todo == null ? 'Add Task' : 'Edit Task'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(labelText: 'Title'),
                ),
                TextField(
                  controller: _descController,
                  decoration: const InputDecoration(labelText: 'Description'),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                  _titleController.clear();
                  _descController.clear();
                },
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  final title = _titleController.text.trim();
                  final desc = _descController.text.trim();
                  if (title.isEmpty || desc.isEmpty) return;

                  if (todo == null) {
                    _service.addTodo(
                      Todo(
                        id: '',
                        title: title,
                        description: desc,
                        isDone: false,
                      ),
                    );
                  } else {
                    _service.updateTodo(
                      Todo(
                        id: todo.id,
                        title: title,
                        description: desc,
                        isDone: todo.isDone,
                      ),
                    );
                  }

                  Navigator.of(ctx).pop();
                },
                child: const Text('Save'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo App"),
        backgroundColor: Theme.of(context).primaryColor,
        centerTitle: true,
      ),
      body: StreamBuilder<List<Todo>>(
        stream: _service.getTodos(),
        builder: (context, snapshot) {
          if (snapshot.hasError)
            return const Center(child: Text('Something went wrong.'));
          if (!snapshot.hasData)
            return const Center(child: CircularProgressIndicator());

          final todos = snapshot.data!;
          return ListView.builder(
            itemCount: todos.length,
            itemBuilder: (ctx, index) {
              final todo = todos[index];
              return ListTile(
                title: Text(
                  todo.title,
                  style: TextStyle(
                    decoration: todo.isDone ? TextDecoration.lineThrough : null,
                  ),
                ),
                subtitle: Text(todo.description),
                leading: Checkbox(
                  value: todo.isDone,
                  onChanged: (_) => _service.toggleDone(todo),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () => _showTodoDialog(todo: todo),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => _service.deleteTodo(todo.id),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showTodoDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
