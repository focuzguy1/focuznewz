import 'package:flutter/material.dart';
import 'package:focuznewz/helper/news.dart';
import 'package:focuznewz/models/article_model.dart';
import 'package:focuznewz/views/home.dart';
import 'article_view.dart';
import 'home.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CatergoryNews extends StatefulWidget {
  final String category;
  CatergoryNews({this.category});

  @override
  _CatergoryNewsState createState() => _CatergoryNewsState();
}

class _CatergoryNewsState extends State<CatergoryNews> {

  List<ArticleModel> articles = new List<ArticleModel>();
  bool _loading = true;

  @override// now we fetch the
  void initState() {
    // TODO: implement initState
    super.initState();
    getCategorieNews();//get this news on the page
  }
  getCategorieNews() async{
    CategoryNewsClass newsClass =  CategoryNewsClass();// categoryNewsClass from category_news.dart
    await newsClass.getNews(widget.category);
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Focuz"),
              Text("News", style: TextStyle(
                  color: Colors.blue),)
            ]
        ),
        actions: [
          Opacity(
            opacity: 0,
            child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Icon(Icons.save)),
          ),
        ],
        centerTitle:true,
        elevation: 0.0,
      ),
      body: _loading ? Center(
        child: Container(
          child:CircularProgressIndicator(),
        ),
        //SingleChildScrollView helps to remove the builder that displayed below the screen
      ):SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: <Widget>[
              //blogs
          Container(
          padding: EdgeInsets.only(top:16),
          child:ListView.builder(
              itemCount: articles.length,
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),// clampingscrollphysics make the page scrollable
              itemBuilder: (Context, index){
                return BlogTile(
                  imageUrl: articles[index].urlToImage,
                  title: articles[index].title,
                  desc: articles[index].description,
                  url: articles[index].url,
                );
              }),
          ),

            ],
          ),
        ),
      ),
    );
  }
}


class BlogTile extends StatelessWidget {

  final String imageUrl, title, desc, url;

  // var url;
  BlogTile({@required this.imageUrl,@required this.title,@required this.desc, @required this.url});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
            builder: (context) => ArticleView(
              blogUrl: url,

            )
        ));
      },
      child: Container(
          margin: EdgeInsets.only(bottom: 16),
          child: Column(
            children: <Widget>[
              ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.network(imageUrl)
              ),
              SizedBox(height: 8,),
              Text(title, style: TextStyle(
                color: Colors.black87,
                fontSize: 17.0,
                fontWeight: FontWeight.w600,),),

              SizedBox(height: 8,),
              Text(desc, style: TextStyle(color: Colors.black54),)
            ],
          )
      ),
    );
  }
}
