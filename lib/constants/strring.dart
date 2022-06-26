import 'dart:math';

const _chars =
    'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
getRandomString(){
  Random _rnd = Random();

  String randomString=    String.fromCharCodes(Iterable.generate(
          15, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  return randomString;

}
class appl {
  static String chatId = "";
  static String message="";
}