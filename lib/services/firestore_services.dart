import 'package:travel_agency/constant/constant.dart';

class FirestoreServices {
  //for get for you section data
  static getForYouPackage() {
    return firestore
        .collection(allPackages)
        .where('phone', isNotEqualTo: '')
        .get();
  }

  //for get recently added  section data
  static getRecentlyAddedPackage() {
    return firestore
        .collection(allPackages)
        .orderBy("date_time", descending: true)
        .get();
  }

  //for get top place section data
  static getTopPlacePacakge() {
    return firestore
        .collection(allPackages)
        .where('cost', isGreaterThanOrEqualTo: 2000, isLessThanOrEqualTo: 5000)
        .get();
  }

  //for get economy section data
  static getEconomyPacakge() {
    return firestore
        .collection(allPackages)
        .where('cost', isLessThan: 3000)
        .get();
  }

  //for get luxery section data
  static getLuxeryPacakge() {
    return firestore
        .collection(allPackages)
        .where('cost', isGreaterThan: 10000)
        .get();
  }
}
