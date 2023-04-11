class SocialUserModel {
  late String ? name;
  late String ? email;
  late String ? phone;
  late String ? uId;
  late String ? image;
  late bool ? isEmailVerified;
  late String ? bio;
  late String ? coverImage;

  SocialUserModel({
    required this.name ,
    this.email ,
    this.phone ,
    this.uId,
    this.isEmailVerified,
    this.image,
    required this.bio,
    this.coverImage,
  });

  SocialUserModel.fromJson(Map<String , dynamic> json){
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    uId = json['uId'];
    isEmailVerified = json['isEmailVerified'];
    image = json['image'];
    bio= json['bio'];
    coverImage = json['coverImage'];
  }

  Map<String , dynamic> toMap(){
    return {
      'name':name,
      'email':email,
      'phone':phone,
      'uId':uId,
      'isEmailVerified':isEmailVerified,
      'image':image,
      'bio':bio,
      'coverImage':coverImage,
    };
  }
}