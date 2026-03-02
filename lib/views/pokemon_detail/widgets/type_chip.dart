part of '../pokemon_detail_page.dart';

class TypeChip extends StatelessWidget {
  final String label;
  final Color? color;
  final double? fontSize;

  const TypeChip({super.key, required this.label, this.color, this.fontSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color ?? Colors.white.withValues(alpha: 0.25),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        label.toUpperCase(),
        style: TextStyle(
          fontSize: fontSize,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
