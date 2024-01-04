import 'package:flutter_sample/database/constants.dart';
import 'package:flutter_sample/database/user.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const String databaseName = 'flutter_sample.db';
  Database? _database;

  Future<Database> getDatabaseInstance() async {
    _database ??= await openDatabase(
      join(await getDatabasesPath(), databaseName),
      onCreate: (db, version) {
        return db.execute(
          '''CREATE TABLE ${Constants.tableUser}(
              ${Constants.columnId} INTEGER PRIMARY KEY AUTOINCREMENT, 
              ${Constants.columnName} TEXT NOT NULL, 
              ${Constants.columnAge} INTEGER NOT NULL)''',
        );
      },
      version: 1,
    );

    return _database!;
  }

  Future<void> close() async {
    _database?.close();
  }
}

class UserProvider {
  final Database _database;

  const UserProvider({required database}) : _database = database;

  Future<int> insert(User user) async {
    return await _database.insert(Constants.tableUser, user.toMap());
  }

  Future<User> get(int id) async {
    final jsons = await _database.query(
      Constants.tableUser,
      where: '${Constants.columnId} = ?',
      whereArgs: [id],
    );
    if (jsons.isEmpty) {
      return Future.error('id에 부합하는 데이터가 없습니다.');
    }
    return User.fromJson(jsons.first);
  }

  Future<List<User>> getAll() async {
    var maps = await _database.query(Constants.tableUser);
    return maps.map((json) => User.fromJson(json)).toList();
  }

  Future<int> delete(int id) async {
    return await _database.delete(
      Constants.tableUser,
      where: '${Constants.columnId} = ?',
      whereArgs: [id],
    );
  }

  Future<int> update(User user) async {
    return await _database.update(
      Constants.tableUser,
      user.toMap(),
      where: '${Constants.columnId} = ?',
      whereArgs: [user.id],
    );
  }
}
