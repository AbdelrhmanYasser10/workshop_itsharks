part of 'chat_cubit.dart';

@immutable
sealed class ChatState {}

final class ChatInitial extends ChatState {}

final class GetUserDataLoading extends ChatState {}
final class GetUserDataSuccessfully extends ChatState {}
final class GetUserDataError extends ChatState {}


final class SendMessageLoading extends ChatState {}
final class SendMessageSuccessfully extends ChatState {}
final class SendMessageError extends ChatState {}


final class SendPromptToGeminiLoading extends ChatState {}
final class SendPromptToGeminiSuccessfully extends ChatState {}
final class SendPromptToGeminiError extends ChatState {}

final class GetMessagesLoading extends ChatState {}
final class GetMessagesSuccessfully extends ChatState {}