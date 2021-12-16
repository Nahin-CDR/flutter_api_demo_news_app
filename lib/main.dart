import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_api_demo_news_app/single_page.dart';
import 'package:flutter_api_demo_news_app/views/category_news_viewer.dart';
import 'package:flutter_api_demo_news_app/views/home.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/cupertino.dart';


void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {

    return  MaterialApp(
      title: 'News App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white
      ),
      home: Home(), //API(), //DemoApp_One() //API(),
    );

  }
}

