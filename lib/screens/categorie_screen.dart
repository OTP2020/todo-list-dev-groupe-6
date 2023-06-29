import 'package:flutter/material.dart';
import 'package:todo_list/services/category_service.dart';

import '../models/category.dart';
import 'home_screen.dart';
class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {

  var _categoryNameController = TextEditingController();
  var _categoryDescriptionController = TextEditingController();

  var _category = Category();
  var _categoryService = CategoryService();

  var category;

  List<Category> _categoryList = <Category>[];

  var _editcategoryNameController = TextEditingController();
  var _editcategoryDescriptionController = TextEditingController();

  @override
  void initState(){
    super.initState();
    getAllCategories();
  }

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  getAllCategories() async{
    _categoryList = [];
    var categories = await _categoryService.readCategorie();
    categories.forEach((category){
      setState(() {
        var categoryModel = Category();
        categoryModel.name = category['name'];
        categoryModel.description = category['description'];
        categoryModel.id = category['id'];
        _categoryList.add(categoryModel);
      });
    });
  }

  _editCategory(BuildContext context, categoryId) async{
    category = await _categoryService.readCategoryById(categoryId);
    setState(() {
      _editcategoryNameController.text = category[0]['name'] ?? 'Pas de nom';
      _editcategoryDescriptionController.text = category[0]['description'] ?? 'Pas de description';
      _editFormDialog(context);
    });
  }

  _showFormDialog(BuildContext context){
    return showDialog(context: context, barrierDismissible: true, builder: (param){
      return AlertDialog(
        actions: <Widget>[
          TextButton(
            onPressed: ()=>Navigator.pop(context),
            child: Text('Annuler'),
            style: TextButton.styleFrom(
              primary: Colors.red, // Text Color
            ),
          ),
          TextButton(
            onPressed: () async{
              _category.name = _categoryNameController.text;
              _category.description = _categoryDescriptionController.text;

              var result = await _categoryService.saveCategory(_category);
              if(result > 0){
                Navigator.pop(context);
                getAllCategories();
                //_showSuccesfullSnackBar(Text('Enregisté'));
              }
            },
            child: Text('Enregistrer'),
          )
        ],
        title: Text('Enregistrement tâche'),
        content: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TextField(
                controller: _categoryNameController,
                decoration: InputDecoration(
                  hintText: 'Saisissez la tâche',
                  labelText: 'Tâche'
                ),
              ),
              TextField(
                controller: _categoryDescriptionController,
                decoration: InputDecoration(
                    hintText: 'Saisissez une description',
                    labelText: 'Description'
                ),
              )
            ],
          ),
        ),
      );
    });
  }

  _editFormDialog(BuildContext context){
    return showDialog(context: context, barrierDismissible: true, builder: (param){
      return AlertDialog(
        actions: <Widget>[
          TextButton(
            onPressed: ()=>Navigator.pop(context),
            child: Text('Annuler'),
            style: TextButton.styleFrom(
              primary: Colors.red, // Text Color
            ),
          ),
          TextButton(
            onPressed: () async{
              _category.id = category[0]['id'];
              _category.name = _editcategoryNameController.text;
              _category.description = _editcategoryDescriptionController.text;

              var result = await _categoryService.updateCategory(_category);
              if(result > 0){
                Navigator.pop(context);
                getAllCategories();
                //_showSuccesfullSnackBar(Text('Modifié'));
              }
            },
            child: Text('Enregistrer'),
          )
        ],
        title: Text('Modifier une tâche'),
        content: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              TextField(
                controller: _editcategoryNameController,
                decoration: InputDecoration(
                    hintText: 'Saisissez la tâche',
                    labelText: 'tâche'
                ),
              ),
              TextField(
                controller: _editcategoryDescriptionController,
                decoration: InputDecoration(
                    hintText: 'Saisissez une description',
                    labelText: 'Description'
                ),
              )
            ],
          ),
        ),
      );
    });
  }

  _deleteFormDialog(BuildContext context, categoryId){
    return showDialog(context: context, barrierDismissible: true, builder: (param){
      return AlertDialog(
        actions: <Widget>[
          TextButton(
            onPressed: ()=>Navigator.pop(context),
            child: Text('Annuler'),
            style: TextButton.styleFrom(
              primary: Colors.green, // Text Color
            ),
          ),
          TextButton(
            onPressed: () async{
              var result = await _categoryService.deleteCategory(categoryId);
              if(result > 0){
                Navigator.pop(context);
                getAllCategories();
                //_showSuccesfullSnackBar(Text('Supprimé'));
              }
            },
            child: Text('Delete'),
            style: TextButton.styleFrom(
              primary: Colors.red, // Text Color
            ),
          )
        ],
        title: Text('Confirmation'),
      );
    });
  }

 /* _showSuccesfullSnackBar(message){
    var _snackBar = SnackBar(content: message);
    _globalKey.currentState.showSnackBar(_snackBar);
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        leading: ElevatedButton(
          onPressed: ()=>Navigator.of(context)
              .push(MaterialPageRoute(builder: (context)=>HomeScreen())),
          child: Icon(Icons.arrow_back),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue, // Background color
          ),
        ),
        title: Text('Tâches'),
      ),
      body: ListView.builder(
          itemCount:_categoryList.length, itemBuilder: (context, index){
            return Padding(
              padding: EdgeInsets.only(top: 8.0, left: 16.0, right: 16.0),
              child: Card(
                elevation: 8.0,
                child: ListTile(
                  leading: IconButton(icon: Icon(Icons.edit), onPressed: (){
                    _editCategory(context, _categoryList[index].id);
                  }),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(_categoryList[index].name),
                      IconButton(
                          onPressed: (){
                            _deleteFormDialog(context, _categoryList[index].id);
                          },
                          icon: Icon(
                              Icons.delete,
                              color: Colors.red
                          ),
                      )
                    ],
                  ),
                ),
              ),
            );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showFormDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
