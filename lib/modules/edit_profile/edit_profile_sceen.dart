import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/cubit/social_cubit/cubit.dart';
import 'package:social_app/cubit/social_cubit/states.dart';
import 'package:social_app/shared_componant/reuseable_componant.dart';

import '../../styles/icon_broken.dart';

class EditProfileScreen extends StatelessWidget {
  EditProfileScreen({Key? key}) : super(key: key);
  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialCubitStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = SocialCubit.get(context).userModel;
        var profileImage = SocialCubit.get(context).profileImage;
        var coverImage = SocialCubit.get(context).coverImage;
        nameController.text = "${model?.name}";
        bioController.text = "${model?.bio}";
        phoneController.text = "${model?.phone}";
        return Scaffold(
          appBar:
              defaultAppBar(context: context, title: "Edit Profile", actions: [
            TextButton(
                onPressed: () {
                  SocialCubit.get(context).updateUser(
                      name: nameController.text,
                      phone: phoneController.text,
                      bio: bioController.text);
                },
                child: Text("UPDATE"))
          ]),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (state is UpdateUserDataLoadingState)
                    LinearProgressIndicator(),
                  if (state is! UpdateUserDataLoadingState)
                    Container(
                      height: 180,
                      width: double.infinity,
                      child: Align(
                        alignment: AlignmentDirectional.topCenter,
                        child: Stack(
                          children: [
                            Stack(
                              alignment: AlignmentDirectional.topEnd,
                              children: [
                                Container(
                                  height: 120,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(5.0),
                                        topRight: Radius.circular(5.0)),
                                    image: DecorationImage(
                                        image: coverImage == null
                                            ? NetworkImage("${model?.cover}")
                                            : FileImage(coverImage)
                                                as ImageProvider,
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 5.0, left: 5.0),
                                  child: CircleAvatar(
                                    child: CircleAvatar(
                                      child: Center(
                                          child: IconButton(
                                              onPressed: () {
                                                SocialCubit.get(context)
                                                    .getCoverImage()
                                                    .then((value) {})
                                                    .catchError((error) {
                                                  print(error.toString());
                                                });
                                              },
                                              icon: Icon(IconBroken.Camera))),
                                      maxRadius: 20,
                                    ),
                                    maxRadius: 22,
                                    backgroundColor: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                  ),
                                )
                              ],
                            ),
                            Align(
                              alignment: AlignmentDirectional.bottomCenter,
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Stack(
                                  alignment: AlignmentDirectional.bottomEnd,
                                  children: [
                                    CircleAvatar(
                                      maxRadius: 59,
                                      backgroundColor: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                      child: CircleAvatar(
                                        maxRadius: 55,
                                        backgroundImage: profileImage == null
                                            ? NetworkImage("${model?.image}")
                                            : FileImage(profileImage)
                                                as ImageProvider,
                                      ),
                                    ),
                                    CircleAvatar(
                                      child: CircleAvatar(
                                        child: Center(
                                            child: IconButton(
                                                onPressed: () {
                                                  SocialCubit.get(context)
                                                      .getProfileImage()
                                                      .then((value) {})
                                                      .catchError((error) {
                                                    print(error.toString());
                                                  });
                                                },
                                                icon: const Icon(
                                                    IconBroken.Camera))),
                                        maxRadius: 20,
                                      ),
                                      maxRadius: 22,
                                      backgroundColor: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  if (coverImage != null || profileImage != null)
                    Row(
                      children: [
                        if (profileImage != null)
                          Expanded(
                              child: Column(
                            children: [
                              defaultBottom(
                                  context: context,
                                  text: 'Update Profile Photo',
                                  onPressed: () {
                                    SocialCubit.get(context).uploadProfileImage(
                                        name: nameController.text,
                                        phone: phoneController.text,
                                        bio: bioController.text);
                                  }),
                              if (state is UpdateUserDataLoadingState)
                                const SizedBox(
                                  height: 5.0,
                                ),
                              if (state is UpdateUserDataLoadingState)
                                const LinearProgressIndicator(),
                            ],
                          )),
                        const SizedBox(
                          width: 5.0,
                        ),
                        if (coverImage != null)
                          Expanded(
                              child: Column(
                            children: [
                              defaultBottom(
                                  context: context,
                                  text: 'Update Cover Photo',
                                  onPressed: () {
                                    SocialCubit.get(context).uploadCoverImage(
                                        name: nameController.text,
                                        phone: phoneController.text,
                                        bio: bioController.text);
                                    print("DOne");
                                  }),
                              if (state is UpdateUserDataLoadingState)
                                const SizedBox(
                                  height: 5.0,
                                ),
                              if (state is UpdateUserDataLoadingState)
                                const LinearProgressIndicator(),
                            ],
                          )),
                      ],
                    ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        Form(
                            key: formKey,
                            child: Column(
                              children: [
                                defaultTextFormFiled(
                                  controller: nameController,
                                  type: TextInputType.name,
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      print('name Can not be empty');
                                    }
                                  },
                                  prefix: IconBroken.User,
                                  label: " name",
                                ),
                                defaultTextFormFiled(
                                    controller: bioController,
                                    type: TextInputType.text,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        print('bio Can not be empty');
                                      }
                                    },
                                    prefix: IconBroken.Info_Circle,
                                    label: "  bio"),
                                defaultTextFormFiled(
                                    controller: phoneController,
                                    type: TextInputType.phone,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        print('phone Can not be empty');
                                      }
                                    },
                                    prefix: Icons.phone,
                                    label: "  phone"),
                              ],
                            )),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
