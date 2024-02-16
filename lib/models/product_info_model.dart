// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ProductInfoModel {
  int? id;
  String? productName;
  String? productDescription;
  String? offerPrice;
  String? originalPrice;
  String? productImage;
  String? shopName;
  ProductInfoModel({
    this.id,
    this.productName,
    this.productDescription,
    this.offerPrice,
    this.originalPrice,
    this.productImage,
    this.shopName,
  });

  ProductInfoModel copyWith({
    int? id,
    String? productName,
    String? productDescription,
    String? offerPrice,
    String? originalPrice,
    String? productImage,
    String? shopName,
  }) {
    return ProductInfoModel(
      id: id ?? this.id,
      productName: productName ?? this.productName,
      productDescription: productDescription ?? this.productDescription,
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
      'productDescription': productDescription,
      'offerPrice': offerPrice,
      'originalPrice': originalPrice,
      'productImage': productImage,
      'shopName': shopName,
    };
  }

  factory ProductInfoModel.fromMap(Map<String, dynamic> map) {
    return ProductInfoModel(
      id: map['id'] != null ? map['id'] as int : null,
      productName:
          map['productName'] != null ? map['productName'] as String : null,
      productDescription: map['productDescription'] != null
          ? map['productDescription'] as String
          : null,
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

  factory ProductInfoModel.fromJson(String source) =>
      ProductInfoModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProductInfoModel(id: $id, productName: $productName, productDescription: $productDescription, offerPrice: $offerPrice, originalPrice: $originalPrice, productImage: $productImage, shopName: $shopName)';
  }

  @override
  bool operator ==(covariant ProductInfoModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.productName == productName &&
        other.productDescription == productDescription &&
        other.offerPrice == offerPrice &&
        other.originalPrice == originalPrice &&
        other.productImage == productImage &&
        other.shopName == shopName;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        productName.hashCode ^
        productDescription.hashCode ^
        offerPrice.hashCode ^
        originalPrice.hashCode ^
        productImage.hashCode ^
        shopName.hashCode;
  }
}
