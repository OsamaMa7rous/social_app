import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubit/social_cubit/cubit.dart';
import 'package:social_app/cubit/social_cubit/states.dart';
import 'package:social_app/models/new_post_model.dart';
import 'package:social_app/shared_componant/reuseable_componant.dart';
import 'package:social_app/styles/colors.dart';
import 'package:social_app/styles/icon_broken.dart';

class FeedsScreen extends StatelessWidget {
  const FeedsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialCubitStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = SocialCubit.get(context).posts;
        return Scaffold(
          body: ConditionalBuilder(
            fallback: (context) => Container(
              color: Colors.grey[300],
              child: Column(
                children: [
                  Card(
                    elevation: 10.0,
                    margin: const EdgeInsets.all(8.0),
                    child: Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Container(
                          child: Image.network(
                            "https://st.depositphotos.com/1743476/2514/i/600/depositphotos_25144755-stock-photo-presenting-your-text.jpg",
                            fit: BoxFit.contain,
                          ),
                          height: 150.0,
                          width: double.infinity,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            "Communicate with friends",
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  Center(
                    child: Text("No Posts Yet",
                        style: Theme.of(context)
                            .textTheme
                            .headline4
                            ?.copyWith(color: Colors.black54)),
                  )
                ],
              ),
            ),
            condition: model.isNotEmpty,
            builder: (context) => SingleChildScrollView(
              child: Container(
                color: Colors.grey[300],
                child: Column(
                  children: [
                    Card(
                      elevation: 10.0,
                      margin: const EdgeInsets.all(8.0),
                      child: Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Container(
                            child: Image.network(
                              "https://st.depositphotos.com/1743476/2514/i/600/depositphotos_25144755-stock-photo-presenting-your-text.jpg",
                              fit: BoxFit.contain,
                            ),
                            height: 150.0,
                            width: double.infinity,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              "Communicate with friends",
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ListView.separated(
                      itemBuilder: (context, index) =>
                          buildPostItems(model[index], context, index),
                      separatorBuilder: (context, index) => SizedBox(
                        height: 5.0,
                      ),
                      itemCount: model.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                    ),
                    SizedBox(
                      height: 150.0,
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

Widget buildPostItems(NewPostModel model, context, index) {
  return Card(
    elevation: 3.0,
    child: Padding(
      padding: const EdgeInsets.only(
          bottom: 3.0, top: 10.0, left: 10.0, right: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                maxRadius: 25,
                backgroundImage: NetworkImage(
                    "${SocialCubit.get(context).userModel?.image}"),
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
                          "${model.name}",
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
                      model.dateTime.toString(),
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
          Padding(
            padding: const EdgeInsets.all(6.0),
            child: Container(
              color: Colors.grey[300],
              height: 1.0,
              width: double.infinity,
            ),
          ),
          Text(
            "${model.text}",
            style: Theme.of(context).textTheme.subtitle1,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Container(
              width: double.infinity,
              child: Wrap(
                spacing: 3.0,
                children: [
                  // Container(
                  //   height: 20.0,
                  //
                  //   child: MaterialButton(
                  //       onPressed: () {},
                  //       child: Text(
                  //         "#software_development",
                  //         style: Theme.of(context).textTheme.caption?.copyWith(color: defaultColor),
                  //       ),
                  //       height: 25.0,
                  //       minWidth: 1.0,
                  //       padding: EdgeInsets.zero),
                  // ),
                  // Container(
                  //   height: 20.0,
                  //
                  //   child: MaterialButton(
                  //       onPressed: () {},
                  //       child: Text(
                  //         "#flutter",
                  //         style: Theme.of(context).textTheme.caption?.copyWith(color: defaultColor),
                  //       ),
                  //       height: 25.0,
                  //       minWidth: 1.0,
                  //       padding: EdgeInsets.zero),
                  // ),
                ],
              ),
            ),
          ),
          if (model.postImage != '')
            Container(
                height: 160.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0),
                  image: DecorationImage(
                      image: NetworkImage(
                        "${model.postImage}",
                      ),
                      fit: BoxFit.cover),
                )),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Icon(
                          IconBroken.Heart,
                          size: 16,
                          color: Colors.red,
                        ),
                        SizedBox(
                          width: 3.0,
                        ),
                        Text(
                          "${SocialCubit.get(context).likes.length}",
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  ),
                  onTap: () {},
                ),
              ),
              Expanded(
                child: InkWell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Icon(
                        IconBroken.Chat,
                        size: 16,
                        color: Colors.red,
                      ),
                      SizedBox(
                        width: 3.0,
                      ),
                      Text(
                        "0",
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                  onTap: () {},
                ),
              ),
            ],
          ),
          Container(
            color: Colors.grey[300],
            height: 1.0,
            width: double.infinity,
          ),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 6.0),
                    child: Row(children: [
                      CircleAvatar(
                        maxRadius: 22,
                        backgroundImage: NetworkImage(
                            "${SocialCubit.get(context).userModel?.image}"),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Text(
                        "Write Your Comment ... ",
                        style: Theme.of(context)
                            .textTheme
                            .caption
                            ?.copyWith(height: 1.3),
                      ),
                    ]),
                  ),
                  onTap: () {},
                ),
              ),
              InkWell(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      IconBroken.Heart,
                      size: 16,
                      color: Colors.red,
                    ),
                    SizedBox(
                      width: 3.0,
                    ),
                    Text(
                      "Like",
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ],
                ),
                onTap: () {
                  SocialCubit.get(context)
                      .likePosts(SocialCubit.get(context).postLikes[index]);
                },
                onDoubleTap: () => showToast(massage: "Enough"),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
