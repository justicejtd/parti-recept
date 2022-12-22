import 'package:partirecept/models/business.dart';
import 'package:partirecept/services/FirestoreService.dart';
import 'package:partirecept/utilities/firestorePath.dart';

class BusinessService{
  final fireStoreService = FirestoreService.instance;

  Stream<BusinessMarker> getBusinessStream(String businessId) {
    // Business document based on the business id
    return fireStoreService.documentStream(
      path: FirestorePath.business(businessId),
      builder: (data, documentId) => BusinessMarker.fromMap(data),
    );
  }

}