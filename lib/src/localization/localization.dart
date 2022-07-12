import 'package:get/get.dart';

class Localization extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'sign_up': 'SIGN UP',
          'continue': 'Continue',
          'sign_in': 'SIGN IN',
          'log_in': 'LOG  IN',
          'email': 'Email',
          'password': 'Password',
          'forgot_password': 'Forgot password?',
          'password_reset': 'Password reset!',
          'don\'t_have_an_account': 'Don\'t have an account',
          'already_have_an_account': 'Already have an account?',
          'or': 'or',
        },
        'ar_SA': {
          'sign_up': 'اشتراك',
          'continue': 'استمر',
        }
      };
}
