import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phone_auth_with_bloc/cubits/auth_state.dart';

class AuthCubit extends Cubit<AuthState>{
  final FirebaseAuth _auth =  FirebaseAuth.instance;
  AuthCubit(): super(AuthInitialState()){
    User? currentUser = _auth.currentUser;

    if(currentUser != null){
      emit(AuthLogedInState(currentUser));
    }else{
      emit(AuthLogOutState());
    }
  }

  String? _verificationId;
  Future<void> sendOTP(String phoneNumber) async {
    emit(AuthLoadingState());
    await _auth.verifyPhoneNumber(phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) {
      signInWithPhone(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
      emit(AuthErrorState(e.message.toString()));
      },
      codeSent: (String verificationId, int? resendToken) {
        _verificationId = verificationId;
        emit(AuthCodeSentState());
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        _verificationId = verificationId;
      },
    );
    
  }

  void verifyOTP(String otp){

    emit(AuthLoadingState());
    PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: _verificationId!, smsCode: otp);
    signInWithPhone(credential);
  }

  Future<void> signInWithPhone(PhoneAuthCredential credential) async {

    try {
      UserCredential userCredential = await _auth.signInWithCredential(credential);
      if(userCredential.user != null){
            emit(AuthLogedInState(userCredential.user!));
          }
    } on FirebaseAuthException catch (e) {
      emit(AuthErrorState(e.message.toString()));
      print(e);
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    emit(AuthLogOutState());
  }

}