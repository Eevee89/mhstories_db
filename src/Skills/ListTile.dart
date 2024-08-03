import 'package:flutter/material.dart';

class SkillListTile extends StatefulWidget {
  final dynamic skill;
  final bool favorite;

  const SkillListTile({super.key, required this.skill, required this.favorite});

  @override
  State<SkillListTile> createState() => SkillListTileState();
}

class SkillListTileState extends State<SkillListTile> {
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
              Text(widget.skill["Name"],
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              Text(widget.skill["Category"])
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