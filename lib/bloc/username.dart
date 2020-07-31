

import 'package:formz/formz.dart';

enum UsernameValidationError { empty }

class Username extends FormzInput<String, UsernameValidationError> {
  const Username.pure() : super.pure('');
  const Username.dirty([String value = '']) : super.dirty(value);

  @override
  UsernameValidationError validator(String value) {
    return value.contains('.') && value.length > 5 && value.contains('') ? null : UsernameValidationError.empty;
  }
}

class ResponseCode extends FormzInput<String, UsernameValidationError> {
  const ResponseCode.pure() : super.pure('');
  const ResponseCode.dirty([String value = '']) : super.dirty(value);

  @override
  UsernameValidationError validator(String value) {
    return value.length > 0 ? null : UsernameValidationError.empty;
  }
}