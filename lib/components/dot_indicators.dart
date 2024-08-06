import 'component_export.dart';

class DotIndicator extends StatelessWidget {
  final bool isActive;
  final Color? inActiveColor, activeColor;

  const DotIndicator({
    super.key,
    this.isActive = false,
    this.inActiveColor,
    this.activeColor = primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: defaultDuration,
      height: isActive ? 12 : 4,
      width: 4,
      decoration: BoxDecoration(
        color: isActive
            ? activeColor
            : inActiveColor ?? primaryMaterialColor.shade100,
        borderRadius: const BorderRadius.all(
          Radius.circular(
            defaultBorderRadious,
          ),
        ),
      ),
    );
  }
}
