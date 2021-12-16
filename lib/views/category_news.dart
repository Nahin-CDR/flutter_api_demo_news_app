import 'package:flutter/material.dart';
import 'package:flutter_api_demo_news_app/helper/data.dart';
import 'package:flutter_api_demo_news_app/helper/news.dart';
import 'package:flutter_api_demo_news_app/models/article_model.dart';


import 'article_view.dart';
import 'home.dart';

class CategoryNews extends StatefulWidget {

  final String category;
  CategoryNews({required this.category});


  @override
  _CategoryNewsState createState() => _CategoryNewsState();


}

class _CategoryNewsState extends State<CategoryNews> {


  List<ArticleModel> articles = <ArticleModel>[];
  bool _loading = true;
  @override
  void initState() {
    getCategoryNews();
    super.initState();
  }

  void getCategoryNews() async {
    CategoryNewsClass newsClass = CategoryNewsClass();
    await newsClass.getNews(widget .category);
    setState(() {
      _loading = false;
    });
  }






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
      body: _loading? Center(
        child: CircularProgressIndicator(),
      ) :
      SingleChildScrollView(
        child: Column(
          children:<Widget>[
            ///Blogs
            Container(
              padding: EdgeInsets.only(top: 16),
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: articles.length,
                  physics: ClampingScrollPhysics(),
                  itemBuilder: (context,index){
                    return CategoryBlogTile(
                      imageUrl: articles[index].uriToImage.toString(),
                      title: articles[index].title.toString(),
                      desc: articles[index].description.toString(),
                      url: articles[index].url,
                    );
                  }
              ),
            )

          ],
        ),
      ),
    );
  }
}

class CategoryBlogTile extends StatelessWidget {

  final String imageUrl,title,desc;
  final url;

  CategoryBlogTile({
    required this.imageUrl,
    required this.title,
    required this.desc,
    required this.url,
  });




  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        var route = MaterialPageRoute(builder: (context)=>
            ArticleView(
              blogUrl: url,)
        );
        Navigator.push(context, route);
        //print(url);
      },
      child: Container(
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child:  Image.network(imageUrl),
            ),
            Container(
              padding: EdgeInsets.all(8),
              child: Text(title,style: TextStyle(fontSize: 22,color: Colors.black)),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 20),
              padding: EdgeInsets.all(10),
              decoration : BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.white10),
              child:  Text(desc,style: TextStyle(fontSize: 18,color: Colors.grey),),
            ),
          ],
        ),
      ),
    );
  }
}
