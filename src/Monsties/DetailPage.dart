import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mhstories/DataBase.dart';

import '../main.dart';

class MonsterDetailPage extends StatefulWidget {
  final dynamic monster;
  final bool favorite;

  const MonsterDetailPage({super.key, required this.monster, required this.favorite});

  @override
  State<StatefulWidget> createState() => MonsterDetailPageState();

}

class MonsterDetailPageState extends State<MonsterDetailPage> {
  dynamic bgc = {
    "speed": const Color.fromARGB(255, 0, 100, 255),
    "power": const Color.fromARGB(255, 255, 0, 100),
    "technical": const Color.fromARGB(255, 100, 255, 0)
  };

  dynamic bdc = {
    "speed": const Color.fromARGB(200, 0, 0, 255),
    "power": const Color.fromARGB(200, 255, 0, 0),
    "technical": const Color.fromARGB(200, 0, 255, 0)
  };

  dynamic genes = {
    "Normal": const Color.fromARGB(200, 0, 0, 255),
    "Rare": const Color.fromARGB(200, 255, 0, 0),
    "Fixed": const Color.fromARGB(200, 0, 255, 0)
  };

  late bool isFav;

  String url = "https://tiermaker.com/images/template_images/2022/15806321/monster-hunter-stories-1-monsties-15806321/";

  @override
  void initState() {
    isFav = widget.favorite;
    super.initState();
  }

  List<String> colors = [
    "Black", "White", "Light Teal", "Teal", "Light Blue", "Powder Blue", "Blue", "Dark Blue", "Magenta", "Purple", "Dark Purple",
    "Pink", "Dark Pink", "Red", "Dark Red", "Orange", "Dark Orange", "Light Yellow", "Yellow", "Dark Yellow", "Gold", "Light Green",
    "Green", "Dark Green", "Light Brown", "Brown", "Grey"
  ];

  int highRank = 0;

  Color getColorFromText(String rgbString) {
    final rgbValues = rgbString.substring(1, rgbString.length - 1);
    final rgbList = rgbValues.split(',').map(int.parse).toList();

    final r = rgbList[0];
    final g = rgbList[1];
    final b = rgbList[2];

    return Color.fromARGB(255, r, g, b);
  }

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

  Widget elements(List<dynamic> elements) {
    List<Widget> widgets = [];
    for (var elt in elements) {
      if (elt != "Unknown") {
        widgets.add(
            SizedBox(
                width: 30,
                height: 30,
                child: elt != ""
                    ? Image.asset("assets/${elt}_icon.png")
                    : SvgPicture.asset(
                  "assets/noelt.svg",
                  colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.inversePrimary, BlendMode.modulate),
                )
            )
        );
      }
      else {
        widgets.add(
          const SizedBox(
              width: 30,
              child: Icon(Icons.question_mark, color: Colors.purpleAccent,)
          ),
        );
      }
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: widgets,
    );
  }

  Widget attackType(String attack) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        if (attack != "Unknown")
          SizedBox(
            width: 30,
            child: Image.asset("assets/${attack}_icon.png")
          ),
        if (attack == "Unknown")
          const SizedBox(
              width: 30,
              child: Icon(Icons.question_mark, color: Colors.purpleAccent,)
          ),

        const SizedBox(width: 5),
        const Text("(\u2713"),

        if (attack != "Unknown")
          SizedBox(
              width: 30,
              child: attack == "speed"
                  ? Image.asset("assets/technical_icon.png")
                  : attack == "power"
                  ? Image.asset("assets/speed_icon.png")
                  : Image.asset("assets/power_icon.png")
          ),
        if (attack == "Unknown")
          const SizedBox(
              width: 30,
              child: Icon(Icons.question_mark, color: Colors.purpleAccent,)
          ),

        const Text(")")
      ],
    );
  }

  Widget loots(List<dynamic> loots) {
    List<Widget> widgets = [];
    for (dynamic loot in loots) {
      widgets.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(width: 5),
            Expanded(
              child: Text(loot["name"]),
            ),
            SizedBox(
                width: 40,
                height: 40,
                child: SvgPicture.asset(
                  loot["icone"] != "monster part"
                      ? "assets/${loot["icone"]}_icon.svg"
                      : "assets/monster_part_icon.svg",
                  colorFilter: ColorFilter.mode(fromAttribute(loot["color"]), BlendMode.modulate),
                )
            ),
            const SizedBox(width: 5),
          ],
        )
      );
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: widgets,
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> widgets = [
      const SizedBox(height: 15,),
      separator("Infos"),
      const SizedBox(height: 10),
      //#region Information
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(width: 5),
          Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(width: 5),
                  Container(
                    width: 70,
                    height: 30,
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(200, 255, 255, 255),
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        width: 2.0,
                      ),
                    ),
                    child: Center(
                        child: Text(
                            "N° ${widget.monster["id"]}",
                            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)
                        )
                    ),
                  ),
                  const SizedBox(width: 5),
                  Container(
                    width: 40,
                    height: 30,
                    padding: const EdgeInsets.all(2),
                    child: Center(
                        child: Text(
                            "\u2605${widget.monster["stars"]}",
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)
                        )
                    ),
                  ),

                  if (widget.monster["has_egg"])
                    Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: bgc[widget.monster["attack"]["type"]],
                          borderRadius: BorderRadius.circular(15.0),
                          border: Border.all(
                            color: bdc[widget.monster["attack"]["type"]],
                            width: 2.0,
                          ),
                        ),
                        child: const Text("Peut éclore")
                    )
                ],
              ),
          ),
          SizedBox(
            width: 30,
            child: InkWell(
              onTap: () async {
                isFav = !isFav;
                await DataBase().toggleFav(widget.monster["id"], "Monster");
                setState(() {});
              },
              child: isFav
                  ? const Icon(Icons.favorite, color: Colors.red,)
                  : const Icon(Icons.favorite_border, color: Colors.red,)
            )
          ),
          const SizedBox(width: 5),
        ],
      ),

      const SizedBox(height: 15),

      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (widget.monster["icone"] != "")
            SizedBox(
                width: 100,
                height: 100,
                child: Image.network(
                  url+widget.monster["icone"],
                  fit: BoxFit.cover
                )
            )
          else
            SizedBox(
                width: 100,
                height: 100,
                child: Image.asset("assets/Unknown_icon.png")
            )
        ],
      ),

      const SizedBox(height: 15),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(width: 5),
          const Expanded(child: Text("Nom anglais")),
          Text(widget.monster["en"]),
          const SizedBox(width: 5),
        ],
      ),

      const SizedBox(height: 15),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(width: 5),
          Expanded(
              child: Text(
                  widget.monster["attack"]["elements"].length <= 1
                      ? "État d'attaque"
                      : "États d'attaque"
              )
          ),
          elements(widget.monster["attack"]["elements"]),
          const SizedBox(width: 5),
        ],
      ),

      const SizedBox(height: 15),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(width: 5),
          Expanded(
              child: Text(
                  widget.monster["weakness"].length <= 1
                      ? "Faiblesse"
                      : "Faiblesses"
              )
          ),
          elements(widget.monster["weakness"]),
          const SizedBox(width: 5),
        ],
      ),

      //#endregion

      const SizedBox(height: 15,),
      separator("Bataille"),
      const SizedBox(height: 10),

      //#region Bataille
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(width: 5),
          const Expanded(
              child: Text("Types d'attaque")
          ),
          attackType(widget.monster["attack"]["type"]),
          const SizedBox(width: 5),
        ],
      ),

      const SizedBox(height: 5),
      separator(""),
      const SizedBox(height: 5),

      const Text("Matériaux"),
      loots(widget.monster["loots"]),
      //#endregion

      const SizedBox(height: 15,),
      separator("Répart. géo."),
      const SizedBox(height: 10),

      //#region Geographie

      const Text("Cartes"),
      for (String map in widget.monster["maps"])
        Text(map),

      const SizedBox(height: 5),
      separator(""),
      const SizedBox(height: 5),

      const Text("Quêtes"),
      for (dynamic quest in widget.monster["quests"])
        Text("(\u2605${quest["stars"]}) ${quest["type"]} | ${quest["name"]}"),

      //#endregion

      const SizedBox(height: 15,),
    ];

    //#region Monstie
    if (widget.monster["has_egg"]) {
      widgets.add(separator("Monstie"),);
      widgets.add(const SizedBox(height: 10,),);
      widgets += monstie();
    }
    //#endregion

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.monster["en"]),
        actions: [
          SizedBox(
            width: 20,
            child: InkWell(
              onTap: (){
                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (BuildContext context){
                  return const MyHomePage(title: 'MH Stories DataBase',);
                }), (r){
                  return false;
                });
              },
              child: const Icon(Icons.home)
            )
          ),
          const SizedBox(width: 10)
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: widgets,
          )
        )
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

  List<Widget> monstie() {
    return [
      //#region Information
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: 80,
            height: 80,
            child: CircleAvatar(
              backgroundColor: getColorFromText(widget.monster["egg"]["colors"][0]),
              radius: 40,
              child: ClipOval(
                child: Image.network(widget.monster["egg"]["icones"][0]),
              ),
            ),
          ),
          SizedBox(
            width: 80,
            height: 80,
            child: CircleAvatar(
              backgroundColor: getColorFromText(widget.monster["egg"]["colors"][0]),
              radius: 40,
              child: ClipOval(
                child: Image.network(widget.monster["egg"]["icones"][1]),
              ),
            ),
          ),
          SizedBox(
            width: 80,
            height: 80,
            child: CircleAvatar(
              backgroundColor: getColorFromText(widget.monster["egg"]["colors"][1]),
              radius: 40,
              child: ClipOval(
                child: Image.network(widget.monster["egg"]["icones"][0]),
              ),
            ),
          ),
          SizedBox(
            width: 80,
            height: 80,
            child: CircleAvatar(
              backgroundColor: getColorFromText(widget.monster["egg"]["colors"][1]),
              radius: 40,
              child: ClipOval(
                child: Image.network(widget.monster["egg"]["icones"][1]),
              ),
            ),
          ),
        ],
      ),

      const SizedBox(height: 15),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(width: 5),
          const Expanded(child: Text("Croissance")),
          Text(widget.monster["egg"]["growth"]),
          const SizedBox(width: 5),
        ],
      ),
      const SizedBox(height: 15),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(width: 5),
          const Expanded(child: Text("Type d'attaque")),
          SizedBox(
              width: 30,
              child: Image.asset("assets/${widget.monster["egg"]["attack_type"]}_icon.png")
          ),
          const SizedBox(width: 5),
        ],
      ),
      const SizedBox(height: 5),
      separator(""),
      const SizedBox(height: 5),

      const Text("Gènes"),
      for (dynamic gene in widget.monster["egg"]["genes"])
        Text(gene["name"],
            style: TextStyle(
              color: gene["rarity"] == "Fixed"
                  ? bgc["technical"]
                  : gene["rarity"] == "Normal"
                  ? bgc["speed"]
                  : gene["rarity"] == "Rare"
                  ? bgc["power"]
                  : null
            )
        ),

      const SizedBox(height: 5),
      separator(""),
      const SizedBox(height: 5),

      const Text("Skills"),
      for (dynamic skill in widget.monster["egg"]["skills"])
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(width: 5),
            Expanded(
              child: Text("${skill["level"]} : "),
            ),
            Text(skill["name"]),
            const SizedBox(width: 5),
          ]
        ),

      const SizedBox(height: 5),
      separator(""),
      const SizedBox(height: 5),

      const Text("Stats de base"),
      const SizedBox(height: 15),
      const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(width: 5),
          Text("Elt"),
          Text("État d'attaque"),
          SizedBox(width: 5),
          Text("Défense"),
          SizedBox(width: 5),
        ],
      ),
      const SizedBox(height: 15),
      const SizedBox(height: 5),
      atkDef("fire"),
      const SizedBox(height: 5),
      atkDef("water"),
      const SizedBox(height: 5),
      atkDef("thunder"),
      const SizedBox(height: 5),
      atkDef("ice"),
      const SizedBox(height: 5),
      atkDef("dragon"),
      const SizedBox(height: 15),
      separator(""),
      const SizedBox(height: 5),
      //#endregion
    ];
  }

  Widget stats(int stat) {
    List<Widget> widgets = [];
    if (stat == 0) {
      for(int i=0; i<5; i++) {
        widgets.add(
            Container(
                width: 10,
                height: 10,
                color: Colors.white12
            )
        );
        widgets.add(const SizedBox(width:2));
      }
      widgets.add(
          Container(
              width: 10,
              height: 10,
              color: Colors.blue
          )
      );
      widgets.add(const SizedBox(width:2));
      for(int i=0; i<4; i++) {
        widgets.add(
            Container(
                width: 10,
                height: 10,
                color: Colors.white12
            )
        );
        widgets.add(const SizedBox(width:2));
      }
      widgets.add(
          Container(
              width: 10,
              height: 10,
              color: Colors.white12
          )
      );
    }
    else if (stat > 0) {
      for(int i=0; i<5; i++) {
        widgets.add(
            Container(
                width: 10,
                height: 10,
                color: Colors.white12
            )
        );
        widgets.add(const SizedBox(width:2));
      }
      widgets.add(
          Container(
              width: 10,
              height: 10,
              color: Colors.blue
          )
      );
      widgets.add(const SizedBox(width:2));
      for(int i=0; i<4; i++) {
        widgets.add(
            Container(
                width: 10,
                height: 10,
                color: i<stat ? Colors.green : Colors.white12
            )
        );
        widgets.add(const SizedBox(width:2));
      }
      widgets.add(
          Container(
              width: 10,
              height: 10,
              color: stat==5 ? Colors.green : Colors.white12
          )
      );
    }
    else {
      for(int i=5; i>0; i--) {
        widgets.add(
            Container(
                width: 10,
                height: 10,
                color: i<=-stat ? Colors.red : Colors.white12
            )
        );
        widgets.add(const SizedBox(width:2));
      }
      widgets.add(
          Container(
              width: 10,
              height: 10,
              color: Colors.blue
          )
      );
      widgets.add(const SizedBox(width:2));
      for(int i=0; i<4; i++) {
        widgets.add(
            Container(
                width: 10,
                height: 10,
                color: Colors.white12
            )
        );
        widgets.add(const SizedBox(width:2));
      }
      widgets.add(
          Container(
              width: 10,
              height: 10,
              color: Colors.white12
          )
      );
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: widgets,
    );
  }

  Widget atkDef(String elt) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(width: 5),
        SizedBox(
            width: 30,
            height: 30,
            child: Image.asset("assets/${elt}_icon.png")
        ),
        stats(widget.monster["egg"]["attack"][elt]),
        stats(widget.monster["egg"]["defense"][elt]),
        const SizedBox(width: 5),
      ],
    );
  }
}