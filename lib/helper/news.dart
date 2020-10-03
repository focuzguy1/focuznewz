import 'dart:convert';
import 'package:focuznewz/models/article_model.dart';
import 'package:focuznewz/views/category_news.dart';
import 'package:http/http.dart' as http;

class News{


  List<ArticleModel> news = [];
  // the url will be used to fetch the data

  Future<void> getNews() async{// we get the categoryNews into the getNews
    String url = "http://newsapi.org/v2/top-headlines?country=in&apiKey=5d1bc0ceaf7441f09d34ea8b3c8609a2";
    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);
    if(jsonData['status'] == "ok") {
      jsonData['articles'].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          ArticleModel articleModel = ArticleModel(
            title: element['title'],
            author: element["author"],
            description: element["description"],
            url: element["url"],
            urlToImage: element["urlToImage"],
            content: element["content"]
          );

          news.add(articleModel);
        }
      });
    }
  }
}

class CategoryNewsClass{


  List<ArticleModel> news = [];
  // the url will be used to fetch the data


  Future<void> getNews(String category) async{// we get the categoryNews into the getNews
    String url = "http://newsapi.org/v2/top-headlines?country=in&category=$category&apiKey=5d1bc0ceaf7441f09d34ea8b3c8609a2";
    var response = await http.get(url);

    var jsonData = jsonDecode(response.body);
    if(jsonData['status'] == "ok") {
      jsonData['articles'].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          ArticleModel articleModel = ArticleModel(
              title: element['title'],
              author: element["author"],
              description: element["description"],
              url: element["url"],
              urlToImage: element["urlToImage"],
              content: element["content"]
          );

          news.add(articleModel);
        }
      });
    }
  }
}
