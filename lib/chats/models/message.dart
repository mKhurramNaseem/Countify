// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Message {
  String content;
  String senderId;
  DateTime dateTime;
  static const messagesReferenceKey = 'Messages';
  Message({
    required this.content,
    required this.senderId,
    required this.dateTime,
  });

  Message copyWith({
    String? content,
    String? senderId,
    DateTime? dateTime,
  }) {
    return Message(
      content: content ?? this.content,
      senderId: senderId ?? this.senderId,
      dateTime: dateTime ?? this.dateTime,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'content': content,
      'senderId': senderId,
      'dateTime': dateTime.millisecondsSinceEpoch,
    };
  }

  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      content: map['content'] as String,
      senderId: map['senderId'] as String,
      dateTime: DateTime.fromMillisecondsSinceEpoch(map['dateTime'] as int),
    );
  }

  String toJson() => json.encode(toMap());

  factory Message.fromJson(String source) =>
      Message.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'Message(content: $content, senderId: $senderId, dateTime: $dateTime)';

  @override
  bool operator ==(covariant Message other) {
    if (identical(this, other)) return true;

    return other.content == content &&
        other.senderId == senderId &&
        other.dateTime == dateTime;
  }

  @override
  int get hashCode => content.hashCode ^ senderId.hashCode ^ dateTime.hashCode;
}
