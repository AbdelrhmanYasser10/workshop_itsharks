import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloudinary/cloudinary.dart';
import 'package:firebase_ai/firebase_ai.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gemini_clone_app/models/message_model.dart';
import 'package:gemini_clone_app/models/user_model.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  static ChatCubit get(context) => BlocProvider.of(context);

  UserModel? activeUser;

  List<MessageModel> allMessages = [];

  final FirebaseFirestore _database = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final model = FirebaseAI.googleAI().generativeModel(
    model: 'gemini-2.0-flash',
  );
  final cloudinary = Cloudinary.signedConfig(
    apiKey: "759286832413946",
    apiSecret: "_I6skpHGJeC2DIAVXMkcHh6MU7s",
    cloudName: "ddksmtpkd",
  );

  void getUserData() async {
    emit(GetUserDataLoading());

    try {
      /* Auth logic */
      await _auth.signInWithEmailAndPassword(
        email: "abdelrhmanyasser123@gmail.com",
        password: "Abcd123#",
      );

      activeUser = UserModel.fromJson(
        (await _database.collection("users").doc(_auth.currentUser!.uid).get())
            .data()!,
      );

      emit(GetUserDataSuccessfully());
    } catch (err) {
      emit(GetUserDataError());
    }
  }

  void sendMessage(String content, [File? image]) async {
    //store to firebase
    emit(SendMessageLoading());
    try {
      CloudinaryResponse? response;
      if (image != null) {
        response = await cloudinary.upload(
          file: image.path,
          fileBytes: image.readAsBytesSync(),
          resourceType: CloudinaryResourceType.image,
          folder: "Gemini - Images",
          fileName: 'some-name',
          progressCallback: (count, total) {
            print('Uploading image from file with progress: $count/$total');
          },
        );
      }
      await _database
          .collection("users")
          .doc(activeUser!.id)
          .collection("chats")
          .doc("0")
          .collection("messages")
          .add({
            "isBotSender": false,
            "time": Timestamp.now(),
            "content": content,
            "media": response?.url!,
          });
      sendPromptToGemini(content,image);
      emit(SendMessageSuccessfully());
    } catch (error) {
      emit(SendMessageError());
    }
  }

  void sendPromptToGemini(String content, [File? file]) async {
    emit(SendPromptToGeminiLoading());
    try {
      if(file == null) {
        final response = await model.generateContent([Content.text(content)]);
        await _database
            .collection("users")
            .doc(activeUser!.id)
            .collection("chats")
            .doc("0")
            .collection("messages")
            .add({
          "isBotSender": true,
          "time": Timestamp.now(),
          "content": response.text,
          "media": null,
        });
      }
      else{
        final prompt = TextPart(content);
// Prepare images for input
        final image = await file.readAsBytes();
        final imageExtenstion = file.path.split("/").last.split(".").last;
        final imagePart = InlineDataPart('image/$imageExtenstion', image);

// To generate text output, call generateContent with the text and image
        final response = await model.generateContent([
          Content.multi([prompt,imagePart])
        ]);

        await _database
            .collection("users")
            .doc(activeUser!.id)
            .collection("chats")
            .doc("0")
            .collection("messages")
            .add({
          "isBotSender": true,
          "time": Timestamp.now(),
          "content": response.text,
          "media": null,
        });
      }
      emit(SendPromptToGeminiSuccessfully());
    } catch (error) {
      emit(SendPromptToGeminiError());
    }
  }

  // Real - time
  void getAllMessages() {
    emit(GetMessagesLoading());

    _database
        .collection("users")
        .doc(activeUser!.id)
        .collection("chats")
        .doc("0")
        .collection("messages")
        .orderBy("time")
        .snapshots()
        .listen((event) {
          allMessages = [];
          for (var json in event.docs) {
            MessageModel currMessage = MessageModel.fromJson(json.data());
            allMessages.add(currMessage);
          }
          emit(GetMessagesSuccessfully());
        });
  }
}
