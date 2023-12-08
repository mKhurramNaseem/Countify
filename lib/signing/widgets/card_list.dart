import 'package:countify/chats/views/chats_master_screen.dart';
import 'package:countify/signing/widgets/my_card.dart';
import 'package:flutter/material.dart';

class CardsList extends StatefulWidget {
  const CardsList({super.key});

  @override
  State<CardsList> createState() => _CardsListState();
}

class _CardsListState extends State<CardsList> {
  static const chatText = 'CHATS', postText = 'POSTS', newsText = 'NEWS';

  void _onChatsTap() {
    Navigator.of(context).pushNamed(ChatsMasterScreen.name);
  }

  void _onPostsTap() {}

  void _onNewsTap() {}

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        MyCard(
          text: chatText,
          backgroundColor: Colors.blue,
          onTap: _onChatsTap,
        ),
        MyCard(
          text: postText,
          backgroundColor: Colors.red,
          onTap: _onPostsTap,
        ),
        MyCard(
          text: newsText,
          backgroundColor: Colors.green,
          onTap: _onNewsTap,
        ),
      ],
    );
  }
}
