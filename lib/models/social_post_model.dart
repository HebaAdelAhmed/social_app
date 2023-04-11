class SocialPostModel {
  late String ? name;
  late String ? uId;
  late String ? image;
  late String ? dateTime;
  String ? textPost;
  String ? imagePost;

  SocialPostModel({
    required this.name ,
    this.uId,
    this.image,
    this.dateTime,
    this.textPost,
    this.imagePost,
  });

  SocialPostModel.fromJson(Map<String , dynamic> json){
    name = json['name'];
    uId = json['uId'];
    image = json['image'];
    dateTime= json['dateTime'];
    textPost = json['textPost'];
    imagePost = json['imagePost'];
  }

  Map<String , dynamic> toMap(){
    return {
      'name':name,
      'textPost':textPost,
      'dateTime':dateTime,
      'uId':uId,
      'imagePost':imagePost,
      'image':image,
    };
  }
}