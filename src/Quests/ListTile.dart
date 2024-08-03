import 'package:flutter/material.dart';

class QuestListTile extends StatefulWidget {
  final dynamic quest;
  final bool favorite;

  const QuestListTile({super.key, required this.quest, required this.favorite});

  @override
  State<QuestListTile> createState() => QuestListTileState();
}

class QuestListTileState extends State<QuestListTile> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(width: 6),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("\u2605${widget.quest["Stars"]}"),
                  Text(
                    widget.quest["Title"],
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                ],
              ),
              Text(widget.quest["Target"])
            ],
          ),
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
      ],
    );
  }

}