import 'dart:io';
import 'dart:typed_data';

class AudioAnalyzer {
  Future<List<double>> analyzeAudio(String filePath) async {
    final file = File(filePath);
    final bytes = await file.readAsBytes();

    final sampleRate =
        44100; // Τυπικός ρυθμός δειγματοληψίας για ήχο CD quality
    final secondsPerChunk = 1.0; // Διάρκεια ανάλυσης ανά δευτερόλεπτο
    final chunkSize = (sampleRate * secondsPerChunk).round();

    final numChunks = (bytes.length / chunkSize).ceil();
    final result = <double>[];

    for (int i = 0; i < numChunks; i++) {
      final start = i * chunkSize;
      final end = (i + 1) * chunkSize;
      final chunk = bytes.sublist(start, end);

      // Υπολογισμός μέσης τιμής έντασης του ήχου για το τρέχον κομμάτι
      double averageAmplitude = 0;
      for (int j = 0; j < chunk.length; j += 2) {
        final sample = ByteData.sublistView(chunk, j, j + 2);
        final amplitude = sample.getInt16(0, Endian.little).abs() / 32768.0;
        averageAmplitude += amplitude;
      }
      averageAmplitude /= chunk.length / 2;

      result.add(averageAmplitude);
      print(averageAmplitude);
    }
    print(result.length);
    return result;
  }
}

// void main() async {
//   final analyzer = AudioAnalyzer();
//   final audioFilePath =
//       'your_audio_file_path.mp3'; // Αντικαταστήστε το με το αρχείο ήχου σας
//   final intensityData = await analyzer.analyzeAudio(audioFilePath);
//   print(intensityData);
// }
