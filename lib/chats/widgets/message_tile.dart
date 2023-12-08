import 'package:countify/chats/models/message.dart';
import 'package:flutter/material.dart';

class MessageTile extends StatelessWidget {
  final bool isSender;
  final Message message;
  const MessageTile({
    super.key,
    required this.isSender,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    final Size(:width, :height) = MediaQuery.sizeOf(context);
    String timeZone = message.dateTime.hour > 12 ? 'PM' : 'AM';
    String minutes = message.dateTime.minute < 10
        ? '0${message.dateTime.minute}'
        : message.dateTime.minute.toString();

    return Builder(
      builder: (context) {
        if (isSender) {
          return Padding(
            padding: const EdgeInsets.all(5),
            child: Row(
              children: [
                const Spacer(
                  flex: 25,
                ),
                Expanded(
                  flex: 73,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            message.content,
                            maxLines: 20,
                            style:
                                Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.normal,
                                      fontSize: (width + height) / 60,
                                    ),
                          ),
                          Row(
                            children: [
                              const Spacer(
                                flex: 70,
                              ),
                              Expanded(
                                flex: 30,
                                child: Text(
                                  '${message.dateTime.hour}:$minutes $timeZone',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelSmall
                                      ?.copyWith(
                                        color: Colors.white,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const Spacer(
                  flex: 2,
                ),
              ],
            ),
          );
        }
        return Row(
          children: [
            const Spacer(
              flex: 2,
            ),
            Expanded(
              flex: 73,
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.5),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          message.content,
                          maxLines: 20,
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal,
                                    fontSize: (width + height) / 60,
                                  ),
                        ),
                        Row(
                          children: [
                            const Spacer(
                              flex: 70,
                            ),
                            Expanded(
                              flex: 30,
                              child: Text(
                                '${message.dateTime.hour}:$minutes $timeZone',
                                style: Theme.of(context)
                                    .textTheme
                                    .labelSmall
                                    ?.copyWith(
                                      color: Colors.white,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const Spacer(
              flex: 25,
            ),
          ],
        );
      },
    );
  }
}
