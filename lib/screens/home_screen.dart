import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chat_bubbles/bubbles/bubble_normal_image.dart';
import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gemini_clone_app/cubits/chat_cubit/chat_cubit.dart';
import 'package:gemini_clone_app/screens/map_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_media_recorder/audio_encoder_type.dart';
import 'package:social_media_recorder/screen/social_media_recorder.dart';
import 'package:voice_message_player/voice_message_player.dart';

import '../notification_config.dart';
import '../shared/styles/app_colors.dart';
import '../shared/widgets/my_text_form_field.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  final _messageController = TextEditingController();
  final _animationController = AnimatedTextController();
  final _scrollController = ScrollController();
  bool isEmptyText = true;
  bool isStartRecording = false;

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  XFile? selectedImage;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Builder(
      builder: (context) {
        ChatCubit.get(context).getAllMessages(); // stream
        return BlocConsumer<ChatCubit, ChatState>(
          listener: (context, state) {
            if (state is GetMessagesSuccessfully) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _scrollController.jumpTo(
                  _scrollController.position.maxScrollExtent,
                );
              });
              _scrollController.jumpTo(
                _scrollController.position.maxScrollExtent,
              );
            }
          },
          builder: (context, state) {
            ChatCubit cubit = ChatCubit.get(context);
            return Scaffold(
              key: _scaffoldKey,
              backgroundColor: AppColors.kBgColor,
              appBar: AppBar(
                backgroundColor: AppColors.kBgColor,
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(
                        "https://bgr.com/wp-content/uploads/2024/08/google-gemini-gems-bgr.jpg?quality=82&strip=all&resize=1400,1400",
                      ),
                    ),
                    SizedBox(width: 5),
                    Text(
                      "Gemini flash bot",
                      style: GoogleFonts.montserrat(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                actions: [
                  IconButton(onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (_)=>MapScreen()));
                  }, icon: Icon(Icons.location_on)),
                ],
              ),
              body:
                  state is GetUserDataLoading
                      ? Center(child: CircularProgressIndicator())
                      : Column(
                        children: [
                           Expanded(
                            child: ListView.separated(
                              controller: _scrollController,
                              addAutomaticKeepAlives: true,
                              itemBuilder: (context, index) {
                                if (index < cubit.allMessages.length) {
                                  if (!cubit.allMessages[index].isBotSender) {
                                    return Column(
                                      children: [
                                        cubit.allMessages[index].media == null
                                            ? SizedBox()
                                            :cubit.allMessages[index].content == ""? Align(
                                              alignment:Alignment.centerRight,
                                              child: VoiceMessagePlayer(
                                                                                        controller: VoiceController(
                                              audioSrc:
                                              cubit.allMessages[index].media!,
                                              onComplete: () {
                                                /// do something on complete
                                              },
                                              onPause: () {
                                                /// do something on pause
                                              },
                                              onPlaying: () {
                                                /// do something on playing
                                              },
                                              onError: (err) {
                                                /// do somethin on error
                                              },
                                              maxDuration: const Duration(seconds: 10),
                                              isFile: false,
                                                                                        ),

                                                                                        innerPadding: 12,
                                                                                        cornerRadius: 20,
                                                                                      ),
                                            )
                                        : BubbleNormalImage(
                                              id:
                                                  cubit
                                                      .allMessages[index]
                                                      .media!,
                                              image: Image.network(
                                                cubit.allMessages[index].media!,
                                              ),
                                              isSender: true,
                                              color: AppColors.kPrimaryColor,
                                            ),
                                        cubit.allMessages[index].content == ""?const SizedBox() :BubbleSpecialThree(
                                          text: cubit.allMessages[index].content
                                              .replaceAll("**", "")
                                              .replaceAll("*", ""),
                                          tail: false,
                                          isSender:
                                              !cubit
                                                  .allMessages[index]
                                                  .isBotSender,
                                          color:
                                              !cubit
                                                      .allMessages[index]
                                                      .isBotSender
                                                  ? AppColors.kPrimaryColor
                                                  : AppColors
                                                      .kLightReceiverBackgroundMessageColor,
                                          textStyle:
                                              !cubit
                                                      .allMessages[index]
                                                      .isBotSender
                                                  ? GoogleFonts.montserrat(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                  )
                                                  : GoogleFonts.montserrat(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black,
                                                  ),
                                        ),
                                      ],
                                    );
                                  } else {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 10.0,
                                      ),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                            2,
                                        alignment: Alignment.centerLeft,
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        child: AnimatedTextKit(
                                          animatedTexts: [
                                            TypewriterAnimatedText(
                                              cubit.allMessages[index].content
                                                  .replaceAll("*", ""),
                                              textStyle: GoogleFonts.montserrat(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                              ),
                                              speed: const Duration(
                                                milliseconds: 10,
                                              ),
                                            ),
                                          ],

                                          displayFullTextOnTap: true,
                                          repeatForever: false,
                                          isRepeatingAnimation: false,

                                          controller: _animationController,
                                        ),
                                      ),
                                    );
                                  }
                                } else {
                                  if (state is SendPromptToGeminiLoading ||
                                      state is SendMessageLoading) {
                                    return CircularProgressIndicator(
                                      color: AppColors.kPrimaryColor,
                                    );
                                  }
                                  return SizedBox.shrink();
                                }
                              },
                              separatorBuilder:
                                  (context, index) => SizedBox(height: 10),
                              itemCount: cubit.allMessages.length + 1,
                            ),
                          ) ,
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                !isStartRecording?Expanded(
                                  child: MyTextFormField(
                                    onChange: (value) {
                                      setState(() {
                                        isEmptyText = value!.isEmpty;
                                      });
                                    },
                                    suffixButton:
                                        selectedImage == null
                                            ? IconButton(
                                              onPressed: () {
                                                _scaffoldKey.currentState!.showBottomSheet((
                                                  context,
                                                ) {
                                                  return Container(
                                                    width: double.infinity,
                                                    color: AppColors.kBgColor,
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        TextButton(
                                                          onPressed: () async {
                                                            selectedImage =
                                                                await ImagePicker()
                                                                    .pickImage(
                                                                      source:
                                                                          ImageSource
                                                                              .camera,
                                                                    );
                                                            if (selectedImage !=
                                                                null) {
                                                              setState(() {});
                                                            }
                                                          },
                                                          child: Text(
                                                            "Camera",
                                                            style: GoogleFonts.montserrat(
                                                              fontSize: 18.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  AppColors
                                                                      .kPrimaryColor,
                                                            ),
                                                          ),
                                                        ),
                                                        TextButton(
                                                          onPressed: () async {
                                                            selectedImage =
                                                                await ImagePicker()
                                                                    .pickImage(
                                                                      source:
                                                                          ImageSource
                                                                              .gallery,
                                                                    );
                                                            if (selectedImage !=
                                                                null) {
                                                              setState(() {});
                                                            }
                                                          },
                                                          child: Text(
                                                            "Gallery",
                                                            style: GoogleFonts.montserrat(
                                                              fontSize: 18.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  AppColors
                                                                      .kPrimaryColor,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                });
                                              },
                                              icon: Icon(Icons.attachment),
                                            )
                                            : CircleAvatar(
                                              radius: 20,
                                              backgroundImage: FileImage(
                                                File(selectedImage!.path),
                                              ),
                                            ),
                                    controller: _messageController,
                                    hintText: "Enter your message ....",
                                    validatorFunction: (p0) {},
                                    prefixIcon:
                                        Icons.chat_bubble_outline_rounded,
                                  ),
                                ): const SizedBox(),
                                !isStartRecording?SizedBox(width: 10): const SizedBox(),
                                isEmptyText
                                    ? Align(

                                  alignment: Alignment.centerRight,

                                  child: SocialMediaRecorder(
                                    startRecording: () {

                                    },
                                    stopRecording: (time) {

                                    },
                                    sendRequestFunction: (soundFile,path) {
                                      print("request sent");
                                      print(soundFile.path);
                                      cubit.sendMessage(
                                        "",
                                        soundFile,
                                      );
                                    },

                                    encode: AudioEncoderType.OPUS,

                                  ),

                                )
                                    : FloatingActionButton(
                                      onPressed: () async{
                                        if (_messageController.text == "") {
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                "Message cannot be empty",
                                              ),
                                            ),
                                          );
                                        } else {
                                          if (selectedImage != null) {
                                            cubit.sendMessage(
                                              _messageController.text,
                                              File(selectedImage!.path),
                                            );
                                            NotificationConfig.sendNotification(
                                              token: (await FirebaseMessaging.instance.getToken())!, //fcm token for user
                                              title: "Gemini Test",
                                              body: _messageController.text,
                                             data:{}
                                            );
                                          } else {
                                            cubit.sendMessage(
                                              _messageController.text,
                                            );
                                            NotificationConfig.sendNotification(
                                                token: (await FirebaseMessaging.instance.getToken())!,
                                                title: "Gemini Test",
                                                body: _messageController.text,
                                                data:{}
                                            );
                                          }
                                          selectedImage = null;
                                          _messageController.clear();
                                        }
                                      },
                                      backgroundColor: AppColors.kPrimaryColor,
                                      child: Icon(
                                        Icons.send,
                                        color: Colors.white,
                                      ),
                                    ),
                              ],
                            ),
                          ),
                        ],
                      ),
            );
          },
        );
      },
    );
  }
}
