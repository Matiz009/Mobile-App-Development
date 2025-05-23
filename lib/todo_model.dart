class Todo {
  final String id;
  final String title;
  final String description;
  final bool isDone;

  Todo({
    required this.id,
    required this.title,
    required this.description,
    required this.isDone,
  });

  factory Todo.fromMap(Map<String, dynamic> data, String docId) {
    return Todo(
      id: docId,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      isDone: data['isDone'] ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'isDone': isDone,
      'timestamp': DateTime.now(),
    };
  }
}
