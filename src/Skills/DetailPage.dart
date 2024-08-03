import 'package:flutter/material.dart';
import 'package:mhstories/DataBase.dart';
import '../main.dart';

class SkillDetailPage extends StatefulWidget {
  final dynamic skill;
  final bool favorite;

  const SkillDetailPage({super.key, required this.skill, required this.favorite});

  @override
  State<SkillDetailPage> createState() => SkillDetailPageState();

}

class SkillDetailPageState extends State<SkillDetailPage> {
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
          Text("${widget.skill[key]}"),
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
                            "N° ${widget.skill["id"]+1}",
                            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)
                        )
                    ),
                  ),
                  const SizedBox(width: 5),
                  Container(
                    width: 150,
                    height: 30,
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: widget.skill["Category"] == 'Passive'
                          ? const Color.fromARGB(200, 144, 238, 144)
                          : widget.skill["Category"] == 'Active'
                          ? const Color.fromARGB(200, 255, 165, 0)
                          : widget.skill["Category"] == 'HP Recovery'
                          ? const Color.fromARGB(200, 0, 128, 0)
                          : widget.skill["Category"] == 'Status Recovery'
                          ? const Color.fromARGB(200, 173, 216, 230)
                          : widget.skill["Category"] == 'Status Reduction'
                          ? const Color.fromARGB(200, 255, 0, 0)
                          : widget.skill["Category"] == 'Buffs'
                          ? const Color.fromARGB(200, 255, 215, 0)
                          : widget.skill["Category"] == 'Status Inflict'
                          ? const Color.fromARGB(200, 128, 0, 128)
                          : const Color.fromARGB(200, 255, 255, 255),
                      borderRadius: BorderRadius.circular(15.0),
                      border: Border.all(
                        color: widget.skill["Category"] == 'Passive'
                            ? const Color.fromARGB(255, 144, 238, 144)
                            : widget.skill["Category"] == 'Active'
                            ? const Color.fromARGB(255, 255, 165, 0)
                            : widget.skill["Category"] == 'HP Recovery'
                            ? const Color.fromARGB(255, 0, 128, 0)
                            : widget.skill["Category"] == 'Status Recovery'
                            ? const Color.fromARGB(255, 173, 216, 230)
                            : widget.skill["Category"] == 'Status Reduction'
                            ? const Color.fromARGB(255, 255, 0, 0)
                            : widget.skill["Category"] == 'Buffs'
                            ? const Color.fromARGB(255, 255, 215, 0)
                            : widget.skill["Category"] == 'Status Inflict'
                            ? const Color.fromARGB(255, 128, 0, 128)
                            : const Color.fromARGB(255, 255, 255, 255),
                        width: 2.0,
                      ),
                    ),
                    child: Center(
                        child: Text(
                            widget.skill["Category"],
                            style: const TextStyle(fontWeight: FontWeight.bold)
                        )
                    ),
                  ),
                  const SizedBox(width: 5),
                  Container(
                    width: 100,
                    height: 30,
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(200, 255, 255, 255),
                      borderRadius: BorderRadius.circular(15.0),
                      border: Border.all(
                        color: const Color.fromARGB(255, 255, 255, 255),
                        width: 2.0,
                      ),
                    ),
                    child: Center(
                        child: Text(
                            widget.skill["Kinship Gauge"].split(" ")[2],
                            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)
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
                await DataBase().toggleFav(widget.skill["id"], "Skill");
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

    widgets += line("Name");
    widgets.add(const Text("Description",),);
    widgets.add(
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width - 10,
            child: Text("${widget.skill["Desc"]}", textAlign: TextAlign.center,),
          )
        ],
      )
    );
    for (String key in ["Motion Value", "Action Speed", "Effect"]) {
      widgets += line(key);
    }

    widgets += [
      const SizedBox(height: 15,),
      separator("Genes"),
      const SizedBox(height: 10),
      //#region Information
      for(String gene in widget.skill["Genes"])
        Text(gene),
    ];

    widgets += [
      const SizedBox(height: 15,),
      separator("Monsties"),
      const SizedBox(height: 10),
      //#region Information
      for(String monstie in widget.skill["Monsties"])
        Text(monstie),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.skill["Name"]),
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