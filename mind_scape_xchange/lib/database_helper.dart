import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:developer';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'my_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
      'CREATE TABLE users(id INTEGER PRIMARY KEY, username TEXT, email TEXT, password TEXT)',
    );
    log('Table created successfully');
  }

  Future<int> insertUser(Map<String, dynamic> user) async {
    try {
      Database db = await instance.database;
      return await db.insert('users', user);
    } catch (e) {
      log('Error inserting user: $e');
      rethrow;
    }
  }

  Future<List<Map<String, dynamic>>> getUsers() async {
    Database db = await instance.database;
    return await db.query('users');
  }
}
