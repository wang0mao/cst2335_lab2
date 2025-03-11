import 'dart:async';
import 'ShoppingList.dart';
import 'ShoppingListDAO.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart';

@Database(version: 1, entities: [ShoppingList])
abstract class ShoppingListDatabase extends FloorDatabase {
  ShoppingListDAO get shoppingListDAO;
}