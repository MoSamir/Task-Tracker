import 'package:firebase_auth/firebase_auth.dart';

class LoginAPIs {
  static requestPhoneAuthCode(
      {String phone,
      Function onComplete,
      Function onCode,
      Function onError,
      Function onTimeout}) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phone,
        timeout: Duration(seconds: 1),
        verificationCompleted: (credentials) => onComplete(credentials),
        verificationFailed: (authError) => onError(authError.message),
        codeSent: (verification, [forceRefresh]) => onCode(verification),
        codeAutoRetrievalTimeout: onTimeout);
  }
}
