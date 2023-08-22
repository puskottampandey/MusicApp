import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:musicapp/constant.dart';
import 'package:musicapp/views/musicplayer_screen.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isplaying = false;
  final OnAudioQuery onaudioquery = OnAudioQuery();
  final AudioPlayer audioplayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    checkPermission();
  }

  checkPermission() async {
    final per = Permission.storage.request();
    if (await per.isGranted) {
    } else {
      checkPermission();
    }
  }

  playSongs(String? uri) {
    try {
      audioplayer.setAudioSource(AudioSource.uri(Uri.parse(uri!)));
      audioplayer.play();
    } on Exception catch (e) {
      e;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
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
            FutureBuilder<List<SongModel>>(
              future: onaudioquery.querySongs(
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
                      padding: const EdgeInsets.all(8.0),
                      child: ListView.builder(
                        physics: const BouncingScrollPhysics(),
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) =>
                                          PlayerScreen(index))));
                            },
                            child: Card(
                              margin: const EdgeInsets.only(bottom: 5),
                              elevation: 2,
                              shadowColor: Colors.blueAccent,
                              color: Colors.white,
                              child: ListTile(
                                leading: CircleAvatar(
                                  child: QueryArtworkWidget(
                                      id: snapshot.data![index].id,
                                      type: ArtworkType.AUDIO),
                                ),
                                title: Text(
                                  snapshot.data![index].displayNameWOExt,
                                  style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                                subtitle: Text(
                                  snapshot.data![index].duration.toString(),
                                  style: const TextStyle(
                                      fontSize: 16, color: card),
                                ),
                                trailing: IconButton(
                                    onPressed: () {
                                      playSongs(snapshot.data![index].uri);
                                      setState(() {
                                        isplaying = !isplaying;
                                      });
                                    },
                                    icon: Icon(
                                      isplaying
                                          ? Icons.play_arrow_sharp
                                          : Icons.play_arrow,
                                      color: card,
                                    )),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
