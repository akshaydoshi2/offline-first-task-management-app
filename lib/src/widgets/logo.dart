import 'package:flutter/material.dart';
import 'package:tushop_assesment/src/utilities/extensions.dart';

Widget AppLogo(
  BuildContext context,
  {double titleSize = 48, double subTitleSize = 18}
  ){
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text("ACME",
          textAlign: TextAlign.center,
          style: TextStyle(
            height: 0,
            fontSize: titleSize,
            fontWeight: FontWeight.bold
          ),
        ),
        Text("Solutions",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: subTitleSize,
            fontWeight: FontWeight.bold
          ),
        ),
        const SizedBox(height: 12,),
        Text(context.labels.yourTaskManager,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.black54
          ),
        )
      ],
    );
}