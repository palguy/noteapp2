import 'package:hive_flutter/hive_flutter.dart';

class ToDoDatabase {
  List toDoList = [];

  //reference our box
  final _myBox = Hive.box('mybox');

// first time eveer open the app, create default data
  void createInitialData() {
    toDoList = [
      ['Start Coding', false],
      ['Do Exercise', false],
    ];
  }

  //load data from database
  void loadData() {
    toDoList = _myBox.get('TODOLIST');
  }

  //update database
  void updateDatabase() {
    _myBox.put('TODOLIST', toDoList);
  }
}
