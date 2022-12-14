import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart';
import 'package:untitled/screens/category.dart';
import 'package:untitled/newsProvider.dart';
import '../model.dart';
import 'newsview.dart';

class DashBoard extends StatefulWidget {
  const DashBoard({Key? key}) : super(key: key);

  @override
  State<DashBoard> createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard> {
  List<String> navBarItem = ["Home","Technology","Pakistan", "Sports","Finance"];

  @override
  void initState()
  {
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
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 768){
            return SingleChildScrollView(
              child: buildHomeScreenLayoutPortrait(context),

            );
          }
          else{

            return buildHomeScreenLayoutLandscape(context);

          }
        }
      ),
    );
  }

  Container buildHomeScreenLayoutPortrait(BuildContext context) {
    return Container(
              child: Column(
                children: [
                  SizedBox(height: 10),
                  //NavBar
                  Container(
                    color: Colors.black12,
                    padding: EdgeInsets.symmetric(vertical: 3),
                    height: 50,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: navBarItem.length,
                      itemBuilder: (context ,index ){
                        return InkWell(
                          onTap: (){
                            if (navBarItem[index]!= "Home")
                            {
                              Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryPage(query: navBarItem[index])));
                            }
                          },
                          child: Container(

                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: Colors.blue.shade900,

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
                  //carousel
                  ChangeNotifierProvider<newsProvider>(
                    create: (context)=> newsProvider(),
                    child: Consumer<newsProvider>(
                        builder: (context,provider,child){
                          provider.getSliderNewsByQuery("General");
                          return Container(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            child: provider.isLoading ?

                            Container(
                                height: 200,
                                width: 200,
                                child: Center(child: CircularProgressIndicator())) :
                            CarouselSlider(
                              options: CarouselOptions(
                                  height: 190,
                                  // aspectRatio: 16/9,
                                  autoPlay: true,
                                  enlargeCenterPage: true
                              ),
                              items: provider.newsModelListSlider.map((instance){
                                return Builder(builder: (BuildContext context) {
                                  try{
                                    return Container(
                                      child: InkWell(
                                        onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>NewsView(instance.newsUrl)));},
                                        child: Card(
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(15),
                                            ),
                                            elevation: 1.0,
                                            child: Stack(
                                              children: [
                                                ClipRRect(
                                                    borderRadius: BorderRadius.circular(15),
                                                    child: Image.network(instance.newsImg,fit: BoxFit.fitHeight,height:double.infinity ,)
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
                                                        // newsModelList[index].newsDesc.length > 50 ? "${newsModelList[index].newsDesc.substring(0,50)}......": newsModelList[index].newsDes
                                                        Text(instance.newsHead.length > 80? "${instance.newsHead.substring(0,80)}.....": instance.newsHead,
                                                          style: TextStyle(
                                                              color: Colors.white,
                                                              fontWeight: FontWeight.bold,
                                                              fontSize: 18
                                                          ),),

                                                      ],
                                                    ),
                                                  ) ,
                                                )
                                              ],
                                            )
                                        ),
                                      ),
                                    );
                                  }catch (e){return Container();}
                                }
                                );
                              }).toList(),
                            ),
                          );
                        }
                    ),
                  ),

                  //news Card
                  Column(

                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(18, 10, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Latest News: ",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,


                              ),),
                          ],
                        ),
                      ),
                      ChangeNotifierProvider<newsProvider>(
                      create: (context)=> newsProvider(),
                      child: Consumer<newsProvider>(
                      builder: (context,provider,child){
                      provider.getLatestNewsByQuery("Pakistan");
                      return provider.isLoading ?
                      Container(
                          height: MediaQuery.of(context).size.height - 400,
                          child: Center(child: CircularProgressIndicator())) :

                      ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 7,

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
                            }catch (e){return Container();}
                          });
                      }
                      ),
                      ),

                    ],
                  ),
                  //show more button
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 15),
                    child: ElevatedButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryPage(query: "More News")));
                    }, child: Text("Show More"),

                    ),
                  )

                ],

              ),
            );
  }

  Column buildHomeScreenLayoutLandscape(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(height: 10),
        //NavBar
        //carousel
          Column(
            children: [
              tabsLandscape(),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.5,
                    height: MediaQuery.of(context).size.height / 1.75,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisSize : MainAxisSize.min ,
                          children: [
                            Container(
                              padding: const EdgeInsets.fromLTRB(18, 10, 0, 0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: const [
                                  Text("Latest News: ",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),),
                                ],
                              ),
                            ),

                            //newsCard Provider
                            ChangeNotifierProvider<newsProvider>(
                            create: (context)=> newsProvider(),
                            child: Consumer<newsProvider>(
                            builder: (context,provider,child){
                            provider.getLatestNewsByQuery("Pakistan");
                            return provider.isLoading ?
                            SizedBox(
                                height: MediaQuery.of(context).size.height - 200,
                                child: const Center(child: CircularProgressIndicator())) :
                            ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: 7,
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
                                                            style: const TextStyle(
                                                                color: Colors.white,
                                                                fontWeight: FontWeight.bold,
                                                                fontSize: 18
                                                            ),),
                                                          Text(provider.newsModelList[index].newsDesc.length > 50 ? "${provider.newsModelList[index].newsDesc.substring(0,50)}......": provider.newsModelList[index].newsDesc,
                                                            style: const TextStyle(
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
                                  }catch (e){return Container();}
                                });
                            }
                            ),
                            ),

                            Container(
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 15),
                              child: ElevatedButton(onPressed: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryPage(query: "More News")));
                              }, child: const Text("Show More"),

                              ),
                            )
                          ],
                        ),
                    ),
                  ),
                  //CarouselProvider

                  Container(

                  child:
                  ChangeNotifierProvider<newsProvider>(
                  create: (context)=> newsProvider(),
                  child: Consumer<newsProvider>(
                  builder: (context,provider,child){
                  provider.getSliderNewsByQuery("General");
                  return
                  provider.isLoading ?
                  Container(
                  height: 200,
                  width: 200,
                  child: const Center(child: CircularProgressIndicator())) :
                  Expanded(
                    child: CarouselSlider(
                    options: CarouselOptions(
                    height: 220,
                    // aspectRatio: 16/9,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    scrollDirection: Axis.vertical,

                    ),
                    items: provider.newsModelListSlider.map((instance){
                    return Builder(builder: (BuildContext context) {
                    try{
                    return Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Container(
                      child: InkWell(
                      onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>NewsView(instance.newsUrl)));},
                      child: Card(
                      shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                      ),
                      elevation: 1.0,
                      child: Stack(
                      children: [
                      ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(instance.newsImg,fit: BoxFit.cover,width: double.infinity,height:double.infinity ,)
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
                      // newsModelList[index].newsDesc.length > 50 ? "${newsModelList[index].newsDesc.substring(0,50)}......": newsModelList[index].newsDes
                      Text(instance.newsHead.length > 80? "${instance.newsHead.substring(0,80)}.....": instance.newsHead,
                      style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                      ),),

                      ],
                      ),
                      ) ,
                      )
                      ],
                      )
                      ),
                      ),
                      ),
                    );
                    }catch (e){return Container();}
                    }
                    );
                    }).toList(),
                    ),
                    );
                  }
                  ),
                  )

                  )],
              ),
            ],
          ),

        //news Card

        //show more button


      ],

    );
  }

  Widget tabsLandscape(){
    return Container(
      color: Colors.black12,
      padding: EdgeInsets.symmetric(vertical: 3),
      height: 50,
      child: Center(
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: navBarItem.length,
          itemBuilder: (context ,index ){
            return InkWell(
              onTap: (){
                if (navBarItem[index]!= "Home")
                {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryPage(query: navBarItem[index])));
                }
              },
              child: Container(

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: Colors.blue.shade900,

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
    );
  }
}
