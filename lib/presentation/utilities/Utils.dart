

import 'package:flutter/cupertino.dart';
import 'package:zenithbankkyc/presentation/utilities/toast_alert.dart';

void showErrorMessage(BuildContext context, String message) {
  ToastUtils.showCustomToast(context, message);
}