import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tushop_assesment/src/pages/auth/providers/auth_provider.dart';
import 'package:tushop_assesment/src/utilities/app_colors.dart';
import 'package:tushop_assesment/src/utilities/extensions.dart';

class AppPhoneField extends ConsumerWidget {
  const AppPhoneField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(authProvider);
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              width: 1,
              color: Colors.black12
            ),
          ),
          child: CountryCodePicker(
            showDropDownButton: true,
            padding: EdgeInsets.zero,
            onChanged: (e) {
              notifier.countryCode = e.dialCode;
            },
            initialSelection: 'IN',
            showCountryOnly: true,
            showOnlyCountryWhenClosed: false,
            favorite: const ['IN', 'KE'],
          ),
        ),
        const SizedBox(width: 8,),
        Expanded(
          child: TextFormField(
            readOnly: notifier.showOtpWidget,
            cursorColor: AppColors.primary,
            maxLength: 10,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            validator: (v) {
              return (v ?? "").length != 10 ? context.labels.enterValidPhoneNo : null;
            },
            onChanged: (v){
              notifier.number = v;
            },
            decoration: InputDecoration(
              hintText: context.labels.enterPhoneNo,
              counterText: "",
            )
          ),
        )
      ],
    );
  }
}
