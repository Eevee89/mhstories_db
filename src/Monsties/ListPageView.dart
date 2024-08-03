import 'package:flutter/material.dart';
import '../DataBase.dart';
import 'DetailPage.dart';
import '../DataClass.dart';
import 'ListTile.dart';

class MonstiesListView extends StatefulWidget {
  final double height;

  const MonstiesListView({super.key, required this.height});

  @override
  State<MonstiesListView> createState() => MonstiesListViewState();
}

class MonstiesListViewState extends State<MonstiesListView> {
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
  TextEditingController textController = TextEditingController();
  String filter = "";

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 6),
          SizedBox(
            width: 2*MediaQuery.of(context).size.width/3,
            height: 40,
            child: TextFormField(
              controller: textController,
              onChanged: (text) {
                filter = text;
                DataClass().searchMonsters(filter.toLowerCase());
                setState(() {});
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Rechercher...",
              ),
            ),
          ),

          separator(""),

          SizedBox(
            height: MediaQuery.of(context).size.height-widget.height-100,
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.all(5.0),
              itemCount: DataClass().displayedM.length,
              itemBuilder: (BuildContext context, int index) {
                dynamic monster = DataClass().displayedM[index];
                bool fav = DataBase().isFav(monster["id"], "Monster");
                return Container(
                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      color: fromAttribute(monster["loots"][0]["color"]),
                      width: 2.0,
                    ),
                  ),
                  child: InkWell(
                    onTap: () async {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => MonsterDetailPage(
                              monster: monster,
                              favorite: fav
                          ),
                        ),
                      ).then((_) => setState(() {}));
                    },
                    child: MonsterListTile(
                        monster: monster,
                        favorite: fav
                    ),
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

  Color fromAttribute(String attr) {
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
}