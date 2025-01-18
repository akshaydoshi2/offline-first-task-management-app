import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinput/pinput.dart';
import 'package:tushop_assesment/src/pages/auth/providers/auth_provider.dart';
import 'package:tushop_assesment/src/utilities/app_colors.dart';
import 'package:tushop_assesment/src/utilities/extensions.dart';
import 'package:tushop_assesment/src/widgets/app_button.dart';
import 'package:tushop_assesment/src/widgets/app_phone_field.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final defaultPinTheme = PinTheme(
      width: 45,
      height: 45,
      textStyle: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600
      ),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromRGBO(192, 192, 192, 1.0)),
        borderRadius: BorderRadius.circular(12),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: AppColors.primary),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        color: const Color.fromRGBO(234, 239, 243, 1),
      ),
    );

    final notifier = ref.watch(authProvider);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(context.labels.login,
              style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold
              ),
            ),
            const SizedBox(height: 16,),
            const AppPhoneField(),
            if(notifier.showOtpWidget)
            const SizedBox(height: 24,),
            if(notifier.showOtpWidget)
            Pinput(
              // smsRetriever: SmsRetriever(),
              autofocus: true,
              length: 6,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              keyboardType: TextInputType.number,
              defaultPinTheme: defaultPinTheme,
              focusedPinTheme: focusedPinTheme,
              submittedPinTheme: submittedPinTheme,
              onChanged: (val){
                notifier.otp = val;
              },
              onCompleted: (v){
                if(v.length == 6){
                  notifier.submitOtp();
                }
              },
            ),
            const SizedBox(height: 24,),
            AppButton(
              onPressed: (){
                if(notifier.showOtpWidget){
                  notifier.submitOtp();
                }else{
                  notifier.verifyPhoneNumber(context);
                }
              },
              label: context.labels.login,
              loading: notifier.authLoading,
              disabled: false,
            ),
          ],
        ),
      ),
    );
  }
}
