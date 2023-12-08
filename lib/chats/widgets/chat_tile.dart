import 'package:countify/chats/views/chats_detail_screen.dart';
import 'package:countify/signing/model/user.dart';
import 'package:flutter/material.dart';

class ChatTile extends StatefulWidget {
  final User user;
  const ChatTile({
    super.key,
    required this.user,
  });

  @override
  State<ChatTile> createState() => _ChatTileState();
}

class _ChatTileState extends State<ChatTile> {
  static const heightPercent = 0.11;
  static const cardElevation = 10.0;

  void _onTap() {
    Navigator.of(context)
        .pushNamed(ChatsDetailScreen.name, arguments: widget.user);
  }

  @override
  Widget build(BuildContext context) {
    final Size(:width, :height) = MediaQuery.sizeOf(context);
    return GestureDetector(
      onTap: _onTap,
      child: SizedBox(
        height: height * heightPercent,
        child: Card(
          elevation: cardElevation,
          margin: const EdgeInsets.all(
            10,
          ),
          child: Row(
            children: [
              const Spacer(
                flex: 5,
              ),
              Expanded(
                flex: 95,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(
                      flex: 10,
                    ),
                    Expanded(
                      flex: 40,
                      child: Text(
                        widget.user.userName,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            fontStyle: FontStyle.italic,
                            fontSize: (width + height) / 60),
                      ),
                    ),
                    const Spacer(
                      flex: 10,
                    ),
                    Expanded(
                      flex: 30,
                      child: Text(
                        widget.user.email,
                        style: Theme.of(context)
                            .textTheme
                            .labelSmall
                            ?.copyWith(fontSize: (width + height) / 80),
                      ),
                    ),
                    const Spacer(
                      flex: 10,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
