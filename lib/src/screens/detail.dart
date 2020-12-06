import 'package:dharmlok/model/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import 'InAppWebView.dart';
// ignore: must_be_immutable
class GridDetail extends StatefulWidget {
  GridDetail(this.model);
  @required
  Model model;
  @override
  GridDetailsState createState() => GridDetailsState();
}
class GridDetailsState extends State<GridDetail> {
  InAppWebViewController webView;
  String url = "";
  double progress = 0;
  @override
  void initState() {
    super.initState();
  }
  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            widget.model.name,
            style: TextStyle(
              fontSize: 13.0,
            ),
          )),
      body: new ListView(
        shrinkWrap: true,
        children: [
          Container(
              alignment: Alignment.topLeft,
              margin: EdgeInsets.all(5.0),
              child: SizedBox(

                width: double.infinity,
                child: Card(

                  child: new Column(

                    children: <Widget>[
                      Image(
                        width: double.infinity,
                        image: AssetImage(widget.model.thumbnailUrl),
                      ),
                      Padding(
                        padding: EdgeInsets.all(15.0),
                        child: Text(
                          widget.model.name,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Montserrat-Medium',
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Text(
                          widget.model.desc,
                          style: TextStyle(
                            fontFamily: 'Montserrat-Medium',
                            fontSize: 11,
                            fontWeight: FontWeight.w300,
                            wordSpacing: 2.0,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      )
                    ],
                  ),
                ),
              )
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => InAppWebViewPage(widget.model)));
        },
        child: IconButton(
          onPressed: ()=>{
          Navigator.push(
          context,
          MaterialPageRoute(
          builder: (BuildContext context) => InAppWebViewPage(widget.model)))
          },
          icon:Icon(Icons.arrow_forward_ios),

        ),
        backgroundColor: Color(int.parse("0xFF003975")),
      ),
    );
  }
}
