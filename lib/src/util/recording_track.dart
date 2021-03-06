// Provides additional functionality required when recording

import 'package:path/path.dart';
import 'package:sounds_common/sounds_common.dart';

import '../media_format/native_media_format.dart';
import '../sound_recorder.dart';

/// a track.
class RecordingTrack {
  /// Create a [RecordingTrack] from a [Track] for tracks
  /// that were created via [Track.fromFile].
  ///
  /// Throws a [MediaFormatException] if the requested [MediaFormat]
  /// is not supported.
  ///
  RecordingTrack(this.track, this.mediaFormat) {
    if (!track.isFile) {
      ArgumentError('Only Tracks created via [Track.fromFile] are supported');
    }

    if (FileUtil().exists(track.path!)) {
      FileUtil().truncate(track.path!);
    }
  }

  ///
  Track track;

  /// The [MediaFormat] to record to.
  NativeMediaFormat mediaFormat;

  /// Used by the [SoundRecorder] to update the [Track]'s duration
  /// as the track is recorded into.
  //ignore: avoid_setters_without_getters
  set duration(Duration duration) {
    setTrackDuration(track, duration);
  }

  /// Check that the target recording path is valid
  void validatePath() {
    /// the directory where we are recording to MUST exist.
    if (!FileUtil().directoryExists(dirname(track.path!))) {
      throw DirectoryNotFoundException(
          'The directory ${dirname(track.path!)} must exists');
    }
  }

  /// Release all system resources for the track.
  void release() {
    trackRelease(track);
  }
}
