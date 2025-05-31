import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gemini_clone_app/cubits/chat_cubit/chat_cubit.dart';
import 'package:google_fonts/google_fonts.dart';

import '../shared/styles/app_colors.dart';
import '../shared/widgets/my_text_form_field.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with AutomaticKeepAliveClientMixin {
  final _messageController = TextEditingController();
  final _animationController = AnimatedTextController();
  final _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();

  }
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {

    return Builder(
      builder: (context) {
        ChatCubit.get(context).getAllMessages(); // stream
        return BlocConsumer<ChatCubit, ChatState>(
          listener: (context, state) {
            if(state is GetMessagesSuccessfully){
              WidgetsBinding.instance.addPostFrameCallback((_) {
                _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
              });
              _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
            }
          },
          builder: (context, state) {
            ChatCubit cubit = ChatCubit.get(context);
            return Scaffold(
              backgroundColor: AppColors.kBgColor,
              appBar: AppBar(
                backgroundColor: AppColors.kBgColor,
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: NetworkImage(
                          "https://bgr.com/wp-content/uploads/2024/08/google-gemini-gems-bgr.jpg?quality=82&strip=all&resize=1400,1400"
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
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
              ),
              body: state is GetUserDataLoading ? Center(child: CircularProgressIndicator(),) :Column(
                children: [
                  Expanded(
                      child: ListView.separated(
                        controller: _scrollController,
                        addAutomaticKeepAlives: true,
                          itemBuilder: (context, index) {
                          if(index < cubit.allMessages.length) {
                            if (!cubit.allMessages[index].isBotSender) {
                              return BubbleSpecialThree(
                                text: cubit.allMessages[index].content
                                    .replaceAll("**", "").replaceAll("*", ""),
                                tail: false,
                                isSender: !cubit.allMessages[index].isBotSender,
                                color: !cubit.allMessages[index].isBotSender ?
                                AppColors.kPrimaryColor :
                                AppColors.kLightReceiverBackgroundMessageColor,
                                textStyle: !cubit.allMessages[index].isBotSender
                                    ?
                                GoogleFonts.montserrat(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                )
                                    : GoogleFonts.montserrat(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              );
                            }
                            else {
                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Container(

                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width / 2,
                                  alignment: Alignment.centerLeft,
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12)
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
                                        speed: const Duration(milliseconds: 10),
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
                          }
                          else{
                            if(state is SendPromptToGeminiLoading || state is SendMessageLoading){
                              return CircularProgressIndicator(
                                color: AppColors.kPrimaryColor,
                              );
                            }
                            return SizedBox.shrink();
                          }
                          },
                          separatorBuilder: (context, index) => SizedBox(height: 10,),
                        itemCount: cubit.allMessages.length + 1,
                      ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: MyTextFormField(
                            controller: _messageController,
                            hintText: "Enter your message ....",
                            validatorFunction: (p0) {

                            },
                            prefixIcon: Icons.chat_bubble_outline_rounded,
                          ),
                        ),
                        SizedBox(width: 10,),
                        FloatingActionButton(
                          onPressed: () {
                            if(_messageController.text == ""){
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(
                                  "Message cannot be empty"
                                ))
                              );
                            }
                            else {
                              cubit.sendMessage(_messageController.text);
                              _messageController.clear();
                            }
                          },
                          backgroundColor: AppColors.kPrimaryColor,
                          child: Icon(Icons.send, color: Colors.white,),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }
    );
  }
}
