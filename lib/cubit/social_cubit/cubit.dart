import 'dart:ffi';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/cubit/shopAppLogin/states.dart';
import 'package:social_app/cubit/social_cubit/states.dart';
import 'package:social_app/models/new_post_model.dart';
import 'package:social_app/models/send_message_model.dart';
import 'package:social_app/models/user_create_model.dart';
import 'package:social_app/modules/chats/chats_screen.dart';
import 'package:social_app/modules/feeds/feeds_screen.dart';
import 'package:social_app/modules/new_post/new_post.dart';
import 'package:social_app/modules/settings/settings_screen.dart';
import 'package:social_app/modules/users/users_screen.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import '../../shared_componant/constant.dart';

class SocialCubit extends Cubit<SocialCubitStates> {
  SocialCubit() : super(InitialSocialCubitState());

  static SocialCubit get(context) => BlocProvider.of(context);

  UserCreateModel? userModel;
  void getUserData() {
    emit(GetUserDataLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      userModel = UserCreateModel.fromJson(value.data());
      print(userModel?.name);
      emit(GetUserDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetUserDataErrorState());
    });
  }

  int currentIndex = 0;
  List<Widget> screens = [
    const FeedsScreen(),
    const ChatsScreen(),
    const NewPostScreen(),
    const UsersScreen(),
    const SettingsScreen(),
  ];

  List<String> names = [
    'Feeds',
    'Chats',
    'Posts',
    'Users',
    'Settings',
  ];

  void changeScreensCurrentIndex(int index) {
    if (index == 1) {
      getAllUsers();
    }
    if (index == 2) {
      emit(AddPostState());
    } else {
      currentIndex = index;
      print(currentIndex);
      emit(ChangeCurrentIndexState());
    }
  }

  final ImagePicker _picker = ImagePicker();
  File? profileImage;
  Future<void> getProfileImage() async {
    final profile =
        await _picker.pickImage(source: ImageSource.gallery).then((value) {
      profileImage = File(value!.path);
      print(value.path);
      emit(GetprofileImageSuccessState());
    }).catchError((error) {
      emit(GetprofileImageeErrorState());
    });
  }

  File? coverImage;
  Future<void> getCoverImage() async {
    final cover =
        await _picker.pickImage(source: ImageSource.gallery).then((value) {
      coverImage = File(value!.path);
      print(value.path);
      emit(GetCoverImageSuccessState());
    }).catchError((error) {
      emit(GetCoverImageErrorState());
    });
  }

  void uploadProfileImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUser(name: name, phone: phone, bio: bio, image: value.toString());
      }).catchError((error) {
        print(error.toString());

        emit(GetLinkUploadProfileImageErrorState());
      });
      emit(UploadProfileImageSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(UploadProfileImageErrorState());
    });
  }

  void uploadCoverImage({
    required String name,
    required String phone,
    required String bio,
  }) {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        updateUser(name: name, phone: phone, bio: bio, cover: value.toString());
      }).catchError((error) {
        print(error.toString());
        emit(GetLinkUploadCoverImageErrorState());
      });
      emit(UploadCoverImageSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(UploadProfileImageErrorState());
    });
  }

  void updateUser({
    required String name,
    required String phone,
    required String bio,
    String? image,
    String? cover,
  }) {
    emit(UpdateUserDataLoadingState());
    UserCreateModel model = UserCreateModel(
        name,
        phone,
        userModel!.email,
        userModel!.uId,
        image ?? userModel!.image,
        cover ?? userModel!.cover,
        bio,
        userModel!.isEmailVerified);
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      emit(UpdateUserDataErrorState());
    });
  }

  File? postImage;
  Future<void> getPostImage() async {
    final postIm =
        await _picker.pickImage(source: ImageSource.gallery).then((value) {
      postImage = File(value!.path);
      print(value.path);
      emit(GetNewPostImageSuccessState());
    }).catchError((error) {
      emit(GetNewPostImageErrorState());
    });
  }

  void uploadPostImage({
    required String dateTime,
    required String text,
  }) {
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createPost(image: value, dateTime: dateTime, text: text);
      }).catchError((error) {
        print(error.toString());
        emit(GetLinkUploadPostImageErrorState());
      });
    }).catchError((error) {
      print(error.toString());
      emit(CreatePostImageErrorState());
    });
  }

  void removePostImage() {
    postImage = null;
    emit(RemovePostImageState());
  }

  void createPost({
    String? image,
    required String dateTime,
    required String text,
  }) {
    emit(CreatePostImageLoadingState());
    NewPostModel model = NewPostModel(
        name: userModel!.name,
        uId: userModel!.uId,
        image: userModel!.image,
        dateTime: dateTime,
        postImage: image,
        text: text);

    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      emit(CreatePostImageSuccessState());
    }).catchError((error) {
      emit(CreatePostImageErrorState());
    });
  }

  List<NewPostModel> posts = [];
  List<String> postLikes = [];
  List<int> likes = [];
  static var xTaps = 1;
  void getPosts() {
    emit(GetUserPostsLoadingState());

    FirebaseFirestore.instance.collection('posts').get().then((value) {
      value.docs.forEach((element) {
        postLikes.add(element.id);
        posts.add(NewPostModel.fromJson(element.data()));
      });
      emit(GetUserPostsSuccessState());
    }).catchError((error) {
      emit(GetUserPostsErrorState());
    });
  }

  void likePosts(String postId) {
    emit(GetLikesLoadingState());
    FirebaseFirestore.instance.collection('likes').get().then((value) {
      likes.add(value.docs.length);
      print(likes);
      FirebaseFirestore.instance
          .collection('posts')
          .doc(postId)
          .collection('Likes')
          .doc(userModel?.uId)
          .set({'like': true}).then((value) {
        emit(GetLikesSuccessState());
      }).catchError((error) {
        emit(GetLikesErrorState());
      });
    }).catchError((error) {});
  }

  //AllUser
  List<UserCreateModel> users = [];
  void getAllUsers() {
    emit(GetAllUserLoadingState());
    if (users.isEmpty) {
      FirebaseFirestore.instance.collection('users').get().then((value) {
        value.docs.forEach((element) {
          if (element.data()['uId'] != userModel!.uId) {
            users.add(UserCreateModel.fromJson(element.data()));
          }
        });
        emit(GetAllUserSuccessState());
      }).catchError((error) {
        emit(GetAllUserErrorState());
      });
    }
  }

  void sendMessages({
    required String? receiverId,
    required String dateTime,
    required String text,
  }) {
    MessageModel model =
        MessageModel(userModel?.uId, receiverId, dateTime, text);

    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel?.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageErrorState());
    });

    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel?.uId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error) {
      emit(SendMessageErrorState());
    });
  }

  List<MessageModel> message = [];
  
  void getMessages({
    required String? receiverId,
}){
    FirebaseFirestore.instance.collection('users').doc(userModel!.uId).collection('chats').doc(receiverId).collection('messages').orderBy('dateTime').snapshots().listen((event) {
      message = [];

      event.docs.forEach((element) {
       message.add(MessageModel.fromJson(element.data()));


     });
      emit(GetMessagesSuccessState());
    });
  }


}
