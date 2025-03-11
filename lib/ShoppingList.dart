import 'package:floor/floor.dart';

@entity
class ShoppingList{
  static int ID = 1;

  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String shoppingListItem;

  ShoppingList(this.id, this.shoppingListItem){
     //if ( id > ID) {
      //ID = id + 1;
      //}
  }

  @override
  String toString() {
    // TODO: implement toString
    return "$id: $shoppingListItem";
  }
}