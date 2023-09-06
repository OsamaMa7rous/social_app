
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubit/social_cubit/cubit.dart';
import 'package:social_app/cubit/social_cubit/states.dart';
import 'package:social_app/modules/new_post/new_post.dart';
import 'package:social_app/shared_componant/reuseable_componant.dart';
import 'package:social_app/styles/icon_broken.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialCubitStates>(
      listener: (context, state) {
        if(state is AddPostState){
          navigateTo(context, NewPostScreen());
        }

      },
      builder: (context, state) {
        var model = SocialCubit.get(context);
        return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(icon: Icon(IconBroken.Home),label: ''),
            BottomNavigationBarItem(icon: Icon(IconBroken.Chat),label: ''),
            BottomNavigationBarItem(icon: Icon(IconBroken.Upload),label: 'add post',),
            BottomNavigationBarItem(icon: Icon(IconBroken.Location),label: ''),
            BottomNavigationBarItem(icon: Icon(IconBroken.Setting),label: ''),
          ],
          currentIndex: model.currentIndex,
          onTap: (index){
            model.changeScreensCurrentIndex(index);
          },
        ),
        appBar: AppBar(
          actions: [
            IconButton(onPressed: (){}, icon: const Icon(IconBroken.Search)),

            IconButton(onPressed: (){}, icon: const Icon(IconBroken.Setting)),
          ],
          title:Text(model.names[model.currentIndex]),
        ),
        body: model.screens[model.currentIndex],
      );
      },
    );
  }
}
