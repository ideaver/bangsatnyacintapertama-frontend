import 'package:flutter/material.dart';
import 'package:super_tooltip/super_tooltip.dart';

class AppTooltip extends StatefulWidget {
  final Widget child;
  final Widget content;
  final double? arrowLength;
  final double? left;
  final double? right;

  const AppTooltip({
    super.key,
    required this.child,
    required this.content,
    this.arrowLength,
    this.left,
    this.right,
  });

  @override
  State<AppTooltip> createState() => _AppTooltipState();
}

class _AppTooltipState extends State<AppTooltip> {
  final controller = SuperTooltipController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await controller.showTooltip();
      },
      child: SuperTooltip(
        barrierColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        borderColor: Colors.transparent,
        elevation: 0,
        arrowLength: widget.arrowLength ?? 20,
        right: widget.left,
        left: widget.right,
        hasShadow: false,
        controller: controller,
        content: widget.content,
        child: widget.child,
      ),
    );
  }
}
