import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthState{}

class AuthInitialState extends AuthState{}

class AuthLoadingState extends AuthState{}

class AuthCodeSentState extends AuthState{

}

class AuthCodeVerifyState extends AuthState{}

class AuthLogedInState extends AuthState{
  final User user;

  AuthLogedInState(this.user);
}

class AuthLogOutState extends AuthState{}

class AuthErrorState extends AuthState{
  final String error;
  AuthErrorState(this.error);
}