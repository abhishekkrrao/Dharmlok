import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class SlderCell extends StatelessWidget {
  const SlderCell(this.image);
  @required
  final String image;

  @override
  Widget build(BuildContext context) {
    return new Container(
      width: double.infinity,
      child: Image(
        image: AssetImage(image),
        height: 100.0,
        width: double.infinity,
        fit: BoxFit.fill,
      ),
    );
  }
}
