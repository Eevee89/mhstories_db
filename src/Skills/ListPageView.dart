import 'package:flutter/material.dart';
import '../DataBase.dart';
import 'DetailPage.dart';
import '../DataClass.dart';
import 'ListTile.dart';

class SkillsListView extends StatefulWidget {
  final double height;

  const SkillsListView({super.key, required this.height});

  @override
  State<SkillsListView> createState() => SkillsListViewState();
}

class SkillsListViewState extends State<SkillsListView> {
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
  List<String> cats = ["Categories", 'Passive', 'Active', 'HP Recovery', 'Status Recovery', 'Status Reduction', 'Buffs', 'Status Inflict'];
  String dropdownvalue = "Categories";

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
                    DataClass().searchSkills(filter.toLowerCase(), dropdownvalue);
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
                    DataClass().searchSkills(filter.toLowerCase(), dropdownvalue);
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
              itemCount: DataClass().displayedS.length,
              itemBuilder: (BuildContext context, int index) {
                dynamic skill = DataClass().displayedS[index];
                bool fav = DataBase().isFav(skill["id"], "Skill");
                return Container(
                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(
                      color: skill["Category"] == 'Passive'
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
                          : const Color.fromARGB(200, 255, 255, 255),
                      width: 2.0,
                    ),
                  ),
                  child: InkWell(
                    onTap: () async {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => SkillDetailPage(
                              skill: skill,
                              favorite: fav
                          ),
                        ),
                      ).then((_) => setState(() {}));
                    },
                    child: SkillListTile(
                        skill: skill,
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