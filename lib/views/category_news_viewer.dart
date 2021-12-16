
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/cupertino.dart';

import 'string_extension.dart';




Map? mapResponse;
List? listResponse;




class CategoryNewsViewer extends StatefulWidget {
  final String category;
  CategoryNewsViewer({required this.category});



  @override
  _CategoryNewsViewerState createState() => _CategoryNewsViewerState(category);
}



class _CategoryNewsViewerState extends State<CategoryNewsViewer> {
  //https://newsapi.org/v2/everything?q=apple&from=2021-12-13&to=2021-12-13&sortBy=popularity&apiKey=240ada24aa594437bc4f596da435b1f7
  //https://newsapi.org/v2/top-headlines?country=in&category=Health&apiKey=240ada24aa594437bc4f596da435b1f7

  String category;
  _CategoryNewsViewerState(this.category);


  get K => category[0].toUpperCase();








  Future ApiCall() async {

    final url = "https://newsapi.org/v2/top-headlines?country=in&category=$category&apiKey=240ada24aa594437bc4f596da435b1f7";
    final response = await http.get(Uri.parse(url));
    final jsonData = jsonDecode(response.body);
    print(response.statusCode);
    if(jsonData['status'] == "ok"){


      jsonData['articles'].forEach((element){
        if(element['urlToImage'] != null && element['description'] != null){
          setState(() {
            mapResponse = jsonDecode(response.body);
            listResponse = mapResponse!['articles'];
          });
        }
      });
    }


  }

  @override
  void initState() {
    // TODO: implement initState
    ApiCall();

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(


      ///App bar Section

      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
          color : Colors.black,
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Live",style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold),),
            Text("News",style: TextStyle(color: Colors.blue)),
            Text("   ${K+category.substring(1)+category.substring(category.length)}",style: TextStyle(color: Colors.black)),
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



      ///Body Section




      body: ListView.builder(itemBuilder: (context,index){
        return Container(
          child: Column(
            children: [
              Container(
                margin: new EdgeInsets.all(10),
               // decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.green),
                child: listResponse![index]['urlToImage'] == null ? Text("Loading Image"):
                Image.network(listResponse![index]['urlToImage']),
              ),

              Container(
                margin: new EdgeInsets.only(top: 10),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(2)),
                child: Center(
                  child: listResponse![index]['title'] == null ?Text("Loading data"):
                  Text(listResponse![index]['title'].toString(),style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                  ),
                  ),
                ),
              ),

              Container(
                margin: new EdgeInsets.only(top: 10,left: 10,right: 10),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(2)),
                child: Center(
                  child: listResponse![index]['description'] == null ?Text("Loading data"):
                  Text(listResponse![index]['description'].toString(),style: TextStyle(
                      fontSize: 18
                  ),
                  ),
                ),
              ),

              Container(
                height: 30,
                margin: new EdgeInsets.only(left: 10,right: 10,top: 10),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(2)),
                child: Center(
                  child: listResponse![index]['publishedAt'] == null ?Text("Loading data"):
                  Text("published At : "+listResponse![index]['publishedAt'].toString(),style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey
                  ),
                  ),
                ),
              ),

              Container(
                margin: new EdgeInsets.only(top: 20,bottom: 20),
                height: 1,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(2),color: Colors.redAccent),
              )
            ],
          ),
        );
      },
        itemCount: listResponse == null?0:listResponse!.length,
      ),
    );
  }
}
