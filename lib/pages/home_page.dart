import 'package:flutter/material.dart';
import 'package:todoapp/data/database.dart';
import 'package:todoapp/data/saved_phrases_manager.dart';
import 'package:todoapp/util/dialog_box.dart';
import 'package:todoapp/util/my_drawer.dart';
import 'package:todoapp/util/todo_tile.dart';
import 'package:hive_flutter/hive_flutter.dart';

// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_element
// ignore_for_file: sort_child_properties_last

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
// refrence the hive box
  final _myBox = Hive.box('mybox');

  ToDoDatabase db = ToDoDatabase();

  @override
  void initState() {
    //if this is the 1st time ever opening the app, then create default data
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      //there already exists data
      db.loadData();
    }
    super.initState();
  }

  SavedPhrasesManager savedPhrasesManager = SavedPhrasesManager();

  final _controller = TextEditingController();

  void checBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDatabase();
  }

  void saveNewTask() {
    if (_controller.text.trim().isEmpty) {
      // لا تفعل شيئًا إذا كان الحقل فارغًا
      Navigator.pop(context);
      return;
    }
    setState(() {
      db.toDoList.add([_controller.text, false]);
      _controller.clear();
      Navigator.pop(context);
    });
    db.updateDatabase();
  }

  void createnewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          phrasesManager: SavedPhrasesManager(),
          myController: _controller,
          onSave: saveNewTask,
          onCancel: () => Navigator.pop(context),
        );
      },
    );
  }

  void deletTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDatabase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        title: Text("TO DO"),
        backgroundColor: Colors.yellowAccent,
        elevation: 0,
        // leading: Icon(Icons.menu),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createnewTask,
        backgroundColor: Colors.yellow,
        child: Icon(
          Icons.add,
          color: Colors.black,
        ),
      ),
      drawer: MyDrawer(phrasesManager: savedPhrasesManager),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: db.toDoList[index][0],
            deleteFunction: (context) => deletTask(index),
            taskCompleted: db.toDoList[index][1],
            onChanged: (value) {
              setState(() => checBoxChanged(value, index));
            },
          );
        },
      ),
    );
  }
}
