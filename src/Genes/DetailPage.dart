import 'package:flutter/material.dart';
import 'package:mhstories/DataBase.dart';
import '../main.dart';

class GeneDetailPage extends StatefulWidget {
  final dynamic gene;
  final bool favorite;

  const GeneDetailPage({super.key, required this.gene, required this.favorite});

  @override
  State<GeneDetailPage> createState() => GeneDetailPageState();

}

class GeneDetailPageState extends State<GeneDetailPage> {
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
          Text(widget.gene[key]),
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
                            "N° ${widget.gene["id"]+1}",
                            style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)
                        )
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                      widget.gene["Name"],
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15
                      )
                  )
                ],
              ),
          ),
          SizedBox(
            width: 30,
            child: InkWell(
              onTap: () async {
                isFav = !isFav;
                await DataBase().toggleFav(widget.gene["id"], "Gene");
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
      const SizedBox(height: 10),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(width: 5),
          const Expanded(
            child: Text("Type"),
          ),
          if (widget.gene["Type"] != "No-type")
            SizedBox(
              width: 30,
              child: Image.asset("assets/${widget.gene["Type"].toLowerCase()}_icon.png")
            ),
          if (widget.gene["Type"] == "No-type")
            const SizedBox(
              width: 30,
              child: Icon(Icons.not_interested, color: Colors.purpleAccent,)
            ),
          const SizedBox(width: 5),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(width: 5),
          const Expanded(
            child: Text("Element"),
          ),
          if (widget.gene["Element"] != "Non-Elem")
            SizedBox(
                width: 30,
                child: Image.asset("assets/${widget.gene["Element"].toLowerCase()}_icon.png")
            ),
          if (widget.gene["Element"] == "Non-Elem")
            const SizedBox(
                width: 30,
                child: Icon(Icons.not_interested, color: Colors.purpleAccent,)
            ),
          const SizedBox(width: 5),
        ],
      ),

      const SizedBox(height: 15),

      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(width: 10),
          const Expanded(child: Text("Skill")),
          Text(widget.gene["Skill"]),
          const SizedBox(width: 10),
        ],
      ),

      const SizedBox(height: 10),

      const Text("Effects"),
      for(String effect in widget.gene["Effects"])
        Text(effect),

      if (widget.gene["Monsties"] != [])
        const SizedBox(height: 15,),
      if (widget.gene["Monsties"] != [])
        separator("Monsties"),
      if (widget.gene["Monsties"] != [])
        const SizedBox(height: 10),
      if (widget.gene["Monsties"] != [])
        for(String monstie in widget.gene["Monsties"])
          Text(monstie),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.gene["Name"]),
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