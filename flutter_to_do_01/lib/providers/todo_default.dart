import 'package:flutter_to_do_01/models/todo.dart';

class TodoDefault {
  List<Todo> dummyTodos = [
    Todo(id: 1, title: '기타 수업 등록', description: '학원등록 후 지원금 받기'),
    Todo(id: 2, title: '당근 중고 팔기', description: '빨래대랑 쓰레기통 팔기'),
    Todo(id: 3, title: 'yes24 중고책 팔기', description: '만원 넘겨서 팔기'),
    Todo(id: 4, title: '풀오버 니트사기', description: '메종키츠네로 가을 겨울 준비')
  ];

  List<Todo> getTodos() {
    return dummyTodos;
  }

  Todo getTodo(int id) {
    return dummyTodos[id];
  }

  Todo addTodo(Todo todo) {
    Todo newTodo = Todo(
        id: dummyTodos.length + 1,
        title: todo.title,
        description: todo.description);
    dummyTodos.add(newTodo);
    return newTodo;
  }

  void deleteTodo(int id) {
    for (int i = 0; i < dummyTodos.length; i++) {
      if (dummyTodos[i].id == id) {
        dummyTodos.removeAt(i);
      }
    }
  }

  void updateTodo(Todo todo) {
    for (int i = 0; i < dummyTodos.length; i++) {
      if (dummyTodos[i].id == todo.id) {
        dummyTodos[i] = todo;
      }
    }
  }
}
