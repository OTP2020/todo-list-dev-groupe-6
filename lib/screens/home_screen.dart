import 'package:flutter/material.dart';
import 'package:todo_list/helpers/drawer_navigation.dart';
import 'package:todo_list/models/todo.dart';
import 'package:todo_list/screens/todo_screen.dart';
import 'package:todo_list/services/todo_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  late TodoService _todoService;
  List<Todo> _todoList = <Todo>[];

  @override
  initState(){
    super.initState();
    getAllTodos();
  }

  getAllTodos() async{
    _todoService = TodoService();
    _todoList = <Todo>[];

    var todos = await _todoService.readTodos();

    todos.forEach((todo){
      setState(() {
        var model = Todo();
        model.id = todo['id'];
        model.title = todo['title'];
        model.description = todo['description'];
        model.category = todo['category'];
        model.date = todo['date'];
        model.isFinished = todo['isFinished'];
        _todoList.add(model);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ToDo_List Groupe 6'),
      ),
      drawer: DrawerNavigation(),
      body: ListView.builder(
          itemCount: _todoList.length, itemBuilder: (context, index) {
        return Padding(
            padding: EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
            child: Card(
             elevation: 8.0,
              child: ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(_todoList[index].title ?? 'Pas de Titre')
                  ],
                ),
                subtitle: Text(_todoList[index].category ?? 'Pas de catégory'),
                trailing: Text(_todoList[index].date ?? 'Pas de date'),
            )
          )
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>TodoScreen())),
        child: Icon(Icons.add),
      ),
    );
  }
}
