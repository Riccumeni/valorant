import 'package:flutter/material.dart';

class Ability extends StatefulWidget {
  final image_url;
  final keyAbility;
  final Color? color_icon;
  final Function onClick;
  final String actualKey;

  const Ability({Key? key, required this.image_url, required this.keyAbility, this.color_icon, required this.onClick, required this.actualKey}) : super(key: key);

  @override
  State<Ability> createState() => _AbilityState();
}

class _AbilityState extends State<Ability> {
  late Color _color;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        widget.onClick(widget.keyAbility);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Container(margin: EdgeInsets.only(top: 20),
                child: Image(width: 40,
                  height: 40,
                  image: NetworkImage(widget.image_url),
                  color: widget.color_icon,)),
            Container(margin: EdgeInsets.only(top: 20),
                child: Text(widget.keyAbility, style: TextStyle(
                    fontSize: 20, fontFamily: 'valorant', color: widget.color_icon,),)),
            Container(
              color: widget.color_icon,
              margin: const EdgeInsets.only(top: 20, bottom: 20),
              child: const SizedBox(width: 31, height: 5,),
            )
          ],
        ),
      ),
    );
  }
}


// _champ["abilities"][0]["displayIcon"]
