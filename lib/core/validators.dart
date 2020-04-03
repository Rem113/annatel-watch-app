abstract class Validators {
  static RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );

  static String validateEmail(String email) {
    if (email.isEmpty) return 'Please enter an email';
    if (!_emailRegExp.hasMatch(email)) return 'Please enter a valid email';
    return null;
  }

  static String validatePassword(String password) {
    final input = password.trim();

    if (input.isEmpty) return 'Please enter a password';
    if (input.length < 8) return 'Password must be at least 8 characters';
    return null;
  }
}
