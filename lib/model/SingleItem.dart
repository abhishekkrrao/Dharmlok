import 'package:dharmlok/src/screens/InAppWebView.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'model.dart';

class SingleItem extends StatelessWidget {
  const SingleItem(this.album);

  @required
  final Model album;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 120.0,
      child: Card(
        color: Color(int.parse(album.color)),
        child: GestureDetector(
          onTap: (){
            onClick(album, context);
          },
          child: Container(
            padding: new EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
            height: 120.0,
            width: double.infinity,
            child: new Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 84.0,
                  height: 84.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("assets/images/" + album.thumbnailUrl),
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(84.0)),
                  ),
                ),
                new Expanded(
                  child: new Container(
                    padding: new EdgeInsets.only(left: 8.0),
                    child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        new Text(
                          album.name,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: new TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Montserrat-Medium',
                            fontSize: 16.0,
                          ),
                        ),
                        new Text(
                          album.desc,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: new TextStyle(
                              color: Colors.white60,
                              fontFamily: 'Montserrat-Medium',
                              fontSize: 14),
                        ),
                        new Text(
                          album.web,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: new TextStyle(
                              color: Colors.white,
                              fontFamily: 'Montserrat-Medium',
                              fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ),
    );
  }
  onClick(Model model,BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => InAppWebViewPage(model.web,model.name)));
  }
}
