import 'package:todo_list/models/category.dart';

class Todo{
  late int id = 1;
  late String title;
  late String description;
  late String date;
  late String category;
  late int isFinished;

  todoMap(){
    var mapping = Map<String, dynamic>();
    mapping['id'] = id;
    mapping['title'] = title;
    mapping['description'] = description;
    mapping['category'] = category;
    mapping['date'] = date;
    mapping['isFinished'] = isFinished;

    return mapping;
  }

}