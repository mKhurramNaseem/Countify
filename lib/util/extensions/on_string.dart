extension Modification on String? {
  bool isEmail() {
    if (this == null) {
      return false;
    }
    return this!.contains('@gmail.com');
  }
}
