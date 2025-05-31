import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  late String content;
  String? media;
  late bool isBotSender;
  late Timestamp time;

  MessageModel({
    required this.content,
    required this.time,
    required this.isBotSender,
    this.media,
  });

  MessageModel.fromJson(Map<String, dynamic> json) {
    content = json["content"];
    media = json["media"];
    isBotSender = json["isBotSender"];
    time = json["time"];
  }
}
