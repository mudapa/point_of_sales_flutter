class Onboard {
  final String image, title, description;
  final String? imageDarkTheme;

  Onboard({
    required this.image,
    required this.title,
    this.description = "",
    this.imageDarkTheme,
  });
}
