import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dharmlok/model/SingleItem.dart';
import 'package:dharmlok/model/model.dart';
import 'package:dharmlok/model/slidercell.dart';
import 'package:dharmlok/service/Services.dart';
import 'package:dharmlok/src/screens/detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
class _MyHomePageState extends State<MyHomePage> {
  StreamController<int> streamController = new StreamController<int>();
  List<String> imageList = [
    "assets/slider/1.jpg",
    "assets/slider/2.jpg",
    "assets/slider/3.jpg",
    "assets/slider/4.jpg",
    "assets/slider/5.jpg"
  ];
  List<Widget> getPageList(List<String> image) {
    var listView = List<Widget>();
    List.generate(
        image.length, (index) => {listView.add(SlderCell(image[index]))});
    return listView;
  }
  circularProgress() {
    return Center(
      child: const CircularProgressIndicator(),
    );
  }
  goToDetailsPage(BuildContext context, Model album) {
    // Navigator.push(context,
    //     MaterialPageRoute(builder: (BuildContext context) => TestPage()));
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => GridDetail(album)));
  }
  gridView(AsyncSnapshot<List<Model>> snapshot) {
    return Scaffold(
      body: AnimationLimiter(
        child: ListView.builder(
          itemCount: snapshot.data.length,
          itemBuilder: (BuildContext context, int index) {
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 2075),
              child: SlideAnimation(
                verticalOffset: 350.0,
                child: FadeInAnimation(
                  child: GestureDetector(
                    child: SingleItem(snapshot.data[index]),
                    // child: AlbumCell(snapshot.data[index]),
                    onTap: () {
                      goToDetailsPage(context, snapshot.data[index]);
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
  int _current = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title,
          style: TextStyle(fontFamily: 'Montserrat-Medium', fontSize: 14, fontWeight: FontWeight.w700,),
        ),
      ),
      body:  Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        CarouselSlider(
          options: CarouselOptions(
              height: 180.0,
              aspectRatio: 16 / 9,
              viewportFraction: 1.1,
              initialPage: 0,
              autoPlay: true,
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              onPageChanged: (pos, op) {
                _current = pos;
                print("${_current}");
              }),
          items: getPageList(imageList),
        ),
        Container(
          width: double.infinity,
          child: Card(
            color: Colors.indigo,
            margin: EdgeInsets.all(2.0),
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Text("Dharmlok App",
                style: TextStyle(fontFamily: 'Montserrat-Medium',
                  fontSize: 16, fontWeight: FontWeight.bold,color: Colors.white,),),
            ),
          ),
        ),
        Flexible(
          child: FutureBuilder<List<Model>>(
            future: Services.getJson(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Error ${snapshot.error}');
              }
              if (snapshot.hasData) {
                streamController.sink.add(snapshot.data.length);
                return gridView(snapshot);
              }
              return circularProgress();
            },
          ),
        ),
      ],
    ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}