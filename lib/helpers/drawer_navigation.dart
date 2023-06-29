import 'package:flutter/material.dart';
import 'package:todo_list/screens/home_screen.dart';
import 'package:todo_list/screens/todos_by_category.dart';
import 'package:todo_list/services/category_service.dart';

import '../screens/categorie_screen.dart';

class DrawerNavigation extends StatefulWidget {
  const DrawerNavigation({super.key});

  @override
  State<DrawerNavigation> createState() => _DrawerNavigationState();
}

class _DrawerNavigationState extends State<DrawerNavigation> {

  List<Widget> _categoryList = <Widget>[];

  CategoryService _categoryService = CategoryService();

/*  @override
  initState(){
    super.initState();
    getAllCategories();
  }

  getAllCategories() async{
    var categories = await _categoryService.readCategorie();

    categories.forEach((category){
      setState(() {
        _categoryList.add(InkWell(
          onTap: ()=> Navigator.push(context,
              new MaterialPageRoute(
                  builder: (context)=> new TodosByCategory())),
          child: ListTile(
            title: Text(category['name']),
          ),
        ));
      });
    });
  }*/

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage('https://picsum.photos/id/237/200/300'),
                ),
                accountName: Text('Groupe 6'),
                accountEmail: Text('tegparfait@gmail'),
                decoration: BoxDecoration(color: Colors.blue),
            ),
/*            ListTile(
              leading: Icon(Icons.home),
              title: Text('Accueil'),
              onTap: ()=>Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context)=>HomeScreen())),
            ),*/
            ListTile(
              leading: Icon(Icons.view_list),
              title: Text('Tâches'),
              onTap: ()=>Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context)=>CategoriesScreen())),
            ),
            Divider(),
            Column(
              children: _categoryList,
            ),
          ],
        ),
      ),
    );
  }
}
