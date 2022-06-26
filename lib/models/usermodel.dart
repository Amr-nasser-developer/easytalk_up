class UserModel{
  late String name;
  late String email;
  late String mobileNumber;
  late String id;
  late int idModify;
  late String imagePath="";

UserModel({required this.name,required this.mobileNumber,required this.email,required this.id,required this.imagePath,required this.idModify});

  factory UserModel.fromJson(Map<String, dynamic> json){

    return UserModel(mobileNumber: json["mobile_number"],imagePath: json["image_url"]==null?"":json["image_url"],
        name: json["name"],email: json["email"],id: json["id"].toString(),idModify: json["id"]);
  }


}