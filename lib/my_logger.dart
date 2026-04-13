library my_logger;

import 'package:flutter/foundation.dart';

enum LogLevel {
  debug,
  info,
  warning,
  error,
  verbose,
}

class Logger {
  final bool enableColors;
  final bool enableVerbose;

  Logger({
    this.enableColors = true,
    this.enableVerbose = true,
  });

  String _getColor(LogLevel level) {
    if (!enableColors) return '';

    switch (level) {
      case LogLevel.debug:
        return '\x1B[34m'; // Blue
      case LogLevel.info:
        return '\x1B[32m'; // Green
      case LogLevel.warning:
        return '\x1B[33m'; // Yellow
      case LogLevel.error:
        return '\x1B[31m'; // Red
      case LogLevel.verbose:
        return '\x1B[38;5;211m'; // Pink-ish
    }
  }

  String _levelToString(LogLevel level) {
    return level.name.toUpperCase();
  }

  void _log(
    LogLevel level,
    String message, {
    String? tag,
    dynamic error,
    StackTrace? stackTrace,
  }) {
    if (!kDebugMode) return;

    if (level == LogLevel.verbose && !enableVerbose) return;

    final time = DateTime.now();
    final color = _getColor(level);
    const reset = '\x1B[0m';

    final tagPart = tag != null ? "[$tag] " : "";

    final logText =
        "[$time] $tagPart[${_levelToString(level)}] $message";

    if (enableColors) {
      print("$color$logText$reset");
    } else {
      print(logText);
    }

    if (error != null) {
      print("Error: $error");
    }

    if (stackTrace != null) {
      print("StackTrace: $stackTrace");
    }
  }


  void d(String message, {String? tag}) =>
      _log(LogLevel.debug, message, tag: tag);

  void i(String message, {String? tag}) =>
      _log(LogLevel.info, message, tag: tag);

  void w(String message, {String? tag}) =>
      _log(LogLevel.warning, message, tag: tag);

  void e(String message,
      {String? tag, dynamic error, StackTrace? stackTrace}) {
    _log(
      LogLevel.error,
      message,
      tag: tag,
      error: error,
      stackTrace: stackTrace,
    );
  }

  void v(String message, {String? tag}) =>
      _log(LogLevel.verbose, message, tag: tag);
}