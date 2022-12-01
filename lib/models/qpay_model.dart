class PaymentModel {
  String invoiceId;
  String qrImage;
  String qrText;
  List<PaymentLinkModel> urls;

  PaymentModel.fromJson(Map json)
      : invoiceId = json["invoice_idd"] ?? "",
        qrImage = json["qr_image"] ?? "",
        qrText = json["qr_text"] ?? "",
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