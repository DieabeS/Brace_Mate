import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../size.config.dart';

class SVGColorGrid extends StatelessWidget {
  final _colorMap = {
    'initial.#ff0000': Colors.transparent,
    'Red.#ff0000': Colors.red,
    'Green.#00FF00:': Colors.green,
    'Blue.#0000FF': Colors.blue,
    'Orange.#FFA500': Colors.orange,
    'Turquoise.#40E0D0': Colors.teal,
    'Purple.#FF00FF': Colors.purple,
    'Yellow.#FFFF19': Colors.yellow,
    'Grey.#808080': Colors.grey,
    'Black.#000000:': Colors.black,
    'White.#FFFFFF:black': Colors.white,
    'Black1.#000000:': Colors.black,
    'Bla2ck1.#000000:': Colors.black,
    //to add colors just replace the hex code with the wanted color then add the value to colorize the container in the grid
  };

  final Function(String) onColorSelected;

  SVGColorGrid({required this.onColorSelected});

  @override
  Widget build(BuildContext context) {
    return GridView(
      physics: BouncingScrollPhysics(),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: getProportionateScreenWidth(70),
          childAspectRatio: 1,
          crossAxisSpacing: getProportionateScreenWidth(3),
          mainAxisSpacing: getProportionateScreenWidth(3)),
      children: [
        ..._colorMap.entries.map((MapEntry<String, Color> mapEntry) {
          if (mapEntry.key == 'initial.#ff0000')
            return GestureDetector(
              onTap: () => onColorSelected("initial.#bdd4de"),
              child: Container(
                  height: getProportionateScreenWidth(100),
                  width: getProportionateScreenWidth(100),
                  margin: EdgeInsets.all(getProportionateScreenWidth(5)),
                  child: SvgPicture.asset('assets/ban-solid.svg')),
            );
          else
            return GestureDetector(
              onTap: () => onColorSelected(mapEntry.key),
              child: Container(
                height: getProportionateScreenWidth(100),
                width: getProportionateScreenWidth(100),
                margin: EdgeInsets.all(getProportionateScreenWidth(5)),
                decoration: BoxDecoration(
                    color: mapEntry.value,
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(getProportionateScreenWidth(5))),
              ),
            );
        })
      ],
    );
  }
}
