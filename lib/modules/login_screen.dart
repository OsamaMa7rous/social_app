import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubit/shopAppLogin/cubit.dart';
import 'package:social_app/cubit/shopAppLogin/states.dart';
import 'package:social_app/layout/social_layout.dart';
import 'package:social_app/local/cache_helper.dart';
import 'package:social_app/modules/shop_register_app.dart';
import 'package:social_app/shared_componant/reuseable_componant.dart';

import '../shared_componant/constant.dart';


class SocialLoginScreen extends StatelessWidget {
  SocialLoginScreen({Key? key}) : super(key: key);
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (BuildContext context) => SocialAppCubit(),
      child: BlocConsumer<SocialAppCubit, SocialAppStates>(
        listener: (context, state) {
if(state is SocialAppLoginSuccessState){
  CacheHelper.saveData(key: 'uId', value: state.uId).then((value) {
    navigateAndFinish(context, const SocialLayout());

  });
}
        },
        builder: (context, state) => Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 60.0,
                    ),
                    Text(
                      "LOGIN",
                      style: Theme.of(context).textTheme.headline5,
                    ),
                     Text(
                      "login now to Communicate with your friends",
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(color: Colors.grey),
                    ),
                    const SizedBox(
                      height: 50.0,
                    ),
                    defaultTextFormFiled(
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null) {
                            return "Email can't be Empty";
                          }
                        },
                        prefix: Icons.email,
                        label: "Email"),
                    defaultTextFormFiled(
                        onSubmitted: (value) {
                          if (formKey.currentState!.validate()) {
                            SocialAppCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text);
                          }
                        },
                        controller: passwordController,
                        type: TextInputType.visiblePassword,
                        validator: (value) {
                          if (value == null) {
                            return "Password can't be Empty";
                          }
                        },
                        prefix: Icons.security,
                        label: "password",
                        suffixPressed: () {
                          SocialAppCubit.get(context).changeIconVisibility();
                        },
                        obscure: SocialAppCubit.get(context).isSecure,
                        suffix: SocialAppCubit.get(context).suffix),
                    ConditionalBuilder(
                      condition: state != SocialAppLoginLoadingState(),
                      builder: (context) => defaultBottom(
                          text: 'Login',
                          context: context,
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              SocialAppCubit.get(context).userLogin(
                                  email: emailController.text,
                                  password: passwordController.text);
                            }
                          }),
                      fallback: (context) =>
                          const Center(child: CircularProgressIndicator()),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Don't Have an account? ",
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                        TextButton(
                            onPressed: () {
                              navigateTo(context,  SocialRegisterScreen());
                            },
                            child: const Text("Register Now"))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
