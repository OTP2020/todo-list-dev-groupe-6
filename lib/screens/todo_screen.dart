import 'package:flutter/material.dart';
import 'package:todo_list/models/todo.dart';
import 'package:todo_list/services/category_service.dart';
import 'package:intl/intl.dart';
import 'package:todo_list/services/todo_service.dart';

class TodoScreen extends StatefulWidget {
  const TodoScreen({super.key});

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  var _todoTitleController = TextEditingController();

  var _todoDescriptionController = TextEditingController();

  var _todoDateController = TextEditingController();

  var _selectedValue;

  var _categories =<DropdownMenuItem>[];

  @override
  void initState(){
    super.initState();
    _loadCategories();
  }

  _loadCategories() async{
    var _categoryService = CategoryService();
    var categories = await _categoryService.readCategorie();
    categories.forEach((category){
      setState(() {
        _categories.add(DropdownMenuItem(
            child: Text(category['name']),
            value: category['name'],
        ));
      });
    });
  }

  DateTime _dateTime = DateTime.now();

  _selectedTodoDate(BuildContext context) async{
    var _pickedDate = await showDatePicker(
        context: context,
        initialDate: _dateTime,
        firstDate: DateTime(2000),
        lastDate: DateTime(2100),);

      if(_pickedDate != null){
        setState(() {
          _dateTime = _pickedDate;
          _todoDateController.text = DateFormat('yyyy-MM-dd').format(_pickedDate);
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text('Créer une tâche'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _todoTitleController,
              decoration: InputDecoration(
                labelText: 'Titre',
                hintText: 'Titre de la tâche'
              ),
            ),
            TextField(
              controller: _todoDescriptionController,
              decoration: InputDecoration(
                  labelText: 'Description',
                  hintText: 'Description de la tâche'
              ),
            ),
            TextField(
              controller: _todoDateController,
              decoration: InputDecoration(
                  labelText: 'Date',
                  hintText: 'Date de la tâche',
                prefixIcon: InkWell(
                  onTap: () {
                    _selectedTodoDate(context);
                  },
                  child: Icon(Icons.calendar_today),
                ),
              ),
            ),
            DropdownButtonFormField(
                items: _categories,
                value: _selectedValue,
                hint: Text('Catégorie'),
               onChanged: (value){
                  setState(() {
                    _selectedValue = value;
                  });
               },
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () async{
                  var todoObject = Todo();

                  todoObject.title = _todoTitleController.text;
                  todoObject.description = _todoDescriptionController.text;
                  todoObject.date = _todoDateController.text;
                  todoObject.isFinished = 0;
                  todoObject.category = _selectedValue.toString();

                  var _todoService = TodoService();
                  var result = await _todoService.saveTodo(todoObject);

                  print(result);
                },
                child: Text('Enregistrer'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Background color
              ),
            ),
          ],
        ),
      ),
    );
  }
}
