import 'dart:io';

import 'package:com.example.moex/core/resource_text.dart';
import 'package:com.example.moex/generated/i18n.dart';

extension ExceptionExtension on dynamic {
  ResourceText getMessage() {
    if (this is IOException) {
      return (context) => S.of(context).no_connection;
    }
    return (context) => S.of(context).error_receiving_data;
  }
}
