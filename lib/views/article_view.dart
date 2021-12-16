
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

bool isLoading = true;

class ArticleView extends StatefulWidget {

  final String blogUrl;
  ArticleView({required this.blogUrl});

  @override
  _ArticleViewState createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {

  final Completer<WebViewController> _completer = Completer<WebViewController>();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color : Colors.black,
        ),

        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Flutter",style: TextStyle(color: Colors.black),),
            Text("News",style: TextStyle(color: Colors.blue),)
          ],
        ),
        actions: <Widget>[
          Opacity(
            opacity: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.arrow_back,color: Colors.transparent),

            ),
          )
        ],
         centerTitle: true,
         elevation: 0.0,
      ),
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.all(20),
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: WebView(
              //javascriptMode: JavascriptMode.unrestricted,
              initialUrl: widget.blogUrl,
              onPageFinished: (finish){
                setState(() {
                  isLoading = false;
                });
              },
              onWebViewCreated: ((WebViewController webViewController){
                _completer.complete(webViewController);
              }),
            ),
          ),
          isLoading ? Center(
            child: CircularProgressIndicator()):Stack(),
        ],
      ),
    );
  }
}
