import 'package:flutter/material.dart';
import 'package:todo_list/services/todo_service.dart';

import '../models/todo.dart';

class TodosByCategory extends StatefulWidget {
  late String category;
  //TodosByCategory({this.category});


  @override
  State<TodosByCategory> createState() => _TodosByCategoryState();
}

class _TodosByCategoryState extends State<TodosByCategory> {

  List<Todo> _todoList = <Todo>[];
  TodoService _todoService = TodoService();

  @override
  initState(){
    super.initState();
    getTodosByCategories();
  }

  getTodosByCategories() async{
    var todos = await _todoService.readTodoByCategory(this.widget.category);
    todos.forEach((todo){
      setState(() {
        var model = Todo();
        model.title = todo['title'];
        model.description = todo['description'];
        model.date = todo['data'];

        _todoList.add(model);
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tâches par catégorie'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(child: ListView.builder(itemCount: _todoList.length,
              itemBuilder: (context, index){
                return Padding(
                  padding: EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
                  child: Card(
                    elevation: 8,
                    child: ListTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(_todoList[index].title ?? 'Pas de Titre')
                        ],
                      ),
                      subtitle: Text(_todoList[index].description ?? 'Pas de description'),
                      trailing: Text(_todoList[index].date ?? 'Pas de date'),
                    ),
                  ),
                );
              })),
        ],
      ),
    );
  }
}
