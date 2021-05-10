import 'package:encrypt/encrypt.dart';

final key = Key.fromUtf8('kjsdfkldshfklshfjlshfjkpoeirtfgf'); // 32 Charactor
final iv = IV.fromUtf8('dhjfjdshgfdkjsfs'); //16 Charactor

class Security {
  final String text;

  Security({this.text});

  String encrypt() {
    final encrypter = Encrypter(AES(key, mode: AESMode.cbc));
    final data = encrypter.encrypt(text, iv: iv);
    return data.base64;
  }

  String decrypt() {
    final decrypter = Encrypter(AES(key, mode: AESMode.cbc));
    final data = decrypter.decrypt(Encrypted.fromBase64(text), iv: iv);
    return data;
  }
}
