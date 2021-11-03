// import 'package:ceo_transport/models/userModel.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class UserLocalData {
//   static late SharedPreferences? _preferences;
//   static Future<void> init() async =>
//       _preferences = await SharedPreferences.getInstance();

//   static void signout() => _preferences!.clear();

//   static const String _uidKey = 'UIDKEY';
//   static const String _emailKey = 'EMAILKEY';
//   static const String _displayNameKey = 'DISPLAYNAMEKEY';
//   static const String _phoneNumber = 'PHONENUMBER';
//   static const String _imageUrlKey = 'IMAGEURLKEY';
//   static const String _createdAt = 'CREATEDAT';
//   static const String _isAdmin = 'ISADMIN';
//   static const String _androidNotificationToken = 'androidNotificationToken';

//   //s
//   // Setters
//   //
//   static Future<void> setUserUID(String uid) async =>
//       _preferences!.setString(_uidKey, uid);

//   static Future<void> setIsAdmin(bool isAdmin) async =>
//       _preferences!.setBool(_isAdmin, isAdmin);

//   static Future<void> setUserEmail(String email) async =>
//       _preferences!.setString(_emailKey, email);

//   static Future<void> setUserDisplayName(String name) async =>
//       _preferences!.setString(_displayNameKey, name);

//   static Future<void> setUserPhoneNumber(String phoneNo) async =>
//       _preferences!.setString(_phoneNumber, phoneNo);

//   static Future<void> setUserImageUrl(String url) async =>
//       _preferences!.setString(_imageUrlKey, url);

//   static Future<void> setUserCreatedAt(String date) async =>
//       _preferences!.setString(_createdAt, date);

//   static Future<void> setAndroidNotificationToken(String token) async =>
//       _preferences!.setString(_androidNotificationToken, token);

//   //
//   // Getters
//   //
//   static String get getUserUID => _preferences!.getString(_uidKey) ?? '';
//   static bool get getIsAdmin => _preferences!.getBool(_isAdmin) ?? false;
//   static String get getUserEmail => _preferences!.getString(_emailKey) ?? '';
//   static String get getUserDisplayName =>
//       _preferences!.getString(_displayNameKey) ?? '';
//   static String get getPhoneNumber =>
//       _preferences!.getString(_phoneNumber) ?? '';
//   static String get getUserImageUrl =>
//       _preferences!.getString(_imageUrlKey) ?? '';
//   static String get getUUserCreatedAt =>
//       _preferences!.getString(_createdAt) ?? '';
//   static String get getAndroidNotificationToken =>
//       _preferences!.getString(_androidNotificationToken) ?? '';

//   void storeAppUserData({required AppUserModel appUser, String token = ''}) {
//     setUserUID(appUser.id!);
//     setUserEmail(appUser.email!);
//     setIsAdmin(appUser.isAdmin!);
//     setUserDisplayName(appUser.name!);
//     setUserImageUrl(appUser.imageUrl!);
//     setUserCreatedAt(appUser.joinedAt!);
//     setAndroidNotificationToken(token);
//   }
// }
