

abstract class SocialAppRegisterStates{}
class InitialAppRegisterState extends SocialAppRegisterStates{}
class SocialAppRegisterErrorState extends SocialAppRegisterStates{
  final String message;

  SocialAppRegisterErrorState(this.message);
}
class SocialAppRegisterSuccessState extends SocialAppRegisterStates{


}
class SocialAppRegisterLoadingState extends SocialAppRegisterStates{}
class SocialAppChangeIconVisibilityInRegisterState extends SocialAppRegisterStates{}


class SocialAppUserCreateErrorState extends SocialAppRegisterStates{
  final String message;

  SocialAppUserCreateErrorState(this.message);
}
class SocialAppUserCreateSuccessState extends SocialAppRegisterStates{


}
class SocialAppUserCreateLoadingState extends SocialAppRegisterStates{}