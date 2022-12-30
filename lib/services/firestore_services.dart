import 'package:travel_agency/constant/constant.dart';

class FirestoreServices {
  //for get for you section data
  static getForYouPackage() {
    return firestore
        .collection(allPackages)
        .where('forYou', isEqualTo: true)
        .where('approved', isEqualTo: true)
        .get();
  }

  //for get top place section data
  static getTopPlacePackage() {
    return firestore
        .collection(allPackages)
        .where('topPlaces', isEqualTo: true)
        .where('approved', isEqualTo: true)
        .get();
  }

  //for get economy section data
  static getEconomyPackage() {
    return firestore
        .collection(allPackages)
        .where('economy', isEqualTo: true)
        .where('approved', isEqualTo: true)
        .get();
  }

  //for get luxury section data
  static getLuxuryPackage() {
    return firestore
        .collection(allPackages)
        .where('luxury', isEqualTo: true)
        .where('approved', isEqualTo: true)
        .get();
  }
}
