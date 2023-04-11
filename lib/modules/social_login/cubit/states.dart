abstract class SocialAppLoginStates {}

class SocialAppLoginInitialState extends SocialAppLoginStates {}

class SocialAppLoginLoadingState extends SocialAppLoginStates {}

class SocialAppLoginSuccessState extends SocialAppLoginStates {
  final String uId;
  SocialAppLoginSuccessState({required this.uId});
}

class SocialAppLoginErrorState extends SocialAppLoginStates {
  final String error;
  SocialAppLoginErrorState({required this.error});
}

class SocialAppChangePasswordVisibility extends SocialAppLoginStates {}