import 'package:flutter/material.dart';
import 'package:flutter_api_demo_news_app/helper/data.dart';
import 'package:flutter_api_demo_news_app/helper/news.dart';
import 'package:flutter_api_demo_news_app/models/article_model.dart';
import 'package:flutter_api_demo_news_app/models/category_model.dart';



class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<CategoryModel> categories = <CategoryModel>[];
  List<ArticleModel> articles = <ArticleModel>[];


  bool _loading = true;

  @override
  void initState() {
    super.initState();
    categories = getCategories();
    getNews();
  }

  getNews() async{
    News newsClass = News();
    await newsClass.getNews();
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(

        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Flutter",style: TextStyle(color: Colors.black),),
            Text("News",style: TextStyle(color: Colors.blue),)
          ],
        ),
        centerTitle: true,
       // elevation: 0.0,
      ),
      body: _loading ? Center(
          child: CircularProgressIndicator(),
         ) : SingleChildScrollView(
           padding: EdgeInsets.symmetric(horizontal: 16),
           child: Container(
           child: Column(
             children: <Widget>[

              ///Categories



              Container(

                height: 70,
                margin: EdgeInsets.all(10),
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context,index){
                    return CategoryTile(
                      imageUrl: categories[index].imageUrl,
                      categoryName: categories[index].categoryName,
                    );
                  },
                ),
              ),
              ///Blogs
              Container(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: articles.length,
                    itemBuilder: (context,index){
                      return BlogTile(
                        imageUrl: articles[index].uriToImage.toString(),
                        title: articles[index].title.toString(),
                        desc: articles[index].description.toString(),

                      );
                    }
                ),
              )
            ],
        ),
      ),
         ),


    );
  }
}


class CategoryTile extends StatelessWidget {

  final imageUrl,categoryName;
  CategoryTile({this.imageUrl,this.categoryName});



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        
      },
      child: Container(
        margin: EdgeInsets.only(right: 10),
        child: Stack(

          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: Image.network(imageUrl,width: 120,height: 60,fit: BoxFit.cover,),
            ),
            Container(
              alignment: Alignment.center,
              width: 120,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Colors.black26,
              ),
              child: Text(categoryName,style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500
              ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BlogTile extends StatelessWidget {

  final String imageUrl,title,desc;
  BlogTile({
    required this.imageUrl,
    required this.title,
    required this.desc
  });




  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child:  Image.network(imageUrl),
          ),
          Container(
            padding: EdgeInsets.all(8),
            child: Text(title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18)),
          ),
          Container(
              margin: EdgeInsets.only(bottom: 20),
              padding: EdgeInsets.all(10),
              decoration : BoxDecoration(borderRadius: BorderRadius.circular(10),color: Colors.black12),
              child:  Text(desc),
          ),
        ],
      ),
    );
  }
}
