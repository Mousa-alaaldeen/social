abstract class LoginStates {}

class LoginInitioalState extends LoginStates {}

class LoginLodingState extends LoginStates {}

class LoginSuccessState extends LoginStates {
  final String uId;
  LoginSuccessState(this.uId);
}

class LoginErrorState extends LoginStates {
  final String error;
  LoginErrorState(this.error);
}

class LoginPasswordIsVisibilityState extends LoginStates {}

class RegisterLodingState extends LoginStates {}

class RegisterErrorState extends LoginStates {}

class UserCreateLodingState extends LoginStates {}

class UserCreateSuccessState extends LoginStates{}

class UserCreateErrorState extends LoginStates {
  final String error;
  UserCreateErrorState(this.error);
}
