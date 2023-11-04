import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:task_one/services/models/transaction_details_model.dart';

class TransactionDetailDataBase {
  static final TransactionDetailDataBase instance =
      TransactionDetailDataBase._init();

  static Database? _database;

  TransactionDetailDataBase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('transactionDetails.db');

    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const integerType = 'INTEGER NOT NULL';

    await db.execute('''
CREATE TABLE $tableNotes ( 
  ${TransactionDetails.id} $idType, 
  ${TransactionDetails.status} $integerType,
  ${TransactionDetails.description} $textType,
  ${TransactionDetails.time} $textType
  )
''');
  }

  Future<TransactionDetail> create(TransactionDetail note) async {
    final db = await instance.database;

    final id = await db.insert(tableNotes, note.toJson());
    return note.copy(id: id);
  }

  Future<List<TransactionDetail>> readAllDocuments() async {
    final db = await instance.database;

    const orderBy = '${TransactionDetails.time} ASC';

    final result = await db.query(tableNotes, orderBy: orderBy);

    return result.map((json) => TransactionDetail.fromJson(json)).toList();
  }
}
