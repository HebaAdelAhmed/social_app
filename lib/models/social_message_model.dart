class SocialMessageModel {
  late String ? senderId;
  late String ? receiverId;
  late String ? dateTime;
  late String ? text;

  SocialMessageModel({
    required this.text ,
    required this.dateTime ,
    required this.receiverId ,
    required this.senderId,
  });

  SocialMessageModel.fromJson(Map<String , dynamic> json){
    text = json['text'];
    dateTime = json['dateTime'];
    receiverId = json['receiverId'];
    senderId = json['senderId'];
  }

  Map<String , dynamic> toMap(){
    return {
      'senderId':senderId,
      'receiverId':receiverId,
      'dateTime':dateTime,
      'text':text,
    };
  }
}