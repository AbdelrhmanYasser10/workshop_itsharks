class UserModel{
  late String username;
  late String email;
  late String id;
  late String imageLink;


  UserModel.fromJson(Map<String,dynamic> json){
    username = json["username"];
    email = json["email"];
    id = json["id"];
    imageLink = json["imageLink"];
  }



}