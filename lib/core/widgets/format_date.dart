import 'package:intl/intl.dart';

String formatDate(DateTime date) {
  final now = DateTime.now();
  final difference = now.difference(date);

  if (difference.inHours < 24 && date.day == now.day) {
    return DateFormat('HH:mm').format(date);
  } else if (difference.inDays == 1 ||
      (difference.inHours >= 24 && difference.inHours < 48)) {
    return 'Yesterday';
  } else if (difference.inDays < 7) {
    return DateFormat('EEEE').format(date);
  } else {
    return DateFormat('dd/MM/yy').format(date);
  }
}
