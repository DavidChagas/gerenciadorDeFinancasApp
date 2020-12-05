import 'dart:async';
import 'package:gerenciadorDeFinancasApp/dominio/receita.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

final String receitaTable = "receitas";
final String idCol = "idCol";
final String dataCol = "dataCol";
final String valorCol = "valorCol";
final String descricaoCol = "descricaoCol";
final String recebidoCol = "recebidoCol";

class ReceitaHelper {
  static final ReceitaHelper _instance = ReceitaHelper.internal();
  factory ReceitaHelper() => _instance;
  ReceitaHelper.internal();
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
    return await openDatabase(path, version: 1,
        onCreate: (Database db, int newerVersion) async {
      await db.execute(
          "CREATE TABLE $receitaTable ($idCol INTEGER PRIMARY KEY AUTOINCREMENT, $dataCol TEXT, $valorCol TEXT, $descricaoCol TEXT, $recebidoCol TEXT)");
    });
  }

  Future<Receita> inserir(Receita receita) async {
    Database dbReceita = await db;
    receita.id = await dbReceita.insert(receitaTable, receita.toMap());
    return receita;
  }

  Future<Receita> getObjeto(String idFind) async {
    Database dbReceita = await db;
    List<Map> maps = await dbReceita.query(receitaTable,
        columns: [idCol, dataCol, valorCol, descricaoCol, recebidoCol],
        where: "$idCol = ?",
        whereArgs: [idFind]);
    if (maps.length > 0) {
      return Receita.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<int> excluir(int idDel) async {
    Database dbReceita = await db;
    return await dbReceita
        .delete(receitaTable, where: "$idCol = ?", whereArgs: [idDel]);
  }

  Future<int> alterar(Receita receita) async {
    Database dbReceita = await db;
    return await dbReceita.update(receitaTable, receita.toMap(),
        where: "$idCol = ?", whereArgs: [receita.id]);
  }

  Future<List> obterTodos() async {
    Database dbReceita = await db;
    List listMap = await dbReceita.rawQuery("SELECT * FROM $receitaTable");

    List<Receita> listReceita = List();
    for (Map m in listMap) {
      listReceita.add(Receita.fromMap(m));
    }

    return listReceita;
  }
}
