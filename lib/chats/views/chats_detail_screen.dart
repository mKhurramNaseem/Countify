import 'package:countify/chats/models/message.dart';
import 'package:countify/chats/widgets/message_tile.dart';
import 'package:countify/signing/model/user.dart';
import 'package:countify/util/theme/color_theme.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ChatsDetailScreen extends StatefulWidget {
  static const name = '/chatsdetailscreen';
  const ChatsDetailScreen({super.key});

  @override
  State<ChatsDetailScreen> createState() => _ChatsDetailScreenState();
}

class _ChatsDetailScreenState extends State<ChatsDetailScreen> {
  
  User recepientUser = User(userName: '', email: '', password: '', userId: '');
  late User currentUser;
  late List<Message> messageList;
  late DatabaseReference messageReference;
  late TextEditingController messageController;
  bool isLoading = true;
  

  @override
  void initState() {
    super.initState();
    messageController = TextEditingController();
    messageList = [];
    messageReference =
        FirebaseDatabase.instance.ref().child(Message.messagesReferenceKey);

    currentUser = User.getInstance();
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    recepientUser =
        (ModalRoute.of(context)?.settings.arguments ?? recepientUser) as User;
    messageReference
        .child(currentUser.userId)
        .child(recepientUser.userId)
        .onChildAdded
        .listen((event) {
      isLoading = false;
      messageList.add(messageFromSnapshot(event.snapshot));
      _updateScreen();
    });
  }

  Message messageFromSnapshot(DataSnapshot snapshot) {
    Map<String, dynamic> userMap =
        Map<String, dynamic>.from(snapshot.value as Map);
    return Message.fromMap(userMap);
  }

  void _updateScreen() {
    if (mounted) {
      setState(() {});
    }
  }

  void _onBtnSend() {
    Message message = Message(
        content: messageController.text,
        senderId: currentUser.userId,
        dateTime: DateTime.now());
    // Updating References for both Ends
    messageReference
        .child(currentUser.userId)
        .child(recepientUser.userId)
        .push()
        .set(message.toMap());
    messageReference
        .child(recepientUser.userId)
        .child(currentUser.userId)
        .push()
        .set(message.toMap());

    // Clearing text
    messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    var Size(:width, :height) = MediaQuery.sizeOf(context);
    height -= kToolbarHeight;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColorScheme.primary,
        foregroundColor: Colors.white,
        title: Text(recepientUser.userName),
      ),
      body: SizedBox(
        width: width,
        height: height,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            SizedBox(
              height: height * 0.93,
              child: isLoading
                  ? const Center(child: CircularProgressIndicator.adaptive())
                  : CustomScrollView(
                      physics: const BouncingScrollPhysics(),
                      slivers: [
                        
                        SliverList.builder(
                            itemCount: messageList.length,
                            itemBuilder: (context, index) {
                              if (messageList[index]
                                      .senderId
                                      .compareTo(currentUser.userId) ==
                                  0) {
                                return MessageTile(
                                  isSender: true,
                                  message: messageList[index],
                                );
                              } else {
                                return MessageTile(
                                  isSender: false,
                                  message: messageList[index],
                                );
                              }
                            }),
                        SliverToBoxAdapter(
                          child: SizedBox(
                            height: height * 0.07,
                          ),
                        ),
                      ],
                    ),
            ),
            Container(
              color: Colors.white,
              height: height * 0.08,
              child: Row(
                children: [
                  SizedBox(
                    width: width * 0.02,
                  ),
                  SizedBox(
                    width: width * 0.8,
                    child: TextField(
                      controller: messageController,
                      style: Theme.of(context).textTheme.labelSmall,
                      cursorHeight: height * 0.04,
                      cursorColor: Colors.black,
                      textInputAction: TextInputAction.newline,
                      decoration: const InputDecoration(
                        hintText: 'Message',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              100,
                            ),
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(
                              100,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: width * 0.18,
                    child: GestureDetector(
                      onTap: _onBtnSend,
                      child: CircleAvatar(
                        radius: width * 0.1,
                        backgroundColor: AppColorScheme.primary,
                        child: const Icon(
                          Icons.send,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
