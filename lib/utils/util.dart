String formatCardNumber(String number) {
  // Remove spaces just in case
  number = number.replaceAll(' ', '');

  // Insert space every 4 digits
  final buffer = StringBuffer();
  for (int i = 0; i < number.length; i++) {
    buffer.write(number[i]);
    if ((i + 1) % 4 == 0 && i != number.length - 1) {
      buffer.write(' ');
    }
  }
  return buffer.toString();
}

String maskCardNumber(String number) {
  // Remove spaces if any
  number = number.replaceAll(' ', '');

  if (number.length <= 4) return number; // if too short, just return

  // Mask all but last 4 digits
  String masked =
      "*" * (number.length - 4) + number.substring(number.length - 4);

  // Format with spaces every 4 digits
  final buffer = StringBuffer();
  for (int i = 0; i < masked.length; i++) {
    buffer.write(masked[i]);
    if ((i + 1) % 4 == 0 && i != masked.length - 1) {
      buffer.write(' ');
    }
  }
  return buffer.toString();
}
