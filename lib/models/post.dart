class PostModel{
  String? name;
  String? uId;
  String? image;
  String? date;
  String? text;
  String? postImage;
  List<String>? likes;

  PostModel({
    this.name,
    this.uId,
    this.image,
    this.date,
    this.text,
    this.postImage,
    this.likes,
  });

  PostModel.fromJson(Map<String,dynamic> json){
    name=json['name'];
    uId=json['uId'];
    image=json['image'];
    date=json['date'];
    text=json['text'];
    postImage=json['postImage'];
    likes=json['likes'] is Iterable ? List.from(json['likes']) : null;
  }

  Map<String,dynamic> toMap(){
    return{
      'name':name,
      'uId':uId,
      'image':image,
      'text':text,
      'postImage':postImage,
      'date':date,
      'likes':likes,
    };
  }

}