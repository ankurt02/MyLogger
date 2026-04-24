### To use, add this in pubspec.yaml file under dependencies
```
my_logger: 
    git:
      url: https://github.com/ankurt02/MyLogger.git
      ref: v1.2.0
```


### How to use

#### Logger Instance Management

Ensure that only a single instance of the logger is created for the entire application.

Repeated instantiation is discouraged as it can result in:
- Duplicate log entries
- Increased memory usage
- Loss of centralized logging control

For best practices, initialize the logger once (e.g., at app startup) and reuse it across all modules.
Eg. create file `my.logger.dart` in `lib/core` and use the below code insde `my.logger.dart`

```
import 'package:my_logger/my_logger.dart';

final logger = Logger(
  enableColors: true,
  enableVerbose: true,
);
```

## Logging Levels & Usage

The `Logger` provides multiple logging levels to categorize and control log output effectively. Each level represents a different severity or purpose and should be used accordingly.

### Available Log Levels

| Level    | Method | Description |
|----------|--------|------------|
| DEBUG    | `d()`  | Used for development-time debugging information. Helpful for tracing application flow and internal state. |
| INFO     | `i()`  | General informational messages that highlight the normal operation of the application. |
| WARNING  | `w()`  | Indicates potential issues or situations that may require attention but are not critical. |
| ERROR    | `e()`  | Used for logging errors and exceptions. Supports additional error details and stack traces. |
| VERBOSE  | `v()`  | Detailed logs intended for deep debugging. Can be enabled or disabled via configuration. |

---

### Basic Usage

```dart
final logger = Logger();
```

```dart
logger.d("Debug message");
logger.i("App started successfully");
logger.w("Low memory warning");
logger.e("Something went wrong", error: e, stackTrace: stackTrace);
logger.v("Detailed execution trace");
```

---

### Tagged Logging

Tags can be used to identify logs from specific modules or components:

```dart
logger.i("User logged in", tag: "AUTH");
logger.w("API response delayed", tag: "NETWORK");
```

---

### Error Logging

The `error` level supports additional context such as exception details and stack traces:

```dart
try {
  // try block
} catch (e, stackTrace) {
    // catch statement
    logger.e("Exception occurred",error: e,stackTrace: stackTrace,);
}
```

---

### Notes

- Logging is only active in debug mode (`kDebugMode`)
- Verbose logs can be toggled using the `enableVerbose` flag
- Colorized output can be enabled or disabled using the `enableColors` flag

