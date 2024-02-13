// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ReceivedDataModel {
  String title;
  String body;
  int userId;
  ReceivedDataModel({
    required this.title,
    required this.body,
    required this.userId,
  });

  ReceivedDataModel copyWith({
    String? title,
    String? body,
    int? userId,
  }) {
    return ReceivedDataModel(
      title: title ?? this.title,
      body: body ?? this.body,
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'body': body,
      'userId': userId,
    };
  }

  factory ReceivedDataModel.fromMap(Map<String, dynamic> map) {
    return ReceivedDataModel(
      title: map['title'] as String,
      body: map['body'] as String,
      userId: map['userId'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory ReceivedDataModel.fromJson(String source) => ReceivedDataModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ReceivedDataModel(title: $title, body: $body, userId: $userId)';

  @override
  bool operator ==(covariant ReceivedDataModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.title == title &&
      other.body == body &&
      other.userId == userId;
  }

  @override
  int get hashCode => title.hashCode ^ body.hashCode ^ userId.hashCode;
}
