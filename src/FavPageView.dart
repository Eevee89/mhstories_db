import 'package:flutter/material.dart';
import 'Genes/DetailPage.dart';
import 'Genes/ListTile.dart';
import 'Monsties/DetailPage.dart';
import 'DataClass.dart';
import 'Monsties/ListTile.dart';
import 'Quests/DetailPage.dart';
import 'Quests/ListTile.dart';
import 'Skills/DetailPage.dart';
import 'Skills/ListTile.dart';

class FavListView extends StatefulWidget {
  final double height;

  const FavListView({super.key, required this.height});

  @override
  State<StatefulWidget> createState() => FavListViewState();
}

class FavListViewState extends State<FavListView> {
  Widget separator(String text) {
    return Row(
        children: <Widget>[
          SizedBox(width: text.isNotEmpty ? 5 : 25),
          const Expanded(
              child: Divider()
          ),
          if (text.isNotEmpty)
            const SizedBox(width: 5),
          if (text.isNotEmpty)
            Container(
              width: text.length*10,
              height: 30,
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: const Color.fromARGB(200, 173, 79, 9),
                borderRadius: BorderRadius.circular(15.0),
                border: Border.all(
                  color: const Color.fromARGB(255, 173, 79, 9),
                  width: 2.0,
                ),
              ),
              child: Center(child:Text(text)),
            ),
          if (text.isNotEmpty)
            const SizedBox(width: 5),
          const Expanded(
              child: Divider()
          ),
          SizedBox(width: text.isNotEmpty ? 5 : 25),
        ]
    );
  }

  List<dynamic> datas = [];

  List<String> cats = ["All", 'Monsters', 'Quests', 'Genes', 'Skills'];
  String dropdownvalue = "All";

  @override
  void initState() {
    super.initState();
  }

  Color getMonsterColor(dynamic monster) {
    String attr = monster["loots"][0]["color"];

    if (attr == "Black") {
      return const Color.fromARGB(255, 78, 78, 78);
    }
    if (attr == "White") {
      return const Color.fromARGB(255, 255, 255, 255);
    }
    if (attr == "Light Teal") {
      return const Color.fromARGB(255, 172, 228, 207);
    }
    if (attr == "Teal") {
      return const Color.fromARGB(255, 88, 234, 199);
    }
    if (attr == "Light Blue") {
      return const Color.fromARGB(255, 155, 243, 255);
    }
    if (attr == "Powder Blue") {
      return const Color.fromARGB(255, 160, 196, 232);
    }
    if (attr == "Blue") {
      return const Color.fromARGB(255, 91, 173, 255);
    }
    if (attr == "Dark Blue") {
      return const Color.fromARGB(255, 5, 60, 184);
    }
    if (attr == "Magenta") {
      return const Color.fromARGB(255, 255, 0, 212);
    }
    if (attr == "Purple") {
      return const Color.fromARGB(255, 165, 65, 226);
    }
    if (attr == "Dark Purple") {
      return const Color.fromARGB(255, 95, 18, 120);
    }
    if (attr == "Pink") {
      return const Color.fromARGB(255, 244, 112, 187);
    }
    if (attr == "Dark Pink") {
      return const Color.fromARGB(255, 229, 26, 97);
    }
    if (attr == "Red") {
      return const Color.fromARGB(255, 254, 74, 13);
    }
    if (attr == "Dark Red") {
      return const Color.fromARGB(255, 187, 33, 12);
    }
    if (attr == "Orange") {
      return const Color.fromARGB(255, 254, 179, 88);
    }
    if (attr == "Dark Orange") {
      return const Color.fromARGB(255, 255, 115, 17);
    }
    if (attr == "Light Yellow") {
      return const Color.fromARGB(255, 252, 252, 118);
    }
    if (attr == "Yellow") {
      return const Color.fromARGB(255, 246, 208, 5);
    }
    if (attr == "Dark Yellow") {
      return const Color.fromARGB(255, 206, 150, 14);
    }
    if (attr == "Gold") {
      return const Color.fromARGB(255, 255, 232, 0);
    }
    if (attr == "Light Green") {
      return const Color.fromARGB(255, 163, 204, 63);
    }
    if (attr == "Green") {
      return const Color.fromARGB(255, 38, 255, 150);
    }
    if (attr == "Dark Green") {
      return const Color.fromARGB(255, 43, 95, 8);
    }
    if (attr == "Light Brown") {
      return const Color.fromARGB(255, 149, 118, 71);
    }
    if (attr == "Brown") {
      return const Color.fromARGB(255, 82, 53, 22);
    }
    if (attr == "Grey") {
      return const Color.fromARGB(255, 173, 173, 173);
    }
    else {
      return const Color.fromARGB(255, 255, 255, 255);
    }
  }

  Color getQuestColor(dynamic quest) {
    return quest["Target"].contains("Slay")
        ? const Color.fromARGB(200, 255, 0, 0)
        : const Color.fromARGB(200, 0, 0, 255);
  }

  Color getGeneColor(dynamic gene) {
    return gene["Element"] == "Fire"
        ? const Color.fromARGB(200, 255, 0, 0)
        : gene["Element"] == "Water"
        ? const Color.fromARGB(200, 0, 100, 255)
        : gene["Element"] == "Thunder"
        ? const Color.fromARGB(200, 255, 255, 100)
        : gene["Element"] == "Ice"
        ? const Color.fromARGB(200, 100, 200, 255)
        : gene["Element"] == "Dragon"
        ? const Color.fromARGB(200, 70, 50, 255)
        : const Color.fromARGB(200, 255, 255, 255);
  }

  Color getSkillColor(dynamic skill) {
    return skill["Category"] == 'Passive'
        ? const Color.fromARGB(200, 144, 238, 144)
        : skill["Category"] == 'Active'
        ? const Color.fromARGB(200, 255, 165, 0)
        : skill["Category"] == 'HP Recovery'
        ? const Color.fromARGB(200, 0, 128, 0)
        : skill["Category"] == 'Status Recovery'
        ? const Color.fromARGB(200, 173, 216, 230)
        : skill["Category"] == 'Status Reduction'
        ? const Color.fromARGB(200, 255, 0, 0)
        : skill["Category"] == 'Buffs'
        ? const Color.fromARGB(200, 255, 215, 0)
        : skill["Category"] == 'Status Inflict'
        ? const Color.fromARGB(200, 128, 0, 128)
        : const Color.fromARGB(200, 255, 255, 255);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          DropdownButton(
            value: dropdownvalue,
            icon: const Icon(Icons.keyboard_arrow_down),
            items: cats.map((String item) {
              return DropdownMenuItem(
                value: item,
                child: Text(item),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                dropdownvalue = newValue!;
                datas = DataClass().updateFavorites(dropdownvalue);
                setState(() {});
              });
            },
          ),

          separator(""),

          SizedBox(
            height: MediaQuery.of(context).size.height-widget.height-100,
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.all(5.0),
              itemCount: datas.length,
              itemBuilder: (BuildContext context, int index) {
                dynamic obj = datas[index];
                bool fav = true;
                return Container(
                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      color: obj["egg"] != null ? getMonsterColor(obj)
                          : obj["Title"] != null ? getQuestColor(obj)
                          : obj["Skill"] != null ? getGeneColor(obj)
                          : getSkillColor(obj),
                      width: 2.0,
                    ),
                  ),
                  child: InkWell(
                    onTap: () async {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              obj["egg"] != null ? MonsterDetailPage(monster: obj, favorite: fav)
                            : obj["Title"] != null ? QuestDetailPage(quest: obj, favorite: fav)
                            : obj["Skill"] != null ? GeneDetailPage(gene: obj, favorite: fav)
                            : SkillDetailPage(skill: obj, favorite: fav)
                        ),
                      ).then((_) => setState(() {}));
                    },
                    child: obj["egg"] != null ? MonsterListTile(monster: obj, favorite: fav)
                        : obj["Title"] != null ? QuestListTile(quest: obj, favorite: fav)
                        : obj["Skill"] != null ? GeneListTile(gene: obj, favorite: fav)
                        : SkillListTile(skill: obj, favorite: fav)
                  ),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(
                height: 10,
              ),
            ),
          )
        ],
      ),
    );
  }
}