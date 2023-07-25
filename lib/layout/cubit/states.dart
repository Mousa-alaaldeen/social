abstract class SocialStates {}

class SocialInitialState extends SocialStates {}

class SocialGetUserLodingState extends SocialStates {}

class SocialGetUserSuccessState extends SocialStates {}

class SocialGetUserErrorState extends SocialStates {
  final String error;
  SocialGetUserErrorState(this.error);
}

class ChangeBottomNavState extends SocialStates {}

class NavigateToPostScreenState extends SocialStates {}

class SocialCoverImagePeckerSuccessState extends SocialStates {}

class SocialSocialCoverImagePeckerErrorState extends SocialStates {}

class SocialProfileImagePeckerSuccessState extends SocialStates {}

class SocialProfileCoverImagePeckerErrorState extends SocialStates {}

class SocialUploadProfileImageSuccessState extends SocialStates {}

class SocialUploadProfileImageErrorState extends SocialStates {}

class SocialUploadCoverImageSuccessState extends SocialStates {}

class SocialUploadCoverImageErrorState extends SocialStates {}

class SocialUserUploadLodingState extends SocialStates {}

class SocialUploadUserSuccessState extends SocialStates {}

class SocialUserUploadErrorState extends SocialStates {}

//post
class SocialPostImagePeckerSuccessState extends SocialStates {}

class SocialRemovePostImagePeckerSuccessState extends SocialStates {}

class SocialSocialPostImagePeckerErrorState extends SocialStates {}

class SocialCreatPostLodingState extends SocialStates {}

class SocialCreatPostSuccessState extends SocialStates {}

class SocialCreatPoatErrorState extends SocialStates {}

class SocialGetPostLodingState extends SocialStates {}

class SocialGetPostSuccessState extends SocialStates {}

class SocialGetPoatErrorState extends SocialStates {}

class LikePostSuccessState extends SocialStates {}

class LikePoatErrorState extends SocialStates {}

class CreatCommentLodingState extends SocialStates {}

class CreatCommentSuccessState extends SocialStates {}

class CreatCommentErrorState extends SocialStates {}

class GetCommentLodingState extends SocialStates {}

class GetCommentSuccessState extends SocialStates {}

class GettCommentErrorState extends SocialStates {}

//Users

class GetAllUsersLodingState extends SocialStates {}

class GetAllUsersSuccessState extends SocialStates {}

class GettAllUsersErrorState extends SocialStates {}
//message

class SendMessageSuccessState extends SocialStates {}

class SendMessageErrorState extends SocialStates {}

class ResiverMessageSuccessState extends SocialStates {}

class ResiverMessageErrorState extends SocialStates {}
class GetMessageSuccessState extends SocialStates {}
class AppChangeModeState extends SocialStates {}
