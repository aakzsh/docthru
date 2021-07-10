import 'dart:convert';

String credentials = "AAKASH";
Codec<String, String> stringToBase64 = utf8.fuse(base64);
String encoded = stringToBase64.encode(credentials); // dXNlcm5hbWU6cGFzc3dvcmQ=
String decoded = stringToBase64.decode(encoded);

encrypt() {
  print(encoded);
  // print(decoded);
}
