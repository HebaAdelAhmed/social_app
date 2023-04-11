abstract class SocialAppRegistrationStates {}

class SocialAppRegistrationInitialState extends SocialAppRegistrationStates {}

class SocialAppRegistrationLoadingState extends SocialAppRegistrationStates {}

class SocialAppRegistrationSuccessState extends SocialAppRegistrationStates {}

class SocialAppRegistrationErrorState extends SocialAppRegistrationStates {
  final String error;
  SocialAppRegistrationErrorState({required this.error});
}

class SocialAppUserCreateSuccessState extends SocialAppRegistrationStates {}

class SocialAppUserCreateErrorState extends SocialAppRegistrationStates {
  final String error;
  SocialAppUserCreateErrorState({required this.error});
}

class SocialAppRegistrationChangePasswordVisibility extends SocialAppRegistrationStates {}
