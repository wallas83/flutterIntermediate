import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:news_app/src/models/category_model.dart';
import 'package:news_app/src/models/news_models.dart';
import 'package:http/http.dart' as http;


final _URL_NEWS = 'https://newsapi.org/v2';
final _APIKEY   = 'YOUR APIKEY FROM Newsapi';


class NewsService with ChangeNotifier {

    
  
    List<Article> headtlines = [];
    String _selectedCategory = 'business';
    bool _isLoading = true;

    List<Category> categorias = [
      Category(FontAwesomeIcons.building, 'business'),
      Category(FontAwesomeIcons.tv, 'entertainment'),
      Category(FontAwesomeIcons.addressCard, 'general'),
      Category(FontAwesomeIcons.headSideVirus, 'health'),
      Category(FontAwesomeIcons.vials, 'science'),
      Category(FontAwesomeIcons.volleyballBall, 'sports'),
      Category(FontAwesomeIcons.memory, 'technology')
    ];

    Map<String, List<Article>> categoryArticle = {};

  NewsService() {
    this.getTopheadLines();
    categorias.forEach( (item) { 
        this.categoryArticle[item.name] = new List();
    
    });
    this.getArticleByCategory(this._selectedCategory);
   
  }
 bool get isLoading => this._isLoading;

 get selectedCategory => this._selectedCategory;
  
  set selectedCategory(String valor) {

    this._selectedCategory = valor;
    this._isLoading = true;
    this.getArticleByCategory(valor);
    
    notifyListeners();
  
  }

  List<Article> get getArticulosCategoriaSeleccionada 
      => this.categoryArticle[selectedCategory];
  
   getTopheadLines() async {
    final url = '$_URL_NEWS/top-headlines?apiKey=$_APIKEY&country=BR';
    final resp = await http.get(url);
    final newsResponse = newsModelFromJson(resp.body);

    this.headtlines.addAll(newsResponse.articles);
    notifyListeners();
  }



  getArticleByCategory(String category) async {

    if(this.categoryArticle[category].length > 0) {
      this._isLoading = false;
      return this.categoryArticle[category];
    }  


    final url = '$_URL_NEWS/top-headlines?apiKey=$_APIKEY&country=BR&category=$category';
    final resp = await http.get(url);
    final newsResponse = newsModelFromJson(resp.body);

    this.categoryArticle[category].addAll(newsResponse.articles);
    this._isLoading = false;
    notifyListeners();

  }


}