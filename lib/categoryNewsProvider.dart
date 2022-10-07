import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart';

import 'model.dart';

class categoryProvider with ChangeNotifier{
  List<newsQueryModel> newsModelList = <newsQueryModel>[];
  bool isLoading = true;
  String url = "";

  getCategotyNewsByQuery(String Query) async{
    if (Query == "Pakistan"|| Query == "More News")
    {
      url = "https://newsapi.org/v2/everything?q=Pakistan&language=en&apiKey=39fe1e032f1846b49d50285a7f6f2334";
    }
    else {
      if (Query == "Tech") {
        Query = "technology";
      }
      else if (Query == "Sports") {
        Query = "sports";
      }
      else if (Query == "General") {
        Query = "general";
      }
      else if (Query == "Finance") {
        Query = "bussiness";
      }

      url =
      "https://newsapi.org/v2/top-headlines?category=$Query&language=en&apiKey=39fe1e032f1846b49d50285a7f6f2334";
    }
    Response response = await get (Uri.parse(url));
    Map data = jsonDecode(response.body);
    // print(response.body);

      try{
        data["articles"]?.forEach((element){
          // print(element.toString());
          newsQueryModel NewsQueryModel = new newsQueryModel();
          NewsQueryModel = newsQueryModel.fromMap(element);
          newsModelList.add(NewsQueryModel);



        });
      }catch (e){};
    isLoading = false;
    notifyListeners();
  }
}

