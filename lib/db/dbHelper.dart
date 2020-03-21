import 'package:flutterdbapp/modals/product.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart'; // sqlflite
import 'dart:async'; // async operations
import 'dart:io'; // file operations

class DbHelper {
  final String tblProduct = "Product";
  final String colId = "id";
  final String colName = "name";
  final String colDsc = "dsc";
  final String colPrice = "price";

  // database erisimi icin kullanilacak nesne
  static Database _db;

  DbHelper._internal();

  static final DbHelper _dbHelper = DbHelper._internal();

  // singleton nesne dondurur.
  factory DbHelper() {
    return _dbHelper;
  }

  Future<Database> get db async {
    if (_db == null) {
      _db = await initializeDb();
    }
    return _db;
  }

  Future<Database> initializeDb() async {
    // path provider araciligiyla ios ve android deki db dosya pathi gelir.
    Directory directory = await getApplicationDocumentsDirectory();

    // db pathi ile adi
    String path = directory.path + "ecommerce.db";

    var dbECommerce = await openDatabase(path, version: 1, onCreate: _createProduct);

    return dbECommerce;
  }

  void _createProduct(Database db, int version) async {
    await db.execute("Create table $tblProduct($colId integer primary key ," +
        "$colName text , $colDsc text, $colPrice real)");
  }

  /**
   * db insert islemi
   */
  Future<int> insertProduct(Product product) async {
    Database _db = await this.db;

    var result = await _db.insert(tblProduct, product.toMap());

    return result;
  }

  /**
   * withId named constructor ile cagirilmasi gerekiyor.
   * Cnku update isleminde id gitmemeli
   */
  Future<int> updateProduct(Product product) async {
    Database _db = await this.db;
    var result = await _db.update(tblProduct, product.toMap(),
        where: "$colId = ?", whereArgs: [product.id]);
    return result;
  }
  
  Future<int> deleteProduct(int id) async{
    Database _db = await this.db;
    var result = await _db.delete(tblProduct,where: "$colId = ?",whereArgs: [id] );
    // var result2 = await _db.rawDelete("Delete * from $tblProduct where $colId = "+id); 
    return result;
  }
  
  Future<List> getProduct() async{
    Database _db = await this.db;
    var result = await _db.rawQuery("Select * from $tblProduct");

    return result;
  }
}
