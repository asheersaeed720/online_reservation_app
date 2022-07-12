mixin InputValidationMixin {
  String? validateName(String value) {
    if (value.trim().isEmpty) {
      return 'Required';
    }
    return null;
  }

  String? validateEmail(String value) {
    if (value.isEmpty) {
      return 'Required';
    }
    bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value);
    return !emailValid ? "Enter valid email" : null;
  }

  String? validatePassword(String value) {
    if (value.isEmpty) {
      return 'Required';
    } else if (value.length < 6) {
      return 'Password must be atleast 6 characters';
    }
    return null;
  }
}
