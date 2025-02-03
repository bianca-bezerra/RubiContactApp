T coalesce<T>(T? value, T? fallback) {
  if (value == null) {
    return fallback!;
  } else if (value is String && value.isEmpty) {
    return fallback!;
  }
  return value;
}
