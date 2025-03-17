import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task/models/company_model.dart';

class Services {
  static CollectionReference<CompanyModel> getCompanyCollection() =>
      FirebaseFirestore.instance
          .collection('companies')
          .withConverter<CompanyModel>(
            fromFirestore:
                (snapshot, _) => CompanyModel.fromJson(snapshot.data() ?? {}),
            toFirestore: (value, _) => value.toJson(),
          );

  static Stream<List<CompanyModel>> getAllCompanies() {
    return getCompanyCollection().snapshots().map(
      (snapshot) => snapshot.docs.map((doc) => doc.data()).toList(),
    );
  }
}
