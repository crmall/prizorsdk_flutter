import 'package:encrypt/encrypt.dart';

class CrmallEncrypter {
  static String secret = "/wOVAYVb27Nrfif9";

  static String? encrypt(String message) {
    try {
      final key = Key.fromUtf8(secret);
      final iv = IV.fromLength(16);
      final encrypter = Encrypter(AES(key, mode: AESMode.cbc, padding: 'PKCS7'));
      final encrypted = encrypter.encrypt(message, iv: iv);
      return encrypted.base64;
    } catch (_) {
      return null;
    }
  }
}
