class ShopLoginModle{
  bool? status;
  String? message;
  UserData? data;

  ShopLoginModle.fromJSON(Map<String , dynamic> json)
  {
    status = json["status"];
    message = json["message"];
    data = json["data"] != null ? UserData.fromJSON(json["data"]) : null;
  }
}

class UserData {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  int? points;
  int? credit;
  String? token;

  UserData.fromJSON(Map<String , dynamic> json)
  {
    id = json["id"];
    name = json["name"];
    email = json["email"];
    phone = json["phone"];
    image = json["image"];
    points = json["points"];
    credit = json["credit"];
    token = json["token"];
  }
}