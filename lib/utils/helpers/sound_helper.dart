import 'package:audioplayers/audioplayers.dart';

class SoundHelper {
  static final AudioPlayer _audioPlayer = AudioPlayer();

  static Future<void> playSuccessSound() async {
    try {
      await _audioPlayer.play(
        AssetSource(
          'sounds/success_sound.mp3',
        ),
      );
      // ignore: empty_catches
    } catch (e) {}
  }

  static Future<void> playFailureSound() async {
    try {
      await _audioPlayer.play(
        AssetSource(
          'sounds/failure_sound.mp3',
        ),
      );
      // ignore: empty_catches
    } catch (e) {}
  }
}
