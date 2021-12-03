import 'package:starter_d/helper/constant/var.dart';

class Urls {
  static const String mainUrlDev = 'https://mobile.myduma.id/';
  static const String mainUrlProd = 'https://mobile.myduma.id/';
  static const String mainUrl = Var.isDebugMode ? mainUrlDev : mainUrlProd;
  static const String mainApiUrl = mainUrl + 'api/v1/';

  static const taskAll = mainApiUrl + 'master/task/all';
  static const taskCreate = mainApiUrl + 'master/task/create';
  static const taskUpdate = mainApiUrl + 'master/task/update';
  static const taskDelete = mainApiUrl + 'master/task/delete';
}
