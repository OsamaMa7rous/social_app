import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:social_app/cubit/shopAppLogin/states.dart';


class SocialAppCubit extends Cubit<SocialAppStates> {
  SocialAppCubit() : super(InitialAppState());

  static SocialAppCubit get(context) => BlocProvider.of(context);
  void userLogin({
    required String email,
    required String password,
  }) {

    emit(SocialAppLoginLoadingState());
  FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password).then((value) {
print(value.user?.email);
print(value.user?.uid);
    emit(SocialAppLoginSuccessState(value.user!.uid));

  }).catchError((error){

    emit(SocialAppLoginErrorState(error.toString()));

  });
  }


  bool isSecure = true;
  IconData suffix = Icons.visibility;
  VoidCallback? changeIconVisibility() {
    isSecure = !isSecure;
    suffix = isSecure ? Icons.visibility : Icons.visibility_off_rounded;
    emit(SocialAppChangeIconVisibilityState());
  }

  }
