extension StringExtension on String {
  bool isValidEmail() {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(this);
  }

  bool isStrongPassword() {
    // At least 8 characters, 1 uppercase, 1 number
    final strongRegex = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d@$!%*?&]{8,}$',
    );
    return strongRegex.hasMatch(this);
  }

  String capitalizeFirst() {
    return '${this.toUpperCase()}${substring(1)}';
  }
}

extension IterableExtension<T> on Iterable<T> {
  bool containsWhere(bool Function(T) test) {
    return any(test);
  }
}
