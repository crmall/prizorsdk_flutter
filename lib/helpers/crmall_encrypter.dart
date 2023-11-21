import 'package:encrypt/encrypt.dart';

class CrmallEncrypter {
  static String secret = "/wOVAYVb27Nrfif9";

  static String? encrypt(String message) {
    /// Encrypts a [message] using AES encryption.
    /// It receives a [message] as a parameter.
    /// It returns a [String] with the encrypted message.
    /// If the encryption fails, it returns null.
    /// The [secret] is a constant that is used to encrypt the message.
    /// It is defined in the [lib/prizorsdk_flutter.dart] file.
    try {
      final key = Key.fromUtf8(secret);
      final iv = IV.fromLength(16);
      final encrypter =
          Encrypter(AES(key, mode: AESMode.cbc, padding: 'PKCS7'));
      final encrypted = encrypter.encrypt(message, iv: iv);
      return encrypted.base64;
    } catch (e, stacktrace) {
      print(
          'Crmall encrypter fail | error: ${e.toString()} | stacktrace: ${stacktrace.toString()}');
      return null;
    }
  }
}
