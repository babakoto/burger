import 'package:burger/presentation/pages/detail/detail_page.dart';
import 'package:burger/presentation/pages/root_page.dart';

class AppRoute {
  static var routes = {
    RootPage.path: (context) => const RootPage(),
    DetailPage.path: (context) => const DetailPage()
  };
}
