import 'package:flutter/material.dart';
import 'package:flutter_application_1/card.dart';
import 'package:flutter_application_1/player.dart';
import 'package:just_audio/just_audio.dart';

class Song {
  final String title;
  final String artist;
  final String album;
  final String assetPath;
  final String albumCoverPath;

  Song({
    required this.title,
    required this.artist,
    required this.album,
    required this.assetPath,
    required this.albumCoverPath,
  });
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late AudioPlayer _audioPlayer;
  late List<Song> _songs;
  late Song _currentSong;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _songs = [
      Song(
        title: 'Drama',
        artist: 'aespa',
        album: 'Album 1',
        assetPath: 'assets/musics/1.mp3',
        albumCoverPath: 'assets/images/1.png',
      ),
      Song(
        title: 'Cool With You',
        artist: 'NewJeans',
        album: 'Album 2',
        assetPath: 'assets/musics/2.mp3',
        albumCoverPath: 'assets/images/2.png',
      ),
      Song(
        title: 'Magnetic',
        artist: 'ILLIT',
        album: 'Album 3',
        assetPath: 'assets/musics/3.mp3',
        albumCoverPath: 'assets/images/3.png',
      ),
      Song(
        title: 'MANIAC',
        artist: 'VIVIZ',
        album: 'Album 4',
        assetPath: 'assets/musics/4.mp3',
        albumCoverPath: 'assets/images/4.png',
      ),
      Song(
        title: 'Ditto',
        artist: 'NewJeans',
        album: 'Album 5',
        assetPath: 'assets/musics/5.mp3',
        albumCoverPath: 'assets/images/5.png',
      ),
      Song(
        title: 'Hype Boy',
        artist: 'NewJeans',
        album: 'Album 6',
        assetPath: 'assets/musics/6.mp3',
        albumCoverPath: 'assets/images/6.png',
      ),
    ];
    _currentSong = _songs.first;
    _loadSong();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _loadSong() async {
    await _audioPlayer.setFilePath(_currentSong.assetPath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Music Player 𖦹 ☼ ⋆｡˚⋆ฺ ♡',
            style: TextStyle(fontFamily: 'Poppins'),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 20),
          SongCard(
            songPath: _currentSong.assetPath,
            albumCoverPath: _currentSong.albumCoverPath,
            onAlbumCoverChanged: (newPath) {},
          ),
          SizedBox(height: 10),
          Text(
            _currentSong.title,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Text(
            _currentSong.artist,
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 20),
          PlayerBar(
            songPath: _currentSong.assetPath,
            audioPlayer: _audioPlayer,
            songs: _songs.map((song) => song.assetPath).toList(),
            onSongChanged: (index) {
              setState(() {
                _currentSong = _songs[index];
              });
              _loadSong();
            },
            onPrevious: () {
              int previousIndex = _songs.indexOf(_currentSong) - 1;
              if (previousIndex < 0) {
                previousIndex = _songs.length - 1;
              }
              setState(() {
                _currentSong = _songs[previousIndex];
              });
              _loadSong();
            },
            onNext: () {
              int nextIndex = _songs.indexOf(_currentSong) + 1;
              if (nextIndex >= _songs.length) {
                nextIndex = 0;
              }
              setState(() {
                _currentSong = _songs[nextIndex];
              });
              _loadSong();
            },
            currentIndex: 1,
          ),
        ],
      ),
    );
  }
}
