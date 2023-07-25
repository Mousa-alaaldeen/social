class ChatModel {
  String? dateTime;
  String? reseiverId;
  String? senderId;
  String? text;

  ChatModel({
    this.text,
    this.dateTime,
    this.senderId,
    this.reseiverId,
  });
  ChatModel.fromJson(Map<String, dynamic> json) {
    text = json['text'];

    reseiverId = json['reseiverId'];
    dateTime = json['dartTime'];

    senderId = json['senderId'];
  }
  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'reseiverId': reseiverId,
      'dartTime': dateTime,
      'senderId': senderId,
    };
  }
}
