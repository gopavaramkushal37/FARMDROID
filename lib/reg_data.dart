import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

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
    String path = join(await getDatabasesPath(), 'registration.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE registration (
        id INTEGER PRIMARY KEY,
        name TEXT,
        mobile TEXT,
        password TEXT,
        address TEXT,
        pincode TEXT,
        role TEXT
      )
    ''');
  }

  Future<void> insertRegistration(Map<String, dynamic> data) async {
    Database db = await instance.database;
    await db.insert('registration', data);
  }

  Future<List<Map<String, dynamic>>> getAllRegistrations() async {
    Database db = await instance.database;
    return await db.query('registration');
  }

  Future<List<Map<String, dynamic>>> getUser({
    required String mobile,
    required String password,
    required String role,
  }) async {
    Database db = await instance.database;
    return await db.query(
      'registration',
      where: 'mobile = ? AND password = ? AND role = ?',
      whereArgs: [mobile, password, role],
    );
  }

  Future<List<Map<String, dynamic>>> getUsersWithPinCode(String pinCode) async {
    Database db = await instance.database;
    return await db.query(
      'registration',
      where: 'pincode = ?', // Filter by pincode
      whereArgs: [pinCode],
    );
  }
}
