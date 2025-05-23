import 'package:appone/todo_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference _todoCollection = FirebaseFirestore.instance
      .collection('todos');

  Stream<List<Todo>> getTodos() {
    return _todoCollection
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs
                  .map(
                    (doc) => Todo.fromMap(
                      doc.data() as Map<String, dynamic>,
                      doc.id,
                    ),
                  )
                  .toList(),
        );
  }

  Future<void> addTodo(Todo todo) async {
    await _todoCollection.add(todo.toMap());
  }

  Future<void> updateTodo(Todo todo) async {
    await _todoCollection.doc(todo.id).update(todo.toMap());
  }

  Future<void> deleteTodo(String id) async {
    await _todoCollection.doc(id).delete();
  }

  Future<void> toggleDone(Todo todo) async {
    await _todoCollection.doc(todo.id).update({'isDone': !todo.isDone});
  }
}
