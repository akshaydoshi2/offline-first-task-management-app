import 'package:flutter/widgets.dart';
import 'package:tushop_assesment/l10n/app_localizations.dart';

extension LocalizedBuildContext on BuildContext {
  AppLocalizations get labels => AppLocalizations.of(this);
}