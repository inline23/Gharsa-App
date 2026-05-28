import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gharsa_app/features/chatbot/presentation/cubit/chat_cubit.dart';
import 'package:gharsa_app/features/chatbot/presentation/cubit/chat_state.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController controller = TextEditingController();
  final ScrollController scrollController = ScrollController();

  @override
  void dispose() {
    controller.dispose();
    scrollController.dispose();
    super.dispose();
  }

  void scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  String formatTime(DateTime time) {
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return "$hour:$minute";
  }

  Future<void> sendMessage(ChatCubit cubit, ChatState state) async {
    final text = controller.text.trim();

    if (text.isEmpty || state.isLoading) return;

    if (cubit.sessionId == null) {
      await cubit.createSession();
    }

    await cubit.sendMessage(text);

    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF6F7F9),

      /// ================= APP BAR =================
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Gharsa 🌱",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),

      /// ================= BODY =================
      body: Column(
        children: [
          /// ================= MESSAGES =================
          Expanded(
            child: BlocConsumer<ChatCubit, ChatState>(
              listener: (context, state) {
                scrollToBottom();
              },
              builder: (context, state) {
                /// LOADING FIRST TIME
                if (state.isLoading && state.messages.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }

                /// EMPTY STATE
                if (state.messages.isEmpty) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.eco, size: 70, color: Color(0xff2E7D32)),
                        SizedBox(height: 12),
                        Text(
                          "Welcome to Gharsa 🌱",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          "Ask anything about plants and farming",
                          style: TextStyle(color: Colors.black54, fontSize: 14),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  controller: scrollController,
                  padding: const EdgeInsets.all(12),
                  itemCount:
                      state.messages.length + (state.isBotTyping ? 1 : 0),
                  itemBuilder: (context, index) {
                    /// TYPING INDICATOR
                    if (index >= state.messages.length) {
                      return Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: const SizedBox(
                            width: 40,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CircleAvatar(radius: 3),
                                CircleAvatar(radius: 3),
                                CircleAvatar(radius: 3),
                              ],
                            ),
                          ),
                        ),
                      );
                    }

                    final msg = state.messages[index];

                    return Align(
                      alignment: msg.isUser
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 10,
                        ),
                        constraints: const BoxConstraints(maxWidth: 280),
                        decoration: BoxDecoration(
                          color: msg.isUser
                              ? const Color(0xff2E7D32)
                              : Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(16),
                            topRight: const Radius.circular(16),
                            bottomLeft: Radius.circular(msg.isUser ? 16 : 0),
                            bottomRight: Radius.circular(msg.isUser ? 0 : 16),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              msg.text,
                              style: TextStyle(
                                color: msg.isUser
                                    ? Colors.white
                                    : Colors.black87,
                                fontSize: 14,
                                height: 1.4,
                              ),
                            ),

                            const SizedBox(height: 5),

                            Text(
                              formatTime(msg.time),
                              style: TextStyle(
                                fontSize: 10,
                                color: msg.isUser
                                    ? Colors.white70
                                    : Colors.black45,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),

          /// ================= INPUT =================
          BlocBuilder<ChatCubit, ChatState>(
            builder: (context, state) {
              final cubit = context.read<ChatCubit>();

              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12.withOpacity(0.04),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    /// TEXT FIELD
                    Expanded(
                      child: TextField(
                        controller: controller,

                        onSubmitted: (_) async {
                          await sendMessage(cubit, state);
                        },

                        decoration: InputDecoration(
                          hintText: "Type a message...",

                          filled: true,
                          fillColor: const Color(0xffF3F4F6),

                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),

                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),

                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),

                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 8),

                    /// SEND BUTTON
                    GestureDetector(
                      onTap: state.isLoading
                          ? null
                          : () async {
                              await sendMessage(cubit, state);
                            },

                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),

                        padding: const EdgeInsets.all(12),

                        decoration: BoxDecoration(
                          color: state.isLoading
                              ? Colors.grey
                              : const Color(0xff2E7D32),
                          shape: BoxShape.circle,
                        ),

                        child: state.isLoading
                            ? const SizedBox(
                                width: 18,
                                height: 18,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const Icon(
                                Icons.send,
                                color: Colors.white,
                                size: 20,
                              ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
