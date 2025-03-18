import 'package:floor/floor.dart';


@entity //this is an entity
class ToDoItem {
  static int ID = 1; //this is a static variable
  @primaryKey //this is a primary key
  final int id;

  final String todoItem;

  ToDoItem(this.id, this.todoItem) {
    if ( id > ID) {
      ID = id + 1;
    }
  }


  toString() {
    return "$id:$todoItem";
  }
}
