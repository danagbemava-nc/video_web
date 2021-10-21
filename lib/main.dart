// import 'package:video_player/video_player.dart';
// import 'package:flutter/material.dart';

// void main() => runApp(VideoApp());

// class VideoApp extends StatefulWidget {
//   @override
//   _VideoAppState createState() => _VideoAppState();
// }

// class _VideoAppState extends State<VideoApp> {
//   late VideoPlayerController _controller;

//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.network(
//         'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
//         httpHeaders: {
//           "origin": "http://my-url.net",
//         })
//       ..initialize().then((_) {
//         // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
//         setState(() {});
//       });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Video Demo',
//       home: Scaffold(
//         body: Center(
//           child: _controller.value.isInitialized
//               ? AspectRatio(
//                   aspectRatio: _controller.value.aspectRatio,
//                   child: VideoPlayer(_controller),
//                 )
//               : Container(),
//         ),
//         floatingActionButton: FloatingActionButton(
//           onPressed: () {
//             setState(() {
//               _controller.value.isPlaying
//                   ? _controller.pause()
//                   : _controller.play();
//             });
//           },
//           child: Icon(
//             _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _controller.dispose();
//   }
// }

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt sl = GetIt.I;

Future<void> setupLocators() async {
  final SharedPreferences pref = await SharedPreferences.getInstance();

  sl.registerSingleton<SharedPreferencesService>(
      SharedPreferencesService(pref));
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupLocators();

  runApp(
    MaterialApp(
      home: TestScreen(),
    ),
  );
}

class SharedPreferencesService {
  final SharedPreferences _pref;

  final String kUsername = 'username';

  SharedPreferencesService(this._pref);

  Future<void> setUsername(String username) async {
    await _pref.setString(kUsername, username);
  }

  String getUsername() {
    return _pref.getString(kUsername) ?? '';
  }
}

class TestScreen extends StatefulWidget {
  TestScreen({Key? key}) : super(key: key);

  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(
        child: Text('+'),
        onPressed: () {
          sl.get<SharedPreferencesService>().setUsername('Nexus');
          setState(() {});
        },
      ),
    );
  }

  Widget _buildBody() {
    return Container(
      child: Center(
        child: Text(
          'Username: ${sl.get<SharedPreferencesService>().getUsername()}',
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
