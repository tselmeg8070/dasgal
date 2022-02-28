class UserModel {
  String invoiceId;
  String qrImage;
  List<PaymentLinkModel> urls;

  UserModel.fromJson(Map json)
      : invoiceId = json["invoiceId"] ?? "",
        qrImage = json["qrImage"] ?? "",
        urls = List<PaymentLinkModel>.from(json["urls"].map((i) => PaymentLinkModel.fromJson(i)).toList());
}

class PaymentLinkModel {
  String description;
  String link;
  String logo;
  String name;

  PaymentLinkModel.fromJson(Map json)
    : description = json["description"] ?? "",
        link = json["link"] ?? "",
        logo = json["logo"] ?? "",
        name = json["name"] ?? "";
}