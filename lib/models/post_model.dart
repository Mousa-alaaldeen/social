class PostModel {
  String? name;
  String? dartTime;
  String? image;
  String? uId;
  String? text;
  String? postImage;

  PostModel({
    this.text,
    this.name,
    this.dartTime,
    this.uId,
    this.postImage,
    this.image,
  });
  PostModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    text = json['text'];
    postImage = json['postImage'];
    image = json['image'];
    dartTime = json['dartTime'];

    uId = json['uId'];
  }
  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'image': image,
      'postImage': postImage,
      'name': name,
      'dartTime': dartTime,
      'uId': uId,
    };
  }
}
