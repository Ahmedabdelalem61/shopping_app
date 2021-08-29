class CategoriesModel{
  bool staus;
  CategoriesDataModel data;
  CategoriesModel.fromJson(Map<String,dynamic> json){
    staus = json['status'];
    data = CategoriesDataModel.fromJson(json['data']);
  }
}
class CategoriesDataModel{
  int curreentPage;
  List<DataModel> data=[];
  CategoriesDataModel.fromJson(Map<String,dynamic> json){
    curreentPage =json['current_page'];
    json['data'].forEach((element) {
      data.add(DataModel.fromJson(element));
    });
  }


}
class DataModel{
  int id;
  String name;
  String image;
  DataModel.fromJson(Map<String,dynamic> json){
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}