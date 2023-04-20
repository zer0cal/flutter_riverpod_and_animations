class Todo {
  Todo({
    required this.id,
    required this.label,
    required this.completed,
  });
  final int id;
  final String label;
  bool completed = false;

  void setCompleted() => completed = true;

  @override
  String toString() =>
      'id: $id, label: $label, ${completed ? ', zakończone' : ', do zrobienia'}';
}
