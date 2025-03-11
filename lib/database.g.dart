// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $ShoppingListDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $ShoppingListDatabaseBuilderContract addMigrations(
      List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $ShoppingListDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<ShoppingListDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorShoppingListDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $ShoppingListDatabaseBuilderContract databaseBuilder(String name) =>
      _$ShoppingListDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $ShoppingListDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$ShoppingListDatabaseBuilder(null);
}

class _$ShoppingListDatabaseBuilder
    implements $ShoppingListDatabaseBuilderContract {
  _$ShoppingListDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $ShoppingListDatabaseBuilderContract addMigrations(
      List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $ShoppingListDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<ShoppingListDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$ShoppingListDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$ShoppingListDatabase extends ShoppingListDatabase {
  _$ShoppingListDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  ShoppingListDAO? _shoppingListDAOInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `ShoppingList` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `shoppingListItem` TEXT NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  ShoppingListDAO get shoppingListDAO {
    return _shoppingListDAOInstance ??=
        _$ShoppingListDAO(database, changeListener);
  }
}

class _$ShoppingListDAO extends ShoppingListDAO {
  _$ShoppingListDAO(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _shoppingListInsertionAdapter = InsertionAdapter(
            database,
            'ShoppingList',
            (ShoppingList item) => <String, Object?>{
                  'id': item.id,
                  'shoppingListItem': item.shoppingListItem
                }),
        _shoppingListUpdateAdapter = UpdateAdapter(
            database,
            'ShoppingList',
            ['id'],
            (ShoppingList item) => <String, Object?>{
                  'id': item.id,
                  'shoppingListItem': item.shoppingListItem
                }),
        _shoppingListDeletionAdapter = DeletionAdapter(
            database,
            'ShoppingList',
            ['id'],
            (ShoppingList item) => <String, Object?>{
                  'id': item.id,
                  'shoppingListItem': item.shoppingListItem
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ShoppingList> _shoppingListInsertionAdapter;

  final UpdateAdapter<ShoppingList> _shoppingListUpdateAdapter;

  final DeletionAdapter<ShoppingList> _shoppingListDeletionAdapter;

  @override
  Future<List<ShoppingList>> getAllItems() async {
    return _queryAdapter.queryList('SELECT * FROM ShoppingList',
        mapper: (Map<String, Object?> row) =>
            ShoppingList(row['id'] as int?, row['shoppingListItem'] as String));
  }

  @override
  Future<ShoppingList?> findListById(int id) async {
    return _queryAdapter.query('SELECT * FROM ShoppingList WHERE ID = ?1',
        mapper: (Map<String, Object?> row) =>
            ShoppingList(row['id'] as int?, row['shoppingListItem'] as String),
        arguments: [id]);
  }

  @override
  Future<ShoppingList?> findListByItem(String item) async {
    return _queryAdapter.query(
        'SELECT * FROM ShoppingList WHERE shoppingListItem = ?1',
        mapper: (Map<String, Object?> row) =>
            ShoppingList(row['id'] as int?, row['shoppingListItem'] as String),
        arguments: [item]);
  }

  @override
  Future<void> insertList(ShoppingList list) async {
    await _shoppingListInsertionAdapter.insert(list, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateIList(ShoppingList list) async {
    await _shoppingListUpdateAdapter.update(list, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteList(ShoppingList list) async {
    await _shoppingListDeletionAdapter.delete(list);
  }
}
