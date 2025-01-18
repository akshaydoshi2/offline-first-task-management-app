import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authProvider = ChangeNotifierProvider((ref)=> AuthNotifierProvider(ref));

class AuthNotifierProvider extends ChangeNotifier{
  Ref _ref;
  AuthNotifierProvider(this._ref);

  String verId = "";
  FirebaseAuth get _firebaseAuth => FirebaseAuth.instance;
  bool get isButtonValid => !showOtpWidget ? number.length == 10 : otp.length==6;

  String? _countryCode;
  String? get countryCode => _countryCode ?? "+91";
  set countryCode(String? v){
    _countryCode = v;
    notifyListeners();
  }

  String _number = "";
  String get number => _number;
  set number(String v){
    _number = v;
    notifyListeners();
  }

  String _otp = "";
  String get otp => _otp;
  set otp(String v){
    _otp = v;
    notifyListeners();
  }

  bool _showOtpWidget = false;
  bool get showOtpWidget => _showOtpWidget;
  set showOtpWidget(bool v){
    _showOtpWidget = v;
    notifyListeners();
  }

  bool _authLoading = false;
  bool get authLoading => _authLoading;
  set authLoading(bool v){
    _authLoading = v;
    notifyListeners();
  }

  void verifyPhoneNumber(BuildContext context) async {
    authLoading = true;
    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: '$countryCode$number',
      verificationCompleted: (PhoneAuthCredential credential) async{
        await _firebaseAuth.signInWithCredential(credential);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Login Successful!'))
        );
        showOtpWidget = false;
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('The provided phone number is not valid.'))
          );
        }
      },
      codeSent: (String verificationId, int? resendToken)async {
        authLoading = false;
        verId = verificationId;
        showOtpWidget = true;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('SMS Sent!'))
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  submitOtp()async{
    authLoading = true;
    PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verId, smsCode: otp);
    await _firebaseAuth.signInWithCredential(credential);
    print("Auth success!");
    authLoading = false;
    showOtpWidget = false;
  }
}