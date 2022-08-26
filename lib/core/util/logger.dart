import 'package:logger/logger.dart' as logger_lib;

abstract class Logger {
  void logInfo(Object message);
  void logError(Object message);
  void logWarning(Object message);
}

class LoggerImpl implements Logger {
  final logger = logger_lib.Logger(
    filter: null, //will log only in debug
    output: null, //will output to console
    level: logger_lib.Level.warning,
    printer: logger_lib.PrettyPrinter(
      methodCount: 1,
      errorMethodCount: 2,
      lineLength: 120,
      printEmojis: false,
      printTime: false,
    ),
  );

  @override
  logError(Object message) {
    logger.e(message.toString());
  }

  @override
  logInfo(Object message) {
    logger.i(message.toString());
  }

  @override
  logWarning(Object message) {
    logger.w(message.toString());
  }
}
