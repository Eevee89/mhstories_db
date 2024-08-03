import 'package:flutter/material.dart';

class GeneListTile extends StatefulWidget {
  final dynamic gene;
  final bool favorite;

  const GeneListTile({super.key, required this.gene, required this.favorite});

  @override
  State<GeneListTile> createState() => GeneListTileState();
}

class GeneListTileState extends State<GeneListTile> {
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
              Text(
                widget.gene["Name"],
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              Text(widget.gene["Skill"])
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