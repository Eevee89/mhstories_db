import 'package:flutter/material.dart';
import 'package:mhstories/DataBase.dart';
import '../main.dart';

class QuestDetailPage extends StatefulWidget {
  final dynamic quest;
  final bool favorite;

  const QuestDetailPage({super.key, required this.quest, required this.favorite});

  @override
  State<StatefulWidget> createState() => QuestDetailPageState();

}

class QuestDetailPageState extends State<QuestDetailPage> {
  late bool isFav;

  String url = "https://tiermaker.com/images/template_images/2022/15806321/monster-hunter-stories-1-monsties-15806321/";

  @override
  void initState() {
    isFav = widget.favorite;
    super.initState();
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

  List<Widget> line(String key) {
    return  [
      const SizedBox(height: 15),

      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(width: 10),
          Expanded(child: Text(key)),
          Text(widget.quest[key]),
          const SizedBox(width: 10),
        ],
      ),
    ];
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
                            "N° ${widget.quest["id"]+1}",
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
                            "\u2605${widget.quest["Stars"]}",
                            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)
                        )
                    ),
                  ),
                ],
              ),
          ),
          SizedBox(
            width: 30,
            child: InkWell(
              onTap: () async {
                isFav = !isFav;
                await DataBase().toggleFav(widget.quest["id"], "Quest");
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
    ];

    for (String key in ["Title","Target","Locale","Reward","Zenny","EXP"]) {
      widgets += line(key);
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.quest["Title"]),
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
}