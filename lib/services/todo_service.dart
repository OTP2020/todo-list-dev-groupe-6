import 'package:todo_list/models/todo.dart';
import 'package:todo_list/repositories/repository.dart';

class TodoService{
  late Repository _repository;

  TodoService(){
    _repository = Repository();
  }

  saveTodo(Todo todo) async{
    if(todo.id != null){
      todo.id++;
      return await _repository.insertData('todos', todo.todoMap());
    }
    return await _repository.insertData('todos', todo.todoMap());
  }

  // Read Todos
  readTodos() async{
    return await _repository.readData('todos');
  }

  // Read Todos by category
  readTodoByCategory(category) async{
    return await _repository.readDataByColumnName('todos', 'category', category);
  }
}