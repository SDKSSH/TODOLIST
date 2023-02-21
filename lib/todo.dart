import 'package:flutter/material.dart';

class Todo{
  const Todo({required this.name});

  final String name;
}

typedef TodoCallBack = Function(Todo todo, bool finish);

class TodoItem extends StatelessWidget {
  TodoItem({required this.todo,
  required this.finish,
  required this.callBack}) : super(key: ObjectKey(todo));

  final Todo todo;
  final bool finish;
  final TodoCallBack callBack;

  IconData _getIcon(){
    if(!finish){
      return Icons.check_box_outline_blank;
    }else{
      return Icons.check_box;
    }
  }

  TextStyle _getTextStyle(BuildContext context){
    if(!finish){
      return const TextStyle(color: Colors.white, fontSize: 40);
    }else{
      return const TextStyle(color: Colors.white12, fontSize: 40, decoration: TextDecoration.lineThrough);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: (){
        callBack(todo, finish);
      },
      title: Text(
        todo.name,
        style: _getTextStyle(context),
      ),
      leading: Icon(_getIcon(), color: Colors.white),
    );
  }
}

typedef ToDoTypeCallBack = Function(String name);

class NewTodoItem extends StatelessWidget {
  NewTodoItem({required this.callBack});

  final ToDoTypeCallBack callBack;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Form(
        child: TextFormField(
          decoration: InputDecoration(
            hintText: "Add your new things to do",
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white)
            ),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white)
            ),
            labelStyle: TextStyle(color: Colors.white),
            hintStyle: TextStyle(color: Colors.white),
            fillColor: Colors.white,
            filled: true
          ),
          onFieldSubmitted: (value) {
            callBack(value);
          },
        ),
      ),
      leading: Icon(Icons.edit, color: Colors.white),
    );
  }

}