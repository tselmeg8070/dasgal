class BusinessException implements Exception {
  final _message;

  BusinessException([this._message]);

  String toString() {
    return "$_message";
  }
}
