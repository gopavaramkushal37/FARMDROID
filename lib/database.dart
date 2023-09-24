import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), 'resources.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE resources (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        mobile TEXT,
        price REAL,
        entity TEXT,
        pincode TEXT
      )
    ''');
  }

  Future<void> insertData(String name, String mobile, double price, String entity, String pincode) async {
    final db = await database;
    await db.insert(
      'resources',
      {
        'name': name,
        'mobile': mobile,
        'price': price,
        'entity': entity,
        'pincode': pincode,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
