import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart';

import 'model.dart';
int i =0;

class newsProvider with ChangeNotifier{
  bool isLoading = true;
  List<newsQueryModel> newsModelList = <newsQueryModel>[];
  List<newsQueryModel> newsModelListSlider = <newsQueryModel>[];

  getLatestNewsByQuery(String Query) async{
    Map element;

    String url ="https://newsapi.org/v2/everything?q=$Query&language=en&apiKey=39fe1e032f1846b49d50285a7f6f2334";

    Response response = await get (Uri.parse(url));
    Map data = jsonDecode(response.body);
    // print(response.body);

   for(element in data["articles"]){
        try{

          i++;
          newsQueryModel NewsQueryModel = new newsQueryModel();
          NewsQueryModel = newsQueryModel.fromMap(element);
          newsModelList.add(NewsQueryModel);
        }catch (e){};

      };
    isLoading = false;
    notifyListeners();

  }


  getSliderNewsByQuery(String Query) async{
    String url = "https://newsapi.org/v2/top-headlines?category=$Query&language=en&apiKey=39fe1e032f1846b49d50285a7f6f2334";

    Response response = await get (Uri.parse(url));
    Map data = jsonDecode(response.body);
    // print(response.body);

      data["articles"]?.forEach((element){
        try{
          newsQueryModel NewsQueryModel = new newsQueryModel();
          NewsQueryModel = newsQueryModel.fromMap(element);
          newsModelListSlider.add(NewsQueryModel);


        }catch (e){};
      });
    isLoading = false;
    notifyListeners();
  }

}