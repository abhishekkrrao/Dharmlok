import 'package:dharmlok/model/model.dart';
import 'package:dharmlok/model/panchang.dart';
import 'package:dharmlok/service/Services.dart';
import 'package:flutter/material.dart';

import 'InAppWebView.dart';

class Dharmguru extends StatefulWidget {
  Dharmguru(this.title);

  String title;

  DharmguruState createState() => DharmguruState();
}

class DharmguruState extends State<Dharmguru> {
  final ScrollController _scrollController = ScrollController();
  List<Model> arrayListGrid = [];

  @override
  Widget build(BuildContext context) {
    return ViewIt();
  }

  @override
  initState() {
    super.initState();

    initValue().then((list) => {
          setState(() {
            list.removeAt(list.length - 1);
            list.removeAt(list.length - 1);
            arrayListGrid = list;
          })
        });
  }

  Future<List<Model>> initValue() async {
    Future<List<Model>> list = Services.getJson();
    arrayListGrid = await list;
    return list;
  }

  // ignore: non_constant_identifier_names
  Widget ViewIt() {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(
            fontSize: 17,
          ),
        ),
      ),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[
          SliverGrid(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.1,
            ),
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                if (arrayListGrid[index] != null) {
                  return singleGridView(arrayListGrid[index]);
                }
                return CircularProgressIndicator();
              },
              childCount: arrayListGrid == null ||
                      (arrayListGrid.length == 0 ||
                          arrayListGrid.length == null)
                  ? 0
                  : arrayListGrid.length,
            ),
          ),
        ],
      ),
    );
  }
  onClick(String webUrl, String name) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => InAppWebViewPage(webUrl, name)));
  }
  //Top Restrurant
  Widget singleGridView(Model restModel) {
    print(restModel.thumbnailUrl);
    return SizedBox(
      child: GestureDetector(
        onTap: (){},
        child: Container(
          color: Colors.white,
          margin: EdgeInsets.all(5.0),
          child: Column(
            children: [
              // Image.network(
              //   restModel.thumbnailUrl,
              //   fit: BoxFit.fitWidth,
              //   height: 101,
              //   width: double.infinity,
              // ),
              Image(
                image: AssetImage(restModel.thumbnailUrl),
                height: 120.0,
                width: 96,
                fit: BoxFit.fitWidth,
              ),
              Padding(
                padding: EdgeInsets.all(6.0),
                child: Text(
                  restModel.name,
                  style: TextStyle(
                      fontSize: 11,
                      fontFamily: 'Montserrat-Medium',
                      fontWeight: FontWeight.bold),
                  maxLines: 3,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
