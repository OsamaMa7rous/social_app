import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'package:social_app/cubit/shopAppRegister/states.dart';

import '../../models/user_create_model.dart';



class SocialRegisterCubit extends Cubit<SocialAppRegisterStates> {
  SocialRegisterCubit() : super(InitialAppRegisterState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);
  void userRegister({

    required String name,
    required String phone,
    required String email,
    required String password,
  }) {
    emit(SocialAppRegisterLoadingState());

    FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).then((value) {
      print(value.user?.email);
      print(value.user?.uid);
      userCreate(name: name, phone: phone, email: email, uId: value.user!.uid);
    }).catchError((error){

      emit(SocialAppRegisterErrorState(error.toString()));

    });
  }


  void userCreate({

    required String name,
    required String phone,
    required String email,
     String image = 'https://st.depositphotos.com/2101611/3925/v/600/depositphotos_39258143-stock-illustration-businessman-avatar-profile-picture.jpg',
     String cover = 'https://cdn.vox-cdn.com/thumbor/9qN-DmdwZE__GqwuoJIinjUXzmk=/0x0:960x646/1200x900/filters:focal(404x247:556x399)/cdn.vox-cdn.com/uploads/chorus_image/image/63084260/foodlife_2.0.jpg',
     String bio = ' Write Your bio ...',
      required String uId,
  }) {
    UserCreateModel model =UserCreateModel(name, phone, email, uId,image,cover,bio, true);
    FirebaseFirestore.instance.collection('users').doc(uId).set(model.toMap()).then((value) {

      emit(SocialAppUserCreateSuccessState());

    }).catchError((error){

      emit(SocialAppUserCreateErrorState(error.toString()));

    });
  }

  bool isSecure = true;
  IconData suffix = Icons.visibility;
  VoidCallback? changeIconVisibility() {
    isSecure = !isSecure;
    suffix = isSecure ? Icons.visibility : Icons.visibility_off_rounded;
    emit(SocialAppChangeIconVisibilityInRegisterState());
  }

}
