class CommentModel {
  String? name;
  String? dateTime;
  String? image;
  String? uId;
  String? text;

  CommentModel({
    this.text,
    this.name,
    this.dateTime,
    this.uId,
    this.image,
  });
  CommentModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    text = json['text'];

    image = json['image'];
    dateTime = json['dartTime'];

    uId = json['uId'];
  }
  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'image': image,
      'name': name,
      'dartTime': dateTime,
      'uId': uId,
    };
  }
}
