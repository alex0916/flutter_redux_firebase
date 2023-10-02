import 'package:flutter/material.dart';

enum Severity { success, error, warning, info }

class Alert extends StatelessWidget {
  final Severity? severity;
  final String message;
  final bool isVisible;

  const Alert({
    super.key,
    required this.message,
    required this.isVisible,
    this.severity = Severity.success,
  });

  Color getSeverityColor() {
    if (severity == Severity.success) {
      return Colors.green;
    }
    if (severity == Severity.error) {
      return Colors.redAccent;
    }
    if (severity == Severity.info) {
      return Colors.blueAccent;
    }
    return const Color.fromARGB(255, 224, 168, 0);
  }

  IconData getSeverityIcon() {
    if (severity == Severity.success) {
      return Icons.check;
    }
    if (severity == Severity.error) {
      return Icons.error;
    }
    if (severity == Severity.info) {
      return Icons.info;
    }
    return Icons.warning;
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isVisible,
      child: Container(
          margin: const EdgeInsets.only(bottom: 15),
          padding: const EdgeInsets.all(10.0),
          width: double.infinity,
          decoration: BoxDecoration(
              border: Border.all(color: getSeverityColor()),
              color: getSeverityColor()),
          child: Row(
            children: [
              Icon(
                getSeverityIcon(),
                color: Colors.white,
              ),
              const SizedBox(width: 5),
              Flexible(
                child: Text(
                  message,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          )),
    );
  }
}
