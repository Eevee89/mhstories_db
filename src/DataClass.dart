import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import 'DataBase.dart';

class DataClass {
  static DataClass? _instance;
  String url = "";
  bool end = false;
  List<dynamic> monsters = [];
  List<dynamic> quests = [];
  List<dynamic> genes = [];
  List<dynamic> skills = [];
  List<dynamic> displayedM = [];
  List<dynamic> displayedQ = [];
  List<dynamic> displayedS = [];
  List<dynamic> displayedG = [];
  List<dynamic> favorites = [];
  List<Uint8List> icons = [];
  List<Uint8List> eggs = [];

  DataClass._internal();

  factory DataClass() {
    return _instance ??= DataClass._internal();
  }

  Future<Response?> apiCallFor(String route) async {
    final response = await http.get(
        Uri.parse(url+route),
        //headers: {'Authorization':'token ${dotenv.env["TOKEN"]!}'}
    );
    if (response.statusCode == 200) {
      return response;
    }
    else {
      return null;
    }
  }

  Future<void> initialize() async {
    url = "https://raw.githubusercontent.com/Eevee89/mhstories_db/main/";
    Response? response = await apiCallFor("monsters_stories.json");
    if (response != null) {
      monsters = jsonDecode(response.body);
      displayedM = monsters;
    }

    response = await apiCallFor("quests.json");
    if (response != null) {
      quests = jsonDecode(response.body);
      displayedQ = quests;
    }

    response = await apiCallFor("genes.json");
    if (response != null) {
      genes = jsonDecode(response.body);
      displayedG = genes;
    }

    response = await apiCallFor("skills.json");
    if (response != null) {
      skills = jsonDecode(response.body);
      displayedS = skills;
    }
  }

  void searchMonsters(String pattern) {
    displayedM = [];
    for (dynamic monster in monsters.where((elt) => elt["en"].toString().toLowerCase().contains(pattern))) {
      displayedM.add(monster);
    }
  }

  void searchQuests(String pattern, String type) {
    displayedQ = [];
    for (dynamic quest in quests.where((elt) => elt["Title"].toString().toLowerCase().contains(pattern))) {
      if (type == "Quest types" || quest["Target"].contains(type)) {
        displayedQ.add(quest);
      }
    }
  }

  void searchGenes(String pattern, String element) {
    displayedG = [];
    for (dynamic gene in genes.where((elt) => elt["Name"].toString().toLowerCase().contains(pattern))) {
      if (element == "Elements" || gene["Element"] == element) {
        displayedG.add(gene);
      }
    }
  }

  void searchSkills(String pattern, String category) {
    displayedS = [];
    for (dynamic skill in skills.where((elt) => elt["Name"].toString().toLowerCase().contains(pattern))) {
      if (category == "Categories" || skill["Category"] == category) {
        displayedS.add(skill);
      }
    }
  }

  List<dynamic> updateFavorites(String type) {
    favorites = [];
    for (dynamic fav in DataBase().favorites) {
      if ((type == "All" || type == "Monsters") && fav["type"] == "Monster" && fav["favorite"] == 1) {
        favorites.add(monsters[fav["entity"]-1]);
      }
      if ((type == "All" || type == "Quests") && fav["type"] == "Quest" && fav["favorite"] == 1) {
        favorites.add(quests[fav["entity"]]);
      }
      if ((type == "All" || type == "Genes") && fav["type"] == "Gene" && fav["favorite"] == 1) {
        favorites.add(genes[fav["entity"]]);
      }
      if ((type == "All" || type == "Skills") && fav["type"] == "Skill" && fav["favorite"] == 1) {
        favorites.add(skills[fav["entity"]]);
      }
    }
    return favorites;
  }
}