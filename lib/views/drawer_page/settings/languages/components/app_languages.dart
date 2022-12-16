import 'package:get/get.dart';
import 'package:travel_agency/views/drawer_page/settings/languages/bangla.dart';
import 'package:travel_agency/views/drawer_page/settings/languages/english.dart';

class AppLanguages extends Translations{

  @override
  Map<String, Map<String, String>> get keys => {
    'en_US': english,
    'bn_BD': bangla,
  };

}