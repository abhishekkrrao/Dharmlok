import 'package:dharmlok/model/panchang.dart';
import 'package:dharmlok/service/Services.dart';
import 'package:flutter/material.dart';
class Dharmguru extends StatefulWidget{
  DharmguruState createState()=> DharmguruState();
}
class DharmguruState extends State<Dharmguru>{
  final ScrollController _scrollController = ScrollController();
  List<Panchang> arrayListGrid = [];
  @override
  Widget build(BuildContext context) {
    return ViewIt();
  }
  @override
  initState() {
    super.initState();
    initValue();
  }
  void initValue() async {
    Future<List<Panchang>> list = Services.getPanchangJson();
    arrayListGrid = await list;
  }
  // ignore: non_constant_identifier_names
  Widget ViewIt() {
    return Scaffold(
      appBar: AppBar(),
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

  //Top Restrurant

  Widget singleGridView(Panchang restModel) {
    return SizedBox(
      width: double.infinity,
      height: 135,
      child: Container(
        color: Colors.white,
        margin: EdgeInsets.all(5.0),
        child: Column(
          children: [
            Image(
              image: AssetImage(restModel.thumbnailUrl),
              width: double.infinity,
              height: 120,
              fit: BoxFit.fill,
            ),
            Text(restModel.name),
          ],
        ),
      ),
    );
  }
}