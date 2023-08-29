import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

class PlayerScreen extends StatefulWidget {
  const PlayerScreen(data, {super.key});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("songs"),
      ),
      body: Column(children: [
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: Container(
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(16),
              ),
            ),
            child: Column(
              children: [
                const Text(
                  "Music Name",
                ),
                const Text(
                  "Music Name",
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    const Text("0.0"),
                    Slider(
                      value: 0,
                      onChanged: (newvalue) {},
                    ),
                    const Text("4.0"),
                  ],
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
