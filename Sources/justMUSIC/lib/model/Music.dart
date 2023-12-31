import 'package:audioplayers/audioplayers.dart';

import 'Artist.dart';
import '../main.dart';

class Music {
  final String _id;
  String? _title;
  String? _cover;
  String? _previewUrl;
  int? _date;
  double? _duration;
  bool _explicit = false;
  List<Artist> _artists;

  // Constructor
  Music(
      this._id, this._title, this._cover, this._previewUrl, this._date, this._duration, this._explicit, this._artists);

  //Getters and setters
  String get id => _id;

  String? get title => _title;

  set title(String? value) {
    _title = value;
  }

  String? get cover => _cover;

  set cover(String? value) {
    _cover = value;
  }

  String? get previewUrl => _previewUrl;

  set previewUrl(String? value) {
    _previewUrl = value;
  }

  int? get date => _date;

  set date(int? value) {
    _date = value;
  }

  double? get duration => _duration;

  set duration(double? value) {
    _duration = value;
  }

  bool get explicit => _explicit;

  set explicit(bool value) {
    _explicit = value;
  }

  List<Artist> get artists => _artists;

  set artists(List<Artist> value) {
    _artists = value;
  }

  Future<void> playSong() async {
    if (previewUrl != null) {
      await MyApp.audioPlayer.play(UrlSource(previewUrl!));
    }
  }

  Future<void> stopSong() async {
    await MyApp.audioPlayer.stop();
  }
}
