import 'package:flutter_pos/screens/view_export.dart';

class ProfileCard extends StatelessWidget {
  final String name, email, imageSrc;
  final bool isShowHi, isShowArrow;
  final VoidCallback? press;

  const ProfileCard({
    super.key,
    required this.name,
    required this.email,
    required this.imageSrc,
    this.press,
    this.isShowHi = true,
    this.isShowArrow = true,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      leading: CircleAvatar(
        radius: 28,
        child: NetworkImageWithLoader(
          imageSrc,
          radius: 100,
        ),
      ),
      title: Row(
        children: [
          Text(
            isShowHi ? "Hi, $name" : name,
            style: const TextStyle(fontWeight: FontWeight.w500),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
      subtitle: Text(email),
      trailing: isShowArrow
          ? SvgPicture.asset(
              "assets/icons/miniRight.svg",
            )
          : null,
    );
  }
}
