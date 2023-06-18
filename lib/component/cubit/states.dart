

abstract class SocialLoginState{}

class SocialLoginInitState extends SocialLoginState{}
class SocialLoginLoadingState extends SocialLoginState{}
class SocialLoginSuccessState extends SocialLoginState{
  final String uId;
  SocialLoginSuccessState(this.uId);
}

class SocialLoginErrorState extends SocialLoginState{
  final String error;
  SocialLoginErrorState(this.error);
}
class SocialShowPasswordState extends SocialLoginState{}
class SocialRegisterLoadingState extends SocialLoginState{}
class SocialRegisterSuccessState extends SocialLoginState{}

class SocialCreateLoadingState extends SocialLoginState{}
class SocialCreateSuccessState extends SocialLoginState{}
class SocialCreateErrorState extends SocialLoginState{
  final String error;
  SocialCreateErrorState(this.error);
}

///////////////////////////////////////////////////////////////////////
abstract class SocialStates{}

class SocialInitStates extends SocialStates{}

class SocialGetUserLoadingStates extends SocialStates{}
class SocialGetUserSuccessStates extends SocialStates{}
class SocialGetUserErrorStates extends SocialStates{}

class SocialGetAllUserLoadingStates extends SocialStates{}
class SocialGetAllUserSuccessStates extends SocialStates{}
class SocialGetAllUserErrorStates extends SocialStates{}

class SocialGetPostsLoadingStates extends SocialStates{}
class SocialGetPostsSuccessStates extends SocialStates{}
class SocialGetPostsErrorStates extends SocialStates{}

class SocialGetOnePostLoadingStates extends SocialStates{}
class SocialGetOnePostSuccessStates extends SocialStates{}
class SocialGetOnePostErrorStates extends SocialStates{}


class ChangeIndexSuccussStates extends SocialStates{}

class NewPostSuccussStates extends SocialStates{}

class SocialProfileImageSuccussStates extends SocialStates{}
class SocialProfileImageErrorStates extends SocialStates{}

class SocialCoverImageSuccussStates extends SocialStates{}
class SocialCoverImageErrorStates extends SocialStates{}

class SocialPostImageSuccussStates extends SocialStates{}
class SocialPostImageErrorStates extends SocialStates{}

class SocialUploadImageProfileSuccussStates extends SocialStates{}
class SocialUploadImageProfileLoadingStates extends SocialStates{}
class SocialUploadImageProfileErrorStates extends SocialStates{}

class SocialUploadImageCoverSuccussStates extends SocialStates{}
class SocialUploadImageCoverLoadingStates extends SocialStates{}
class SocialUploadImageCoverErrorStates extends SocialStates{}

class SocialUploadImagePostSuccussStates extends SocialStates{}
class SocialUploadImagePostLoadingStates extends SocialStates{}
class SocialUploadImagePostErrorStates extends SocialStates{}

class SocialUpdateUserSuccussStates extends SocialStates{}
class SocialUpdateUserLoadingStates extends SocialStates{}
class SocialUpdateUserErrorStates extends SocialStates{}

class SocialCreatePostSuccussStates extends SocialStates{}
class SocialCreatePostLoadingStates extends SocialStates{}
class SocialCreatePostErrorStates extends SocialStates{}


class SocialRemovePostImageSuccussStates extends SocialStates{}

class SocialLikePostSuccussStates extends SocialStates{}
class SocialLikePostErrorStates extends SocialStates{}


class SocialSendMessageSuccussStates extends SocialStates{}
class SocialSendMessageErrorStates extends SocialStates{}

class SocialGetMessageSuccussStates extends SocialStates{}
class SocialGetMessageErrorStates extends SocialStates{}
