abstract class SocialLayoutStates {}

class SocialLayoutInitialState extends SocialLayoutStates {}

class SocialLayoutGetUserSuccessState extends SocialLayoutStates {}

class SocialLayoutGetUserLoadingState extends SocialLayoutStates {}

class SocialLayoutGetUserErrorState extends SocialLayoutStates {
  final String error;
  SocialLayoutGetUserErrorState({
    required this.error,
});
}

class SocialLayoutGetAllUsersSuccessState extends SocialLayoutStates {}

class SocialLayoutGetAllUsersLoadingState extends SocialLayoutStates {}

class SocialLayoutGetAllUsersErrorState extends SocialLayoutStates {
  final String error;
  SocialLayoutGetAllUsersErrorState({
    required this.error,
  });
}

class SocialLayoutChangeBottomNavState extends SocialLayoutStates {}

class SocialLayoutNewPostState extends SocialLayoutStates {}

class SocialLayoutProfileImagePickedSuccessState extends SocialLayoutStates {}

class SocialLayoutProfileImagePickedErrorState extends SocialLayoutStates {}

class SocialLayoutCoverImagePickedSuccessState extends SocialLayoutStates {}

class SocialLayoutCoverImagePickedErrorState extends SocialLayoutStates {}

class SocialLayoutPostImagePickedSuccessState extends SocialLayoutStates {}

class SocialLayoutPostImagePickedErrorState extends SocialLayoutStates {}

class SocialLayoutUploadProfileImageSuccessState extends SocialLayoutStates {}

class SocialLayoutUploadProfileImageErrorState extends SocialLayoutStates {}

class SocialLayoutUploadCoverImageSuccessState extends SocialLayoutStates {}

class SocialLayoutUploadCoverImageErrorState extends SocialLayoutStates {}

class SocialLayoutUploadUserErrorState extends SocialLayoutStates {}

class SocialLayoutUploadUserLoadingState extends SocialLayoutStates {}

class SocialLayoutCreatePostLoadingState extends SocialLayoutStates {}

class SocialLayoutCreatePostSuccessState extends SocialLayoutStates {}

class SocialLayoutCreatePostErrorState extends SocialLayoutStates {}

class SocialLayoutRemovePostImageState extends SocialLayoutStates {}

class SocialLayoutGetPostsSuccessState extends SocialLayoutStates {}

class SocialLayoutGetPostsLoadingState extends SocialLayoutStates {}

class SocialLayoutGetPostsErrorState extends SocialLayoutStates {
  final String error;
  SocialLayoutGetPostsErrorState({
    required this.error,
  });
}

class SocialLayoutLikePostSuccessState extends SocialLayoutStates {}

class SocialLayoutLikePostErrorState extends SocialLayoutStates {
  final String error;
  SocialLayoutLikePostErrorState({
    required this.error,
  });
}

class SocialSendMessageSuccessState extends SocialLayoutStates {}

class SocialSendMessageErrorState extends SocialLayoutStates {}

class SocialGetMessageSuccessState extends SocialLayoutStates {}

class SocialGetMessageErrorState extends SocialLayoutStates {}
