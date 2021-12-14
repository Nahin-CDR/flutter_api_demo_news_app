import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
      home: API(),
    );

  }
}

Map? mapResponse;
Map? dataResponse;
List? listResponse;
class API extends StatefulWidget {
  const API({Key? key}) : super(key: key);
  @override
  _APIState createState() => _APIState();
}


class _APIState extends State<API> {


  final url = "https://newsapi.org/v2/everything?q=apple&from=2021-12-13&to=2021-12-13&sortBy=popularity&apiKey=240ada24aa594437bc4f596da435b1f7";

  Future ApiCall() async {
    http.Response response;
    response = await http.get(Uri.parse(url));
    if(response.statusCode == 200){
      setState(() {
        mapResponse = json.decode(response.body);
        //dataResponse = mapResponse!['articles'];
        listResponse = mapResponse!['articles'];
      });

    }else
      {
        print("error");
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
      appBar: AppBar(
        title: Text("News App"),
      ),
      body: ListView.builder(itemBuilder: (context,index){
        return Container(
          child: Column(
            children: [
              Container(
                margin: new EdgeInsets.all(10),
                //decoration: BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.green),
                child: listResponse![index]['urlToImage'] == null ? Text("Loading Image.."):
                Image.network(listResponse![index]['urlToImage']),
              ),
              Container(
                margin: new EdgeInsets.all(1),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: Center(
                  child: listResponse![index]['author'] == null ?Text("Loading data"):
                  Text("author : "+listResponse![index]['author'].toString(),style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey
                  ),
                  ),
                ),
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


              // Container(
              //   margin: new EdgeInsets.only(left: 10,right: 10),
              //   decoration: BoxDecoration(borderRadius: BorderRadius.circular(1)),
              //   child: Center(
              //     child: listResponse![index]['content'] == null ?Text("Loading data"):
              //     Text("Content : "+listResponse![index]['content'].toString(),style: TextStyle(
              //         fontSize: 18
              //     ),
              //     ),
              //   ),
              // ),
              //



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
