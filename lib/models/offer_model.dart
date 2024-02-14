// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Offer {
  int? id;
  String? productName;
  String? offerTitle;
  String? offerPrice;
  String? originalPrice;
  String? productImage;
  String? shopName;
  Offer({
    this.id,
    this.productName,
    this.offerTitle,
    this.offerPrice,
    this.originalPrice,
    this.productImage,
    this.shopName,
  });

  Offer copyWith({
    int? id,
    String? productName,
    String? offerTitle,
    String? offerPrice,
    String? originalPrice,
    String? productImage,
    String? shopName,
  }) {
    return Offer(
      id: id ?? this.id,
      productName: productName ?? this.productName,
      offerTitle: offerTitle ?? this.offerTitle,
      offerPrice: offerPrice ?? this.offerPrice,
      originalPrice: originalPrice ?? this.originalPrice,
      productImage: productImage ?? this.productImage,
      shopName: shopName ?? this.shopName,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'productName': productName,
      'offerTitle': offerTitle,
      'offerPrice': offerPrice,
      'originalPrice': originalPrice,
      'productImage': productImage,
      'shopName': shopName,
    };
  }

  factory Offer.fromMap(Map<String, dynamic> map) {
    return Offer(
      id: map['id'] != null ? map['id'] as int : null,
      productName:
          map['productName'] != null ? map['productName'] as String : null,
      offerTitle:
          map['offerTitle'] != null ? map['offerTitle'] as String : null,
      offerPrice:
          map['offerPrice'] != null ? map['offerPrice'] as String : null,
      originalPrice:
          map['originalPrice'] != null ? map['originalPrice'] as String : null,
      productImage:
          map['productImage'] != null ? map['productImage'] as String : null,
      shopName: map['shopName'] != null ? map['shopName'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Offer.fromJson(String source) =>
      Offer.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Offer(id: $id, productName: $productName, offerTitle: $offerTitle, offerPrice: $offerPrice, originalPrice: $originalPrice, productImage: $productImage, shopName: $shopName)';
  }

  @override
  bool operator ==(covariant Offer other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.productName == productName &&
        other.offerTitle == offerTitle &&
        other.offerPrice == offerPrice &&
        other.originalPrice == originalPrice &&
        other.productImage == productImage &&
        other.shopName == shopName;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        productName.hashCode ^
        offerTitle.hashCode ^
        offerPrice.hashCode ^
        originalPrice.hashCode ^
        productImage.hashCode ^
        shopName.hashCode;
  }
}
