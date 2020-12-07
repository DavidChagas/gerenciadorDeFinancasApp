import 'dart:async';
import 'package:gerenciadorDeFinancasApp/dominio/despesa.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

final String despesaTable = "despesas";
final String idCol = "idCol";
final String dataCol = "dataCol";
final String valorCol = "valorCol";
final String descricaoCol = "descricaoCol";
final String pagoCol = "pagoCol";

class DespesaHelper {
  static final DespesaHelper _instance = DespesaHelper.internal();
  factory DespesaHelper() => _instance;
  DespesaHelper.internal();
  Database _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    } else {
      _db = await initDb();
      return _db;
    }
  }

  Future<Database> initDb() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, "gerenciadorDeFinancasDB.db");
    return await openDatabase(path, version: 2,
        onCreate: (Database db, int newerVersion) async {
      await db.execute(
          "CREATE TABLE $despesaTable ($idCol INTEGER PRIMARY KEY AUTOINCREMENT, $dataCol TEXT, $valorCol TEXT, $descricaoCol TEXT, $pagoCol TEXT)");
    });
  }

  Future<Despesa> inserir(Despesa despesa) async {
    Database dbDespesa = await db;
    despesa.id = await dbDespesa.insert(despesaTable, despesa.toMap());
    return despesa;
  }

  Future<Despesa> getObjeto(String idFind) async {
    Database dbDespesa = await db;
    List<Map> maps = await dbDespesa.query(despesaTable,
        columns: [idCol, dataCol, valorCol, descricaoCol, pagoCol],
        where: "$idCol = ?",
        whereArgs: [idFind]);
    if (maps.length > 0) {
      return Despesa.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<int> excluir(int idDel) async {
    Database dbDespesa = await db;
    return await dbDespesa
        .delete(despesaTable, where: "$idCol = ?", whereArgs: [idDel]);
  }

  Future<int> alterar(Despesa despesa) async {
    Database dbDespesa = await db;
    return await dbDespesa.update(despesaTable, despesa.toMap(),
        where: "$idCol = ?", whereArgs: [despesa.id]);
  }

  Future<List> obterTodos() async {
    Database dbDespesa = await db;
    List listMap = await dbDespesa.rawQuery("SELECT * FROM $despesaTable");

    List<Despesa> listDespesa = List();
    for (Map m in listMap) {
      listDespesa.add(Despesa.fromMap(m));
    }

    return listDespesa;
  }

  Future<List> totalDespesas(mes) async {
    Database dbDespesa = await db;
    List total = await dbDespesa.rawQuery(
        "SELECT SUM( REPLACE([valorCol],'R\$','') ) AS [total] FROM $despesaTable");
    return total;
  }
}
