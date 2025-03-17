import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:task/firebase/user_service.dart';
import 'package:task/models/review_model.dart';

class ReviewService {
  static CollectionReference<ReviewModel> getUserReviews(String email) {
    return UserService.getUserDoc(email)
        .collection('reviews')
        .withConverter<ReviewModel>(
          fromFirestore: (snapshot, _) {
            return ReviewModel.fromJson(snapshot.data() ?? {});
          },
          toFirestore: (value, _) => value.toJson(),
        );
  }

  static Future<void> addReview(String email, ReviewModel review) async {
    CollectionReference<ReviewModel> reviewsCollection = getUserReviews(email);
    DocumentReference<ReviewModel> documentReference = reviewsCollection.doc();
    review.id = documentReference.id;
    await documentReference.set(review);
  }

  static Future<void> editReview(String email, ReviewModel review) async {
    await getUserReviews(email).doc(review.id).update(review.toJson());
  }

  static Stream<List<ReviewModel>> getUserReviewsStream(String email) {
    return getUserReviews(email).snapshots().map(
      (snapshot) => snapshot.docs.map((doc) => doc.data()).toList(),
    );
  }

  static Future<void> deleteReview(String email, String reviewId) async {
    await getUserReviews(email).doc(reviewId).delete();
  }
}
