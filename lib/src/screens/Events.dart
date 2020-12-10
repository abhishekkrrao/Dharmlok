import 'package:dharmlok/model/EventModel.dart';
import 'package:dharmlok/service/Services.dart';
import 'package:flutter/material.dart';

import 'InAppWebView.dart';
class Event extends StatefulWidget{
  String title;
  Event(this.title);
  EventState createState()=> EventState();
}
class EventState extends State<Event>{
  final ScrollController _scrollController = ScrollController();
  List<EventModel> arrayListGrid=[];
  @override
  initState() {
    super.initState();

    initValue().then((list) => {
      setState(() {
        arrayListGrid = list;
      })
    });
  }

  Future<List<EventModel>> initValue() async {
    Future<List<EventModel>> list = Services.getEventJson();
    arrayListGrid = await list;
    return list;
  }


  @override
  Widget build(BuildContext context) {

    return ViewIt();
  }
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
  Widget singleGridView(EventModel restModel) {
    print(restModel.thumbnailUrl);
    return SizedBox(
      child: GestureDetector(
        onTap: (){
          onClick(restModel.web, restModel.name);
        },
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
                width: double.infinity,
                fit: BoxFit.fitWidth,
              ),
              Padding(
                padding: EdgeInsets.all(6.0),
                child: Text(
                  restModel.name,
                  style: TextStyle(
                      fontSize: 13,
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