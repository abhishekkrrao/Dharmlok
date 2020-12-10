import 'package:dharmlok/model/model.dart';
import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' show Vector3;

class DialogPage extends StatefulWidget {
  DialogPage(this.thumbnailUrl);

  @required
  String thumbnailUrl;

  @override
  DialogPageState createState() => DialogPageState();
}

class DialogPageState extends State<DialogPage> {
  double _scale = 1.0;
  double _previousScale = 1.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.85),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(
              Icons.clear,
              color: Colors.indigo,
              size: 34,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
      backgroundColor: Colors.white.withOpacity(0.85),
      // this is the main reason of transparency at next screen. I am ignoring rest implementation but what i have achieved is you can see.
      body: Container(
        child: Center(
          child: GestureDetector(
            onTap: () {},
            onScaleStart: (ScaleStartDetails details) {
              print(details);
              _previousScale = _scale;
              setState(() {
                _previousScale = _scale;
              });
            },
            onScaleUpdate: (ScaleUpdateDetails details) {
              print(details);
              _scale = _previousScale * details.scale;
              setState(() {
                _scale = _previousScale * details.scale;
              });
            },
            onScaleEnd: (ScaleEndDetails details) {
              print(details);

              _previousScale = 1.0;
              setState(() {
                _previousScale = 1.0;
              });
            },
            child: RotatedBox(
              quarterTurns: 0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Transform(
                  alignment: FractionalOffset.center,
                  transform: Matrix4.diagonal3(Vector3(_scale, _scale, _scale)),
                  child: Image(
                    image: AssetImage(widget.thumbnailUrl),
                  ),
                ),
              ),
            ),
          ),
        ),
        // child: SizedBox(
        //   height: imageSize,
        //   child:  GestureDetector(
        //     onScaleUpdate: (details) {
        //       setState(() {
        //         imageSize = initimageSize + (initimageSize * (details.scale * .35));
        //       });
        //     },
        //     onScaleEnd: (ScaleEndDetails details) {
        //       setState(() {
        //         initimageSize = imageSize;
        //       });
        //     },
        //     onTap: (){
        //        Navigator.pop(context);
        //     },
        //     child: Image(
        //       height: double.infinity,
        //       width: double.infinity,
        //       image: AssetImage(widget.model.thumbnailUrl),
        //     ),
        //   ),
        // ),
      ),
    );
  }
}
