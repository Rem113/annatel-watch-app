abstract class Validators {
  static RegExp _emailRegExp = RegExp(
    r'^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$',
  );
  static RegExp _watchIdRegExp = RegExp(
    r'^[0-9]*$',
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

  static String validatePasswordConfirm(
    String password,
    String passwordConfirm,
  ) {
    final passwordInput = password.trim();
    final passwordConfirmInput = passwordConfirm.trim();

    if (passwordConfirmInput.isEmpty) return "Please confirm your password";
    if (passwordInput != passwordConfirmInput)
      return "Passwords does not match";
    return null;
  }

  static String validateWatchName(String watchName) {
    if (watchName.isEmpty) return "Please enter a name for the watch";

    return null;
  }

  static String validateWatchId(String watchId) {
    if (watchId.isEmpty) return "Please enter a watch ID";
    if (!_watchIdRegExp.hasMatch(watchId)) return "Watch ID format is invalid";

    return null;
  }

  static String validateWatchVendor(String watchVendor) {
    if (watchVendor.isEmpty) return "Please enter the vendor name";

    return null;
  }
}
