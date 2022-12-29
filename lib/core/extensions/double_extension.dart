import 'package:intl/intl.dart';

extension DoubleExtension on double {
  String toEuro({String location = ""}) {
    print(this);
    var f = NumberFormat("##0.0##");
    return f.format(this);
  }
}
