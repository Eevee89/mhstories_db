import 'package:flutter/material.dart';
import '../DataBase.dart';
import 'DetailPage.dart';
import '../DataClass.dart';
import 'ListTile.dart';

class QuestsListView extends StatefulWidget {
  final double height;

  const QuestsListView({super.key, required this.height});

  @override
  State<QuestsListView> createState() => QuestsListViewState();
}

class QuestsListViewState extends State<QuestsListView> {
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
  List<String> cats = ["Quest types", "Slay", "Deliver"];
  String dropdownvalue = "Quest types";

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width/2,
                height: 40,
                child: TextFormField(
                  controller: textController,
                  onChanged: (text) {
                    filter = text;
                    DataClass().searchQuests(filter.toLowerCase(), dropdownvalue);
                    setState(() {});
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Rechercher...",
                  ),
                ),
              ),
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
                    DataClass().searchQuests(filter.toLowerCase(), dropdownvalue);
                  });
                },
              ),
            ],
          ),

          separator(""),

          SizedBox(
            height: MediaQuery.of(context).size.height-widget.height-100,
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.all(5.0),
              itemCount: DataClass().displayedQ.length,
              itemBuilder: (BuildContext context, int index) {
                dynamic quest = DataClass().displayedQ[index];
                bool fav = DataBase().isFav(quest["id"], "Quest");
                return Container(
                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      color: quest["Target"].contains("Slay")
                        ? const Color.fromARGB(200, 255, 0, 0)
                        : const Color.fromARGB(200, 0, 0, 255),
                      width: 2.0,
                    ),
                  ),
                  child: InkWell(
                    onTap: () async {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => QuestDetailPage(
                              quest: quest,
                              favorite: fav
                          ),
                        ),
                      ).then((_) => setState(() {}));
                    },
                    child: QuestListTile(
                        quest: quest,
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
}