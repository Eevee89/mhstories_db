import 'package:flutter/material.dart';

class MonsterListTile extends StatefulWidget {
  final dynamic monster;
  final bool favorite;

  const MonsterListTile({super.key, required this.monster, required this.favorite});

  @override
  State<MonsterListTile> createState() => MonsterListTileState();
}

class MonsterListTileState extends State<MonsterListTile> {
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

  dynamic txt = {
    "speed": const Color.fromARGB(255, 255, 255, 0),
    "power": const Color.fromARGB(255, 0, 255, 255),
    "technical": const Color.fromARGB(255, 255, 0, 255)
  };

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(width: 6),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widget.monster["icone"] != "")
              SizedBox(
                  width: 50,
                  height: 50,
                  child: Image.network("https://tiermaker.com/images/template_images/2022/15806321/monster-hunter-stories-1-monsties-15806321/${widget.monster["icone"]}")
              )
            else
              SizedBox(
                  width: 50,
                  height: 50,
                  child: Image.asset("assets/Unknown_icon.png")
              )
          ],
        ),
        Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text("\u2605${widget.monster["stars"]}"),
                    Text(
                      widget.monster["en"],
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
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
                          child: Text(
                              "Peut éclore",
                              style: TextStyle(color: txt[widget.monster["attack"]["type"]],)
                          )
                      ),
                    if (!widget.monster["has_egg"])
                      Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: Colors.white30,
                            borderRadius: BorderRadius.circular(15.0),
                            border: Border.all(
                              color: Colors.white38,
                              width: 2.0,
                            ),
                          ),
                          child: const Text(
                              "Peut éclore",
                              style: TextStyle(
                                color: Colors.white,
                                decoration: TextDecoration.lineThrough
                              )
                          )
                      ),

                    if (widget.favorite)
                      const SizedBox(
                          width: 30,
                          child: Icon(Icons.favorite, color: Colors.red,)
                      ),
                    if (!widget.favorite)
                      const SizedBox(
                      width: 30,
                      child: Icon(Icons.favorite_border, color: Colors.red,)
                      ),

                    if (widget.monster["attack"]["type"] != "Unknown")
                      SizedBox(
                        width: 30,
                        child: Image.asset("assets/${widget.monster["attack"]["type"]}_icon.png")
                    ),
                    if (widget.monster["attack"]["type"] == "Unknown")
                      const SizedBox(
                          width: 30,
                          child: Icon(Icons.question_mark, color: Colors.purpleAccent,)
                      ),
                  ],
                )
              ],
            ),
        )
      ],
    );
  }

}