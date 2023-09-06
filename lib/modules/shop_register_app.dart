import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubit/shopAppRegister/cubit.dart';
import 'package:social_app/cubit/shopAppRegister/states.dart';
import 'package:social_app/layout/social_layout.dart';
import 'package:social_app/local/cache_helper.dart';
import 'package:social_app/modules/login_screen.dart';
import 'package:social_app/shared_componant/reuseable_componant.dart';

class SocialRegisterScreen extends StatelessWidget {
  const SocialRegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController nameController = TextEditingController();
    var formKey = GlobalKey<FormState>();
    return BlocProvider(
      create: (context) => SocialRegisterCubit(),
      child: BlocConsumer<SocialRegisterCubit, SocialAppRegisterStates>(
        listener: (context, state) {
          if (state is SocialAppUserCreateSuccessState) {
navigateAndFinish(context, SocialLoginScreen());

          }
          if (state is SocialAppRegisterErrorState) {
            showToast(massage: state.message);
          }

        },
        builder: (context, state) => Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 100.0,
                    ),
                    Text(
                      "Register",
                      style: Theme.of(context).textTheme.headline5,
                    ),
                    const SizedBox(height: 20.0,),

                    Text(
                      "Register now to Communicate with your friends",
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(color: Colors.grey),
                    ),
                    const SizedBox(
                      height: 50.0,
                    ),
                    defaultTextFormFiled(
                        controller: nameController,
                        type: TextInputType.name,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "name can't be Empty";
                          }
                        },
                        prefix: Icons.person,
                        label: "name"),
                    defaultTextFormFiled(
                        controller: emailController,
                        type: TextInputType.emailAddress,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Email can't be Empty";
                          }
                        },
                        prefix: Icons.email,
                        label: "Email"),
                    defaultTextFormFiled(

                        controller: passwordController,
                        type: TextInputType.visiblePassword,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Password can't be Empty";
                          }
                        },
                        prefix: Icons.security,
                        label: "password",
                        suffixPressed: () {
                          SocialRegisterCubit.get(context).changeIconVisibility();
                        },
                        obscure: SocialRegisterCubit.get(context).isSecure,
                        suffix: SocialRegisterCubit.get(context).suffix),
                    defaultTextFormFiled(
                        onSubmitted: (value) {
                          if (formKey.currentState!.validate()) {
                            SocialRegisterCubit.get(context).userRegister(
                                name: nameController.text,
                                email: emailController.text,
                                password: passwordController.text,
                                phone: phoneController.text);
                          }
                        },
                        controller: phoneController,
                        type: TextInputType.phone,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "phone can't be Empty";
                          }
                        },
                        prefix: Icons.phone,
                        label: "phone"),
                    ConditionalBuilder(
                      builder: (context) => defaultBottom(
                          text: 'Register',
                          context: context,
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              SocialRegisterCubit.get(context).userRegister(
                                name: nameController.text,
                                phone: phoneController.text,
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          }),
                      condition: state is !SocialAppRegisterLoadingState,
                      fallback: (context) =>
                          const Center(child: CircularProgressIndicator()),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
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
