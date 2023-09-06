

abstract class SocialAppStates{}
class InitialAppState extends SocialAppStates{}
class SocialAppLoginErrorState extends SocialAppStates{
  final String message ;

  SocialAppLoginErrorState(this.message);
}
class SocialAppLoginSuccessState extends SocialAppStates{
 final String? uId;

  SocialAppLoginSuccessState(this.uId);

}
class SocialAppLoginLoadingState extends SocialAppStates{}
class SocialAppChangeIconVisibilityState extends SocialAppStates{}
