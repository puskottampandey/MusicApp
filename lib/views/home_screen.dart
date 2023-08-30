import 'package:flutter/material.dart';

import 'package:musicapp/constant.dart';
import 'package:musicapp/controller/contoller.dart';
import 'package:musicapp/views/musicplayer_screen.dart';
import 'package:on_audio_query/on_audio_query.dart';

import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    final permission = Provider.of<SongsProvider>(context, listen: false);
    permission.checkPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
        title: const Center(
          child: Text(
            "Music App",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Songs",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.search_rounded,
                      color: Colors.white,
                      size: 25,
                    ))
              ],
            ),
            Consumer<SongsProvider>(
              builder: ((context, value, child) {
                return FutureBuilder<List<SongModel>>(
                  future: value.onaudioquery.querySongs(
                    ignoreCase: true,
                    sortType: null,
                    orderType: OrderType.ASC_OR_SMALLER,
                    uriType: UriType.EXTERNAL,
                  ),
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.data == null) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.data!.isEmpty) {
                      return const Text("No songs");
                    } else {
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              final data = snapshot.data![index];

                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: ((context) =>
                                              PlayerScreen(data: data))));
                                },
                                child: Card(
                                  margin: const EdgeInsets.only(bottom: 5),
                                  elevation: 2,
                                  color: const Color.fromARGB(255, 27, 27, 27),
                                  child: ListTile(
                                    leading: CircleAvatar(
                                      child: QueryArtworkWidget(
                                        id: data.id,
                                        type: ArtworkType.AUDIO,
                                      ),
                                    ),
                                    title: Text(
                                      data.displayNameWOExt,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    subtitle: Text(
                                      data.duration.toString(),
                                      style: const TextStyle(
                                          fontSize: 10, color: card),
                                    ),
                                    trailing: IconButton(
                                      onPressed: () {
                                        if (value.isplaying) {
                                          value.stopMusic();
                                        } else {
                                          value.playSongs(data.uri, index);
                                        }
                                      },
                                      icon: Icon(value.playIndex == index &&
                                              value.isplaying
                                          ? Icons.pause
                                          : Icons.play_arrow),
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    }
                  },
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
