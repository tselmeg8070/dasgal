class CustomException implements Exception {
  final _message;

  CustomException([this._message]);

  String toString() {
    return "$_message";
  }
}
