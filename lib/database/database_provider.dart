import 'package:sqflite/sqflite.dart';

class DataBaseProvider{
  static const _dbName = 'cadastro_de_tarefas.db';
  static const _dbVersion = 1;

  DataBaseProvider._init();

  static final DataBaseProvider instance = DataBaseProvider._init();

  Database? _database;

}