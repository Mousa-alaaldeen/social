abstract class RegisterStates {}

class RegisterIntialState extends RegisterStates {}

class RegisterLodingState extends RegisterStates {}

class RegisterSuccessState extends RegisterStates {}

class RegisterErrorState extends RegisterStates {
  final String error;
  RegisterErrorState(this.error);
}

class UserCreateLodingState extends RegisterStates {}

class UserCreateSuccessState extends RegisterStates {}

class UserCreateErrorState extends RegisterStates {
  final String error;
  UserCreateErrorState(this.error);
}

class RegisterPasswordIsVisibilityState extends RegisterStates {}
