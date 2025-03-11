import 'package:floor/floor.dart';
import 'ShoppingList.dart';

@dao
abstract class ShoppingListDAO {
  @Query('SELECT * FROM ShoppingList')
  Future<List<ShoppingList>> getAllItems();

  @Query('SELECT * FROM ShoppingList WHERE ID = :id')
  Future<ShoppingList?> findListById(int id);

  @Query('SELECT * FROM ShoppingList WHERE shoppingListItem = :item')
  Future<ShoppingList?> findListByItem(String item);

  @insert
  Future<void> insertList(ShoppingList list);

  @update
  Future<void> updateIList(ShoppingList list);

  @delete
  Future<void> deleteList(ShoppingList list);
}