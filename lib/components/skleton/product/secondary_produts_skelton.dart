import '../../component_export.dart';

class SecondaryProductsSkelton extends StatelessWidget {
  const SecondaryProductsSkelton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 114,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.only(
            left: defaultPadding,
            right: index == 3 ? defaultPadding : 0,
          ),
          child: const SeconderyProductSkelton(),
        ),
      ),
    );
  }
}
