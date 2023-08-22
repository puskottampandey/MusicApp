import 'package:flutter/material.dart';

class PlayerScreen extends StatefulWidget {
  const PlayerScreen(data, {super.key});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        title: const Text("songs"),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 87,
          ),
          Container(
            height: MediaQuery.sizeOf(context).height * 0.4,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 330,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(16)),
            ),
          )
        ],
      ),
    );
  }
}
