import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task/models/user_model.dart';

class UserService {
   static CollectionReference<UserModel> getUserCollection() => FirebaseFirestore
      .instance
      .collection('users')
      .withConverter<UserModel>(
        fromFirestore:
            (snapshot, _) => UserModel.fromJson(snapshot.data() ?? {}),
        toFirestore: (value, _) => value.toJson(),
      );

  static DocumentReference<UserModel> getUserDoc(String email) =>
      getUserCollection().doc(email);

        static Future<UserModel?> getUser(String email) async {
    DocumentSnapshot<UserModel> documentSnapshot = await getUserDoc(email).get();
    return documentSnapshot.data();
  }

  static Future<UserModel?> login(String email, String password) async {
    UserModel? user = await getUser(email);
    if (user != null && user.password == password) {
      return user;
    }
    return null;
  }

  static Future<bool> resetPassword(String email, String newPassword) async {
    try {
      UserModel? user = await getUser(email);
      if (user != null) {
        await getUserDoc(email).update({'password': newPassword});
        return true;
      }
      return false;
    } catch (e) {
      print("Error updating password: $e");
      return false;
    }
  }
}