import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'dart:io' show Platform;

// ignore: must_be_immutable
class InAppWebViewPage extends StatefulWidget {
  InAppWebViewPage(this.url,this.name);

  @required
  String url;
  String name;

  @override
  _InAppWebViewState createState() => new _InAppWebViewState();
}

class _InAppWebViewState extends State<InAppWebViewPage> {
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

  circularProgress() {
    return Center(
      child: const CircularProgressIndicator(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.name,
          style: TextStyle(
            fontFamily: 'Montserrat-Medium',
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Container(
          child: Column(children: <Widget>[
        Container(
            padding: EdgeInsets.all(10.0),
            child: progress < 1.0
                ? CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                        Color(int.parse("0xFF003975"))),
                  )
                : Container()
            // child: progress < 1.0 ? LinearProgressIndicator(value: progress) : Container()
            ),
        Expanded(
          child: Container(
            margin: const EdgeInsets.all(1.0),
            height: double.infinity,
            width: double.infinity,
            // decoration: BoxDecoration(border: Border.all(color: Colors.blueAccent)),
            child: InAppWebView(
              initialUrl: widget.url,
              initialHeaders: {},
              initialOptions: InAppWebViewGroupOptions(
               android: AndroidInAppWebViewOptions(
                 scrollbarFadingEnabled:false,
               ),
                  ios: IOSInAppWebViewOptions(
                  ),

                  crossPlatform: InAppWebViewOptions(

                debuggingEnabled: Platform.isIOS ? true : false,
              )),
              onWebViewCreated: (InAppWebViewController controller) {
                webView = controller;
              },
              onLoadStart: (InAppWebViewController controller, String url) {
                setState(() {
                  this.url = url;
                });
              },
              onLoadStop:
                  (InAppWebViewController controller, String url) async {
                setState(() {
                  this.url = url;
                });
              },
              onProgressChanged:
                  (InAppWebViewController controller, int progress) {
                setState(() {
                  this.progress = progress / 100;
                });
              },
            ),
          ),
        ),
      ])),
    );
  }
}
