class UserCreateModel {
  String? name;
    String? phone;
    String? email;
    String? uId;
    String? image;
    String? cover;
    String? bio;
    bool isEmailVerified =false;

  UserCreateModel.few({this.name, this.phone,this.uId,required this.image,this.cover,this.bio});
  UserCreateModel(this.name, this.phone, this.email, this.uId,this.image,this.cover,this.bio,this.isEmailVerified);
  UserCreateModel.fromJson(Map<String,dynamic>?json){
    name=json!['name'] ;
    phone=json['phone'] ;
    email=json['email'];
    uId=json['uId'] ;
    image=json['image'] ;
    cover=json['cover'];
    bio=json['bio'];
    isEmailVerified=json['isEmailVerified'];

  }
  Map<String,dynamic> toMap(){
  return {
    'name': name,
    'phone':phone,
    'email': email,
    'uId': uId,
    'image': image,
    'cover': cover,
    'bio': bio,
    'isEmailVerified': isEmailVerified,
  };
  }

}