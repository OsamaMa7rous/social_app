import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubit/social_cubit/states.dart';
import 'package:social_app/modules/edit_profile/edit_profile_sceen.dart';
import 'package:social_app/shared_componant/reuseable_componant.dart';
import 'package:social_app/styles/icon_broken.dart';

import '../../cubit/social_cubit/cubit.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialCubitStates>(
      listener: (context, state) {

      },
      builder: (context, state) {
        var model = SocialCubit.get(context).userModel;
        return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              height: 180,
              width: double.infinity,
              child: Align(
                alignment: AlignmentDirectional.topCenter,
                child: Stack(
                  children: [
                    Container(
                      height: 120,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(5.0),
                            topRight: Radius.circular(5.0)),
                        image: DecorationImage(
                            image: NetworkImage(
                                "${model?.cover}"),
                            fit: BoxFit.cover),
                      ),
                    ),
                    Align(
                      alignment: AlignmentDirectional.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: CircleAvatar(
                          maxRadius: 59,
                          backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                          child: CircleAvatar(
                            maxRadius: 55,
                            backgroundImage: NetworkImage(
                                "${model?.image}"),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Text(
              '${model?.name}',
              style: Theme.of(context).textTheme.bodyText1,
            ),
            Text(
              '${model?.bio}',
              style: Theme.of(context).textTheme.caption,
            ),
            SizedBox(
              height: 5.0,
            ),
            Row(
              children: [
                Expanded(
                  child: Column(children: [
                    Text(
                      "100",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Text(
                      "posts",
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ]),
                ),
                Expanded(
                  child: Column(children: [
                    Text(
                      "260",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Text(
                      "photos",
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ]),
                ),
                Expanded(
                  child: Column(children: [
                    Text(
                      "10K",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Text(
                      "followers",
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ]),
                ),
                Expanded(
                  child: Column(children: [
                    Text(
                      "66",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Text(
                      "followings",
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ]),
                ),

              ],
            ),
            SizedBox(
              height: 10.0,
            ),


            Row(
              children: [
                Expanded(child: OutlinedButton(onPressed: (){}, child: Text("Add Photos"),style:ButtonStyle(
                ) ,)),
                SizedBox(width: 5,),
                OutlinedButton(onPressed: (){
                    navigateTo(context, EditProfileScreen());
                }, child: Icon(IconBroken.Edit,size: 16.0,)),
              ],
            )
          ],
        ),
      );
      },
    );
  }
}
