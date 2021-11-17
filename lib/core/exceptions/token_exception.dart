class TokenException implements Exception {
  final _message;

  TokenException([this._message]);

  String toString() {
    return "$_message";
  }
}
