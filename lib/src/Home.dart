import 'dart:async';
import 'package:dharmlok/model/HomeModel.dart';
import 'package:dharmlok/model/panchang.dart';
import 'package:dharmlok/src/screens/DialogPage.dart';
import 'package:dharmlok/src/screens/InAppWebView.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dharmlok/model/SingleItem.dart';
import 'package:dharmlok/model/model.dart';
import 'package:dharmlok/model/slidercell.dart';
import 'package:dharmlok/service/Services.dart';
import 'package:dharmlok/src/screens/detail.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // ignore: close_sinks
  StreamController<int> streamController = new StreamController<int>();
  final ScrollController _scrollController = ScrollController();
  List<String> imageList = [
    "assets/slider/1.jpg",
    "assets/slider/2.jpg",
    "assets/slider/3.jpg",
    "assets/slider/4.jpg",
    "assets/slider/5.jpg"
  ];
  List<String> kathvachalList = [
    "assets/kathavachak/a.jpg",
    "assets/kathavachak/b.jpg",
    "assets/kathavachak/c.jpg",
    "assets/kathavachak/d.jpg",
    "assets/kathavachak/e.jpg",
    "assets/kathavachak/f.jpg",
    "assets/kathavachak/g.jpg",
    "assets/kathavachak/h.jpg",
    "assets/kathavachak/i.jpg"
  ];
  List<String> shopList = [
    "assets/shop/1.jpg",
    "assets/shop/2.jpg",
    "assets/shop/3.jpg",
    "assets/shop/4.jpg",
    "assets/shop/5.jpg",
    "assets/shop/6.jpg",
    "assets/shop/7.jpg",
    "assets/shop/8.jpg"
  ];
  List<Model> arrayList = [];
  List<HomeModel> harrayList = [];
  List<Panchang> parrayList = [];
  final _itemExtent = 126.0;

  List<Widget> getPageList(List<String> image) {
    var listView = List<Widget>();
    List.generate(
        image.length, (index) => {listView.add(SlderCell(image[index]))});
    return listView;
  }

  @override
  void initState() {
    super.initState();
    initValue();
  }

  void initValue() async {
    Future<List<Model>> list = Services.getJson();
    arrayList = await list;

    Future<List<Panchang>> plist = Services.getPanchangJson();
    parrayList = await plist;


    Future<List<HomeModel>> hlist = Services.getHomeJson();
    harrayList = await hlist;


  }

  goToDetailsPage(BuildContext context, Model album) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => GridDetail(album)));
  }

  double _current = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: TextStyle(
            fontFamily: 'Montserrat-Medium',
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: CarouselSlider(
              options: CarouselOptions(
                  height: 160.0,
                  aspectRatio: 16 / 9,
                  viewportFraction: 1.1,
                  initialPage: 0,
                  autoPlay: true,
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  onPageChanged: (pos, op) {
                    _current = pos.toDouble();
                    setState(() {
                      _current = pos.toDouble();
                    });
                    print("${_current}");
                  }),
              items: getPageList(imageList),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              child: DotsIndicator(
                dotsCount: imageList.length,
                position: _current,
                decorator: DotsDecorator(
                  activeColor: Color(int.parse("0xFF003975")),
                  size: const Size.square(9.0),
                  activeSize: const Size(18.0, 9.0),
                  activeShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              child: Padding(
                padding: EdgeInsets.only(left: 5, top: 5, bottom: 5),
                child: Text(
                  "Welcome to Dharmlok",
                  style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat-Medium'),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 130.0,
              width: 110.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  if (harrayList[index] != null) {
                    return singleView(harrayList[index].thumbnailUrl,
                        harrayList[index].name, harrayList[index].web);
                  }
                  return CircularProgressIndicator();
                },
                itemCount: harrayList == null ||
                        (harrayList.length == null || harrayList.length == 0)
                    ? 0
                    : harrayList.length,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              child: Padding(
                padding: EdgeInsets.only(left: 5, top: 5, bottom: 5),
                child: Text(
                  "Top on Dharmlok",
                  style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat-Medium'),
                ),
              ),
            ),
          ),
          SliverFixedExtentList(
            itemExtent: _itemExtent, // I'm forcing item heights
            delegate: SliverChildBuilderDelegate(
              (context, index) => SingleItem(arrayList[index]),
              childCount: arrayList.length,
            ),
          ),

          SliverToBoxAdapter(
            child: Container(
              child: Padding(
                padding: EdgeInsets.only(left: 5, top: 5, bottom: 5),
                child: Text(
                  "Panchang",
                  style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat-Medium'),
                ),
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: SizedBox(
              height: 130.0,
              width: 110.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  if (parrayList[index] != null) {
                    return panchangSingleView(parrayList[index].thumbnailUrl,parrayList[index].web,parrayList[index].name);
                  }
                  return CircularProgressIndicator();
                },
                itemCount: parrayList == null ||
                    (parrayList.length == null ||
                        parrayList.length == 0)
                    ? 0
                    : parrayList.length,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              child: Padding(
                padding: EdgeInsets.only(left: 5, top: 5, bottom: 5),
                child: Text(
                  "Kathavachak",
                  style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat-Medium'),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 130.0,
              width: 110.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  if (kathvachalList[index] != null) {
                    return kathavachakSingleView(kathvachalList[index]);
                  }
                  return CircularProgressIndicator();
                },
                itemCount: kathvachalList == null ||
                        (kathvachalList.length == null ||
                            kathvachalList.length == 0)
                    ? 0
                    : kathvachalList.length,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              child: Padding(
                padding: EdgeInsets.only(left: 5, top: 5, bottom: 5),
                child: Text(
                  "Explore Our Shop",
                  style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat-Medium'),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 130.0,
              width: 110.0,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  if (shopList[index] != null) {
                    return exploreShopSingleView(shopList[index]);
                  }
                  return CircularProgressIndicator();
                },
                itemCount: shopList == null ||
                        (shopList.length == null || shopList.length == 0)
                    ? 0
                    : shopList.length,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              child: Padding(
                padding: EdgeInsets.only(left: 5, top: 5, bottom: 5),
                child: Text(
                  "",
                  style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat-Medium'),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          onClick("https://www.dharmlok.com/live-darshan", "LIVE DARSHAN");
        },
        backgroundColor: Color(int.parse("0xFFe03430")),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.live_tv,size: 13,),
            Padding(
              padding: EdgeInsets.only(left: 2),
              child: Text("Live",style: TextStyle(fontSize: 11),),
            )
          ],
        ),
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  onClick(String webUrl, String name) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) =>
                InAppWebViewPage(webUrl, name)));
  }

  Widget singleView(String thumbnailUrl, String name, String webUrl) {
    print(thumbnailUrl);
    return SizedBox(
        width: 140,
        height: 96,
        child: GestureDetector(
          onTap: () {
            onClick(webUrl, name);
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (BuildContext context) => Dharmguru()));
          },
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0.0)),
            color: Colors.white,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(5.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image(
                      image: AssetImage(thumbnailUrl),
                      height: 66.0,
                      width: 66,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(left: 0, top: 5),
                    child: Text(
                      name,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 11, fontFamily: 'Montserrat-Medium'),
                    ))
              ],
            ),
          ),
        ));
  }

  Widget kathavachakSingleView(String thumbnailUrl) {
    return SizedBox(
      width: 140,
      height: 96,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
        color: Colors.white,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(0),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).push(PageRouteBuilder(
                  opaque: false,
                  pageBuilder: (BuildContext context, _, __) =>
                      DialogPage(thumbnailUrl)));
            },
            child: Image(
              image: AssetImage(thumbnailUrl),
              height: 66.0,
              width: 66,
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }

  Widget exploreShopSingleView(String thumbnailUrl) {
    return SizedBox(
      width: 140,
      height: 96,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
        color: Colors.white,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(0),
          child: GestureDetector(
            onTap: () {
              onClick("https://www.dharmlok.com/shop", "E-Shop");
            },
            child: Image(
              image: AssetImage(thumbnailUrl),
              height: 66.0,
              width: 66,
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }


  Widget panchangSingleView(String thumbnailUrl,String WelUrl,String name) {
    return SizedBox(
      width: 140,
      height: 96,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.0)),
        color: Colors.white,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(0),
          child: GestureDetector(
            onTap: () {
              onClick(WelUrl, name);
            },
            child: Image.network(
                thumbnailUrl,
              width: 66.0,
              height: 66.0,
            ),
          ),
        ),
      ),
    );
  }

}
