import 'package:shared_preferences/shared_preferences.dart';

class UserLocalData {
  static SharedPreferences? _preferences;
  static Future<void> init() async =>
      _preferences = await SharedPreferences.getInstance();

  static void signout() => _preferences!.clear();
  static const String _tokenKey = 'TOKENKEY';

  static const String _uidKey = 'UIDKEY';
  static const String _emailKey = 'EMAILKEY';
  static const String _phoneNumber = 'PHONENUMBER';
  static const String _imageUrlKey = 'IMAGEURLKEY';
  static const String _createdAt = 'CREATEDAT';
  static const String _password = 'PASSWORD';
  static const String _androidNotificationToken = 'androidNotificationToken';
  static const String _isLoggedIn = 'LOGGEDIN';

  //
  // Setters
  //
  static Future<void> setUserUID(String uid) async =>
      _preferences!.setString(_uidKey, uid);

  static Future<void> setTokenKey(String tokenKey) async =>
      _preferences!.setString(_tokenKey, tokenKey);

  static Future<void> setUserPassword(String password) async =>
      _preferences!.setString(_password, password);

  static Future<void> setUserEmail(String email) async =>
      _preferences!.setString(_emailKey, email);

  static Future<void> setIsLoggedIn(bool isLoggedIn) async =>
      _preferences!.setBool(_isLoggedIn, isLoggedIn);

  static Future<void> setUserPhoneNumber(String phoneNo) async =>
      _preferences!.setString(_phoneNumber, phoneNo);

  static Future<void> setUserImageUrl(String url) async =>
      _preferences!.setString(_imageUrlKey, url);

  static Future<void> setUserCreatedAt(String date) async =>
      _preferences!.setString(_createdAt, date);

  static Future<void> setAndroidNotificationToken(String token) async =>
      _preferences!.setString(_androidNotificationToken, token);
  static Future<void> setNotLoggedIn() async =>
      _preferences!.setBool(_isLoggedIn, false);

  //
  // Getters
  //
  static String get getTokenKey => _preferences!.getString(_tokenKey) ?? '';
  static String get getUserUID => _preferences!.getString(_uidKey) ?? '';
  static String get getPassword => _preferences!.getString(_password) ?? '';
  static String get getUserEmail => _preferences!.getString(_emailKey) ?? '';
  static bool get getIsLoggedIn => _preferences!.getBool(_isLoggedIn) ?? false;
  static String get getPhoneNumber =>
      _preferences!.getString(_phoneNumber) ?? '';
  static String get getUserImageUrl =>
      _preferences!.getString(_imageUrlKey) ?? '';
  static String get getUUserCreatedAt =>
      _preferences!.getString(_createdAt) ?? '';
  static String get getAndroidNotificationToken =>
      _preferences!.getString(_androidNotificationToken) ?? '';
}
