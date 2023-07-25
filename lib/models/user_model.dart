class UserModel {
  String? name;
  String? phone;
  String? email;
  String? image;
  String? cover;
  String? uId;
    String? bio;
  // bool? isEmailVerified;
  UserModel({
    this.email,
    this.name,
    this.phone,
    this.uId,
    this.cover,
    this.image,
    // this.isEmailVerified,
    this.bio,
  });
  UserModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
     bio = json['bio'];
    cover = json['cover'];
    image = json['image'];
    email = json['email'];
    phone = json['phone'];
    uId = json['uId'];
    // isEmailVerified = json['isEmailVerified'];
  }
  Map<String, dynamic> toMap() {
    return {
      'bio':bio,
      'image': image,
      'cover': cover,
      'name': name,
      'phone': phone,
      'email': email,
      'uId': uId,
      // 'isEmailVerified': isEmailVerified,
    };
  }
}
