import 'dart:convert';


import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:untitled/screens/homescreen.dart';
import '../categoryNewsProvider.dart';
import '../model.dart';
import 'newsview.dart';

class CategoryPage extends StatefulWidget {
  String query= "";
  CategoryPage({required this. query});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  List<String> navBarItem = ["Home","Technology","Pakistan", "Sports","Finance"];




  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text('HMZ NewZ',
          style: TextStyle(
            fontFamily: 'Neucha',
            fontWeight: FontWeight.bold,
            fontSize: 32,
          ),),
        centerTitle: true,
        backgroundColor: Colors.black87,
      ),
      body: SingleChildScrollView(
      child: Container(
      child: Column(

      children: [

    SizedBox(height: 10),
        //navbar
        Container(
          padding: EdgeInsets.symmetric(vertical: 3),
          height: 50,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: navBarItem.length,
            itemBuilder: (context ,index ){
              return InkWell(
                onTap: (){
                  if (navBarItem[index]== "Home")
                  {
                    Navigator.pop(context);
                  }

                    else
                  {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CategoryPage(query: navBarItem[index])));

                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: Colors.blue.shade900
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20),

                  margin: EdgeInsets.symmetric(horizontal: 7),
                  child: Center
                    (
                      child: Text(navBarItem[index],
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          // fontFamily: "Neucha"
                        ),)
                  ) ,
                ),
              );
            }
            ,
          ),
        ),
        //newsCard
        Column(

          children: [
            Container(
              padding: EdgeInsets.fromLTRB(18, 10, 0, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(widget.query + " :",
                    style: TextStyle(
                        shadows: <Shadow>[
                    Shadow(
                    offset: Offset(-5.0, 2.0),
                blurRadius: 3.0,
                color: Color.fromARGB(100, 255, 255, 255),
              ),],
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,


                    ),),
                ],
              ),
            ),


          ChangeNotifierProvider<categoryProvider>(
            create: (context)=> categoryProvider(),
            child: Consumer<categoryProvider>(
                builder: (context,provider,child){
                  provider.getCategotyNewsByQuery(widget.query);
                  return  provider.isLoading ?
                  Container(
                      height: MediaQuery.of(context).size.height - 400,
                      child: Center(child: CircularProgressIndicator())) :
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: provider.newsModelList.length,

                      itemBuilder: (context, index){
                        try{
                          return Container(
                              margin: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                              child: InkWell(
                                onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>NewsView(provider.newsModelList[index].newsUrl)));},
                                child: Card(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    elevation: 7.0,
                                    child: Stack(
                                      children: [
                                        ClipRRect(
                                            borderRadius: BorderRadius.circular(15),
                                            child: Image.network(provider.newsModelList[index].newsImg)
                                        ),
                                        Positioned(
                                          left: 0,
                                          right: 0,
                                          bottom: 0,
                                          child: Container(
                                            padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(15),
                                                gradient: LinearGradient(
                                                  colors: [Colors.black12.withOpacity(0),Colors.black],
                                                  begin: Alignment.topCenter,
                                                  end: Alignment.bottomCenter,

                                                )
                                            ),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(provider.newsModelList[index].newsHead,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 18
                                                  ),),
                                                Text(provider.newsModelList[index].newsDesc.length > 50 ? "${provider.newsModelList[index].newsDesc.substring(0,50)}......": provider.newsModelList[index].newsDesc,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 11
                                                  ),),

                                              ],
                                            ),
                                          ) ,
                                        )
                                      ],
                                    )
                                ),
                              )

                          );
                        }catch (e){return Container();};
                      });
                }
            ),
          )

          ],
        ),
    ]
      ),
      ),
      ),
    );

  }
}


