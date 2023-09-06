import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubit/social_cubit/cubit.dart';
import 'package:social_app/cubit/social_cubit/states.dart';
import 'package:social_app/shared_componant/reuseable_componant.dart';
import 'package:social_app/styles/colors.dart';
import 'package:social_app/styles/icon_broken.dart';

class NewPostScreen extends StatelessWidget {
  const NewPostScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var textController = TextEditingController();

    return BlocConsumer<SocialCubit,SocialCubitStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
       var postImage= SocialCubit.get(context).postImage;
        return Scaffold(
        appBar: defaultAppBar(
            context: context,
            title: "Create Post",
            actions: [TextButton(onPressed: () {
              var date =DateTime.now().toLocal();

              if(SocialCubit.get(context).postImage == null){
                SocialCubit.get(context).createPost( dateTime: date.toString(), text: textController.text);
              }if(SocialCubit.get(context).postImage != null){
                SocialCubit.get(context).uploadPostImage( dateTime: date.toString(), text: textController.text);

              }

            }, child: Text("Post"))]),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
if(state is CreatePostImageLoadingState)
              LinearProgressIndicator(),
              Row(
                children: [
                  const CircleAvatar(
                    maxRadius: 25,
                    backgroundImage: NetworkImage(
                        "https://img.freepik.com/free-photo/smiling-happily-with-hand-hip-confident_1194-400304.jpg?w=2000"),
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Osama Mahrous",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  ?.copyWith(height: 1.4),
                            ),
                            const Icon(
                              Icons.check_circle,
                              color: Colors.blue,
                              size: 16,
                            ),
                          ],
                        ),
                        Text(
                          "January 21, 2022 at 8:39 AM ",
                          style: Theme.of(context)
                              .textTheme
                              .caption
                              ?.copyWith(height: 1.3),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.more_horiz,
                        size: 16,
                      )),
                ],
              ),
              Expanded(
                flex: 1,

                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: TextFormField(
                    controller: textController,
                    decoration: InputDecoration(
                        label: Text("What's in your mind"),
                        border: InputBorder.none),
                  ),
                ),
              ),
              if(SocialCubit.get(context).postImage != null)
              Expanded(
                flex: 1,
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Container(

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5.0),
                            topRight: Radius.circular(5.0)),
                        image: DecorationImage(
                            image: postImage == null? NetworkImage(""):FileImage(postImage) as ImageProvider,
                            fit: BoxFit.cover),
                      ),
                      height: 250.0,
                      width: double.infinity,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: CircleAvatar(child: IconButton(onPressed: (){SocialCubit.get(context).removePostImage();}, icon: Icon(IconBroken.Close_Square))),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: TextButton(
                        onPressed: () {
                          SocialCubit.get(context).getPostImage();

                        },
                        child: Row(
                          children: [
                            Icon(
                              IconBroken.Image,
                              color: defaultColor,
                            ),
                            SizedBox(
                              width: 8.0,
                            ),
                            Text(
                              "add photo",
                              style: TextStyle(color: defaultColor),
                            ),
                          ],
                        ),
                      )),
                  Expanded(
                    child: TextButton(onPressed: () {}, child: Text("# tags")),
                  ),
                ],
              )
            ],
          ),
        ),
      );
      },

    );
  }
}
