class ContactModel {

  late String name;
  late String email;
  late String mobileNumber;
  late String imageUrl;
  late int id;
 // late int isBanned;
  late int isActive;
  late String updatedAt;
  ContactModel({required this.name,required this.email,required
  this.mobileNumber,required this.id,
   // required this.imagePath,

    required this.updatedAt,
  required this.imageUrl , required this.isActive});

  factory ContactModel.fromJson(Map<String, dynamic> json){

    return ContactModel(name: json["name"], email: json["email"],
        id: json["id"],
        mobileNumber: json["mobile_number"],
        updatedAt: json["updated_at"],
        //isBanned: json["is_banned"],
        imageUrl: json["image_url"]!=null?json["image_url"]:"",
        isActive: json["is_active"]);

  }
}