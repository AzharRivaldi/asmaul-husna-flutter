import 'package:asmaul_husna/bookmark/model_bookmark.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  //inisialisasi beberapa variabel yang dibutuhkan
  final String tableName = 'tbl_bookmark';
  final String columnId = 'id';
  final String columnNumber = 'number';
  final String columnName = 'name';
  final String columnTranslate = 'translate';
  final String columnMeaning = 'meaning';
  final String columnKet = 'keterangan';
  final String columnAmalan = 'amalan';
  final String columnFlag = 'flag';

  DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  //cek apakah ada database
  Future<Database?> get checkDB async {
    if (_database != null) {
      return _database;
    }
    _database = await _initDB();
    return _database;
  }

  Future<Database?> _initDB() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'asmaulhusna.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  //membuat tabel dan field-fieldnya
  Future<void> _onCreate(Database db, int version) async {
    var sql = "CREATE TABLE $tableName($columnId INTEGER PRIMARY KEY, "
        "$columnNumber TEXT,"
        "$columnName TEXT,"
        "$columnTranslate TEXT,"
        "$columnMeaning TEXT,"
        "$columnKet TEXT,"
        "$columnAmalan TEXT,"
        "$columnFlag TEXT)";
    await db.execute(sql);
  }

  //insert ke database
  Future<int?> saveData(ModelBookmark modelBookmark) async {
    var dbClient = await checkDB;
    return await dbClient!.insert(tableName, modelBookmark.toMap());
  }

  //read data bookmark
  Future<List?> getDataBookmark() async {
    var dbClient = await checkDB;
    var result = await dbClient!.rawQuery('SELECT * FROM $tableName ORDER BY number');
    return result.toList();
  }

  //cek database bookmark
  Future<int?> cekDataBookmark() async {
    var dbClient = await checkDB;
    return Sqflite.firstIntValue(await dbClient!.
    rawQuery('SELECT COUNT(*) FROM $tableName'));
  }

  //hapus database bookmark
  Future<int?> deleteBookmark(int id) async {
    var dbClient = await checkDB;
    return await dbClient!.delete(tableName, where: '$columnId = ?', whereArgs: [id]);
  }

}
