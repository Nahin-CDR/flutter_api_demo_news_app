
import 'dart:convert';

import 'package:flutter_api_demo_news_app/models/article_model.dart';
import 'package:flutter_api_demo_news_app/models/category_model.dart';
import 'package:http/http.dart' as http;

class News{
  List<ArticleModel> news = [];

//country=in sources=techcrunch
  Future <void> getNews() async {
    final url = "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=240ada24aa594437bc4f596da435b1f7";
    final response = await http.get(Uri.parse(url));
    final jsonData = jsonDecode(response.body);
    if(jsonData['status'] == "ok"){
      jsonData['articles'].forEach((element){
        if(element['urlToImage'] != null && element['description'] != null){
           ArticleModel articleModel = ArticleModel(
             title: element['title'],
             author: element['author'],
             description: element['description'],
             url: element['url'],
             uriToImage: element['urlToImage'],
           );
           news.add(articleModel);
        }
      });
    }
  }



}

//Inactive CodePart
class CategoryNewsClass{
  List<ArticleModel> news = [];
  Future <void> getNews(String category) async {
    final url = "https://newsapi.org/v2/top-headlines?country=in&category=$category&apiKey=240ada24aa594437bc4f596da435b1f7";
   // print(url);
    final response = await http.get(Uri.parse(url));
    final jsonData = jsonDecode(response.body);
    if(jsonData['status'] == "ok"){

      jsonData['articles'].forEach((element){
        if(element['urlToImage'] != null && element['description'] != null){
          ArticleModel articleModel = ArticleModel(
            title: element['title'],
            author: element['author'],
            description: element['description'],
            url: element['url'],
            uriToImage: element['urlToImage'],
          );
          news.add(articleModel);
        }
      });
    }
  }



}