// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';

abstract class Failure {
  final String errorMessage;
  Failure({
    this.errorMessage = '',
    StackTrace? stackTrace,
    String? label,
  }) {
    if (stackTrace != null) {
      debugPrintStack(stackTrace: stackTrace, label: label);
    }
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Failure && other.errorMessage == errorMessage;
  }

  @override
  int get hashCode => errorMessage.hashCode;
}
