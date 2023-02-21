import 'package:flutter/material.dart';
import 'todo.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EnigmaList',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0x34495e)
      ),
      home: const MyHomePage(title: 'ToDo List'),
    );
  }
}

class Vars{
  static late bool writting = false;
  static List<Todo> todos = [];
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _finishTodo = <Todo>{};

  void addNewTodo() {
    setState(() {
      Vars.writting = true;
    });
  }

  void onAddTodo(String name){
    setState((){
      Vars.todos.add(new Todo(name: name));
      Vars.writting = false;
    });
  }

  void onTodo(Todo todo, bool finish){
    setState(() {
      if(!finish){
        _finishTodo.add(todo);
      }else{
        _finishTodo.remove(todo);
      }
    });
  }

  List<Widget> getWidgetsForChildren(){
    List<Widget> widgetslist = [];
    widgetslist.addAll(Vars.todos.map((thetodo) {
      return TodoItem(
        todo: thetodo,
        finish: _finishTodo.contains(thetodo),
        callBack: onTodo,
      );
    }));
    if(Vars.writting == true){
      widgetslist.add(NewTodoItem(callBack: onAddTodo));
    }
    return widgetslist;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
        backgroundColor: Colors.blue,
      ),
      body: ListView(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
        children: getWidgetsForChildren()
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addNewTodo,
        tooltip: 'Add new things to do',
        child: const Icon(Icons.add),
      ),
    );
  }
}
