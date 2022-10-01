class newsQueryModel{
  late String newsHead;
  late String newsDesc;
  late String newsImg;
  late String newsUrl;



  newsQueryModel({this.newsHead = "Headline", this.newsDesc = "Description", this.newsImg = "some img url", this.newsUrl="some url"});
  factory newsQueryModel.fromMap(Map news){
    return newsQueryModel(
      newsHead : news ["title"],
      newsDesc: news ["description"],
      newsImg: news ["urlToImage"],
      newsUrl: news ["url"],
    );
  }
}