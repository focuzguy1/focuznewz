import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:focuznewz/helper/data.dart';
import 'package:focuznewz/helper/news.dart';
import 'package:focuznewz/models/article_model.dart';
import 'package:focuznewz/models/categori_model.dart';
import 'package:focuznewz/views/article_view.dart';

import 'category_news.dart';
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<CategoryModel> categories = new List<CategoryModel>();
  List<ArticleModel> articles = new List<ArticleModel>();

  bool _loading = true;
  @override
  void initState() { //initial will be call when the home page is open
    // TODO: implement initState
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
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Focuz"),
            Text("Newz", style: TextStyle(
                color: Colors.blue),)
          ]
        ),
            centerTitle:true,
            elevation: 0.0,
      ),

        body: _loading ? Center(
          child: Container(
          child:CircularProgressIndicator(),
      ),
          //SingleChildScrollView helps to remove the builder that displayed below the screen
        ): SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
          children: <Widget>[

            ///Categories
            Container(
             // padding: EdgeInsets.symmetric(horizontal: 16),
              height: 70,
              child: ListView.builder(//item.count
                  itemCount: categories.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index){
                    return CategoryTile(
                      imageUrl: categories[index].imageUrl,
                      categoryName: categories[index].categoryName,
                    );
                    }
              ),
            ),

            ///Blogs
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
            )
          ],
        ),
      ),
    )
    );
  }
}

class CategoryTile extends StatelessWidget {
  final String imageUrl, categoryName;
  CategoryTile({this.imageUrl, this.categoryName});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => CatergoryNews(
            category: categoryName.toLowerCase(),
          )));
        },
    child: Container(
      margin: EdgeInsets.only(right: 16),
      // stack mean putting multiple thing on a page
      child: Stack(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            //we replace image.network to cachedNetworkImage
            child: CachedNetworkImage(
              imageUrl: imageUrl, width: 120, height: 60, fit: BoxFit.cover,),
          ),
          Container(
            alignment: Alignment.center,
            width: 120,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              color: Colors.black26,
            ),
            child: Text(categoryName, style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w500
            ),),
          )
        ],

      ),
    )
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
