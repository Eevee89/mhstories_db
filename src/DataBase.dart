import 'package:sqflite/sqflite.dart';

class DataBase {
  static DataBase? _instance;
  late final db;
  List<dynamic> favorites = [];
  List<dynamic> tasks = [];

  DataBase._internal();

  factory DataBase() {
    return _instance ??= DataBase._internal();
  }

  Future<void> initialize() async {
    db = await openDatabase("assets/database.db");
    await getAllFavorites();
  }

  Future<void> getAllFavorites() async {
    String query = "SELECT * FROM favorites;";
    List<Map> resultSet = await db.rawQuery(query);
    favorites = [];
    for(dynamic res in resultSet) {
      favorites.add(res);
    }
  }

  Future<void> insertFav(dynamic fav) async {
    String query = "INSERT INTO favorites (type,entity,favorite) "
        "VALUES ('${fav['type']}',${fav['entity']},1);";
    await db.rawInsert(query);
    await getAllFavorites();
  }

  Future<void> updateFav(int id, dynamic fav) async {
    String query = "UPDATE favorites "
        "SET type = '${fav['type']}',"
        "entity = ${fav['entity']},"
        "favorite = ${fav['favorite']} "
        "WHERE id = $id;";
    await db.rawUpdate(query);
    await getAllFavorites();
  }

  Future<void> toggleFav(int id, String type) async {
    String query = "UPDATE favorites SET favorite = (1-favorite) "
        "WHERE type = '$type' AND entity = $id;";
    await db.rawUpdate(query);
    await getAllFavorites();
  }

  Future<void> deleteFav(int id) async {
    String query = "UPDATE favorites SET favorite = 0 WHERE id = $id;";
    await db.rawUpdate(query);
    await getAllFavorites();
  }

  Future<bool> isFavorite(int id, String type) async {
    String query = "SELECT favorite FROM favorites"
        "WHERE type = '$type' AND entity = $id;";
    List<Map> resultSet = await db.rawQuery(query);
    return resultSet[0]["favorite"] == 1;
  }

  bool isFav(int id, String type) {
    for(dynamic fav in favorites) {
      if (fav["type"] == type && fav["entity"] == id) {
        return fav["favorite"] == 1;
      }
    }
    return false;
  }
}