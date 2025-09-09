library custom_dialog;

import 'package:flutter/material.dart';

enum CustomDialogType { success, error, warning }

class CustomDialog extends StatefulWidget {
  final CustomDialogType dialogType;
  final String title;
  final String description;
  final VoidCallback onConfirm;
  final VoidCallback? onCancel;
  final String confirmButtonText;
  final String cancelButtonText;
  final bool rounded;
  final Color? iconColor;
  final Color? confirmButtonColor;
  final Color? cancelButtonColor;

  const CustomDialog({
    super.key,
    required this.dialogType,
    required this.title,
    required this.description,
    required this.onConfirm,
    this.onCancel,
    this.confirmButtonText = 'Confirm',
    this.cancelButtonText = 'Cancel',
    this.rounded = true,
    this.iconColor,
    this.confirmButtonColor,
    this.cancelButtonColor,
  });

  static Future<void> showCustomDialog({
    required BuildContext context,
    required CustomDialogType dialogType,
    required String title,
    required String description,
    required VoidCallback onConfirm,
    VoidCallback? onCancel,
    String confirmButtonText = 'Confirm',
    String cancelButtonText = 'Cancel',
    bool rounded = true,
    Color? iconColor,
    Color? confirmButtonColor,
    Color? cancelButtonColor,
  }) {
    return showDialog(
      context: context,
      builder: (context) => CustomDialog(
        dialogType: dialogType,
        title: title,
        description: description,
        onConfirm: onConfirm,
        onCancel: onCancel,
        confirmButtonText: confirmButtonText,
        cancelButtonText: cancelButtonText,
        rounded: rounded,
        iconColor: iconColor,
        confirmButtonColor: confirmButtonColor,
        cancelButtonColor: cancelButtonColor,
      ),
    );
  }

  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  Color _getPrimaryColor() {
    return widget.iconColor ?? _getDefaultColor();
  }

  Color _getDefaultColor() {
    switch (dialogType) {
      case CustomDialogType.success:
        return Colors.green;
      case CustomDialogType.error:
        return Colors.red;
      case CustomDialogType.warning:
        return Colors.amber;
    }
  }

  IconData _getIcon() {
    switch (dialogType) {
      case CustomDialogType.success:
        return Icons.check_circle_rounded;
      case CustomDialogType.error:
        return Icons.error_rounded;
      case CustomDialogType.warning:
        return Icons.warning_rounded;
    }
  }

  CustomDialogType get dialogType => widget.dialogType;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    )..forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = _getPrimaryColor();
    final icon = _getIcon();
    final borderRadius =
        widget.rounded ? BorderRadius.circular(16) : BorderRadius.zero;
    final buttonRadius =
        widget.rounded ? BorderRadius.circular(8) : BorderRadius.zero;

    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: borderRadius),
      titlePadding: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 0),
      contentPadding: const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 0),
      actionsPadding: const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 24.0),
      title: ScaleTransition(
        scale: CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: primaryColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(40),
              ),
              child: Icon(icon, size: 20, color: primaryColor),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                widget.title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade800,
                ),
              ),
            ),
          ],
        ),
      ),
      content: FadeTransition(
        opacity: _controller,
        child: Text(
          widget.description,
          style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            widget.onCancel?.call();
          },
          style: TextButton.styleFrom(
            foregroundColor: widget.cancelButtonColor ?? Colors.grey.shade700,
            shape: RoundedRectangleBorder(borderRadius: buttonRadius),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          ),
          child: Text(widget.cancelButtonText),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
            widget.onConfirm();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: widget.confirmButtonColor ?? primaryColor,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: buttonRadius),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            elevation: 2,
            shadowColor: (widget.confirmButtonColor ?? primaryColor).withOpacity(0.4),
          ),
          child: Text(widget.confirmButtonText),
        ),
      ],
    );
  }
}
