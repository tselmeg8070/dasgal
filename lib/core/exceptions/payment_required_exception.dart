class PaymentRequiredException implements Exception {

  PaymentRequiredException();

  String toString() {
    return "Та төлбөр төлсөнөөр үзэх боломжтой";
  }
}
