import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task/firebase/user_service.dart';
import 'package:task/models/account_details_model.dart';

class AccountService {
  static DocumentReference<AccountDetailsModel> getUserAccountDetailsRef(
    String email,
  ) =>
      UserService.getUserDoc(email)
          .collection('account_details')
          .doc('account_info') // Fixed document ID
          .withConverter<AccountDetailsModel>(
            fromFirestore: (snapshot, _) {
              var data = snapshot.data() ?? {};
              return AccountDetailsModel.fromJson(data);
            },
            toFirestore: (value, _) => value.toJson(),
          );

  static Future<void> setAccountDetails(
    String email,
    AccountDetailsModel accountDetails,
  ) async {
    await getUserAccountDetailsRef(email).set(accountDetails);
  }

  static Future<AccountDetailsModel?> getAccountDetails(String email) async {
    final docSnapshot = await getUserAccountDetailsRef(email).get();
    if (docSnapshot.exists) {
      return docSnapshot.data();
    }
    return null;
  }

  static Future<void> updateAccountDetails(
    String email,
    Map<String, dynamic> updates,
  ) async {
    await getUserAccountDetailsRef(email).update(updates);
  }
}
