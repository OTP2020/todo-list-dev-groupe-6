import 'package:todo_list/models/category.dart';
import 'package:todo_list/repositories/repository.dart';

class CategoryService{
  late Repository _repository;

  CategoryService(){
    _repository = Repository();
  }

  // create data
  saveCategory(Category category) async{
    if(category.id != null){
      category.id++;
      return await _repository.insertData('categories', category.categoryMap());
    }
    return await _repository.insertData('categories', category.categoryMap());
  }

  // Read data from table
  readCategorie() async{
    return await _repository.readData('categories');
  }

  // Read data from table by id
  readCategoryById(categoryId) async{
    return await _repository.readDataById('categories', categoryId);
  }

  // Update data from table
  updateCategory(Category category) async{
    return await _repository.updateData('categories', category.categoryMap());
  }

  // Delete data from table
  deleteCategory(categoryId) async{
    return await _repository.deleteData('categories', categoryId);
  }
}