import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:partirecept/models/business.dart';
import 'package:partirecept/providers/firebaseProviders.dart';
import 'package:partirecept/services/businessService.dart';

class BusinessProviders {
  /**
   * Get instance of business service
   */
  static final businessServiceProvider = Provider<BusinessService?>((ref) {
    final auth = ref.watch(FirebaseProviders.userStateChangesProvider);
    final uid = auth.asData?.value?.uid;

    if (uid != null) {
      return BusinessService();
    }
    return null;
  });

  /**
   * Get business stream based on business id
   */
  static final businessStreamProvider = StreamProvider.autoDispose
      .family<BusinessMarker, dynamic>((ref, businessId) {
    final service = ref.watch(BusinessProviders.businessServiceProvider)!;
    return service.getBusinessStream(businessId);
  });
}
