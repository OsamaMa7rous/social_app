import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/cubit/social_cubit/states.dart';
import 'package:social_app/shared_componant/reuseable_componant.dart';

import '../../cubit/social_cubit/cubit.dart';
import '../../models/user_create_model.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialCubitStates>(
      listener: (context, state) {

      },
      builder: (context, state) => ConditionalBuilder(
        condition: SocialCubit.get(context).users.isNotEmpty,
        fallback: (context) => const Center(child: CircularProgressIndicator()),
        builder: (context) => ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemCount: SocialCubit.get(context).users.length,
          itemBuilder: (context, index) =>buildAllUsers(SocialCubit.get(context).users[index],context),
          separatorBuilder:(context, index) =>  separatorBuilder(),
        ),
             ),

    );
  }
  Widget buildAllUsers (UserCreateModel model,context)=>
    InkWell(
      onTap: (){},
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            CircleAvatar(
              maxRadius: 25,
              backgroundImage: NetworkImage(
                  "${model.image}"),
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
                      const  SizedBox(width: 3.0,),
                      const Icon(
                        Icons.check_circle,
                        color: Colors.blue,
                        size: 16,
                      ),
                    ],
                  ),

                ],
              ),
            ),

          ],
        ),
      ),
    );
}
