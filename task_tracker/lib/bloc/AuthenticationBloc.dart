import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:bloc/bloc.dart';
import 'package:task_tracker/resources/Repository.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvents, AuthenticationStates> {
  static String verificationToken;

  // --------------------PhoneAuth Helpers ------------------------------

  onCodeSent(String verification) {
    verificationToken = verification;
    add(RequestAuthCodeUIEvent());
  }

  onVerificationFailed(String errorMessage) async* {
    yield AuthenticationFailed();
  }

  onVerificationCompleted(AuthCredential credentials) async {
    add(CompleteLoginEvent(
      loginCredential: credentials,
    ));
  }

  onPhoneCodeAutoRetrievalTimeout(String verification) {
    verificationToken = verification;
  }

  @override
  // TODO: implement initialState
  AuthenticationStates get initialState => InitialAuthState();

  @override
  Stream<AuthenticationStates> mapEventToState(
      AuthenticationEvents event) async* {
    try {
      if (event is RequestLoginWithMailUIEvent)
        yield MailAuthState();
      else if (event is RequestLoginWithPhoneUIEvent)
        yield PhoneAuthState();
      else if (event is LoginEvent) {
        initiateLogin(event);
      } else if (event is RequestAuthCodeUIEvent) {
        yield VerifyPhoneNumber();
      } else if (event is VerifyPhoneNumberEvent) {
        AuthCredential phoneCredits = PhoneAuthProvider.getCredential(
            verificationId: verificationToken, smsCode: event.messageCode);
        add(CompleteLoginEvent(loginCredential: phoneCredits));
      }
    } catch (ex) {
      yield AuthenticationFailed();
    }
  }

  void initiateLogin(LoginEvent event) {
    if (event.loginVia == AuthMethods.PHONE) {
      Repository.requestAuthCode(
          phoneNumber: event.phoneNumber,
          onAuthFailed: onVerificationFailed,
          onCodeSent: onCodeSent,
          onVerificationComplete: onVerificationCompleted,
          onVerificationTimeout: onPhoneCodeAutoRetrievalTimeout);
    } else if (event.loginVia == AuthMethods.MAIL) {
      // Login With Mail
    } else {}
  }
}

abstract class AuthenticationStates {}

class InitialAuthState extends AuthenticationStates {}

class AuthLoadingState extends AuthenticationStates {}

class MailAuthState extends AuthenticationStates {}

class PhoneAuthState extends AuthenticationStates {}

class VerifyPhoneNumber extends AuthenticationStates {}

class AuthenticationCompleted extends AuthenticationStates {}

class AuthenticationFailed extends AuthenticationStates {}

abstract class AuthenticationEvents {}

class RequestLoginWithMailUIEvent extends AuthenticationEvents {}

class RequestLoginWithPhoneUIEvent extends AuthenticationEvents {}

class RequestAuthCodeUIEvent extends AuthenticationEvents {}

class LoginEvent extends AuthenticationEvents {
  final AuthMethods loginVia;
  final String phoneNumber;
  LoginEvent({this.loginVia, this.phoneNumber});
}

class VerifyPhoneNumberEvent extends AuthenticationEvents {
  final String messageCode;
  VerifyPhoneNumberEvent({this.messageCode});
}

class CompleteLoginEvent extends AuthenticationEvents {
  final AuthCredential loginCredential;
  CompleteLoginEvent({this.loginCredential});
}

enum AuthMethods { PHONE, MAIL }
