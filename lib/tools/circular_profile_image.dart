import 'package:ceo_transport/utilities/custom_images.dart';
import 'package:flutter/material.dart';

class CircularProfileImage extends StatelessWidget {
  const CircularProfileImage({
    required this.imageURL,
    this.radious = 50,
    Key? key,
  }) : super(key: key);
  final String imageURL;
  final double radious;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radious,
      backgroundColor: Theme.of(context).primaryColor,
      child: CircleAvatar(
        radius: radious - 2,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        child: CircleAvatar(
          radius: radious - 6,
          backgroundColor: Theme.of(context).primaryColor,
          backgroundImage: (imageURL.isEmpty)
              ? AssetImage(CustomImages.icon)
              : NetworkImage(imageURL) as ImageProvider,
        ),
      ),
    );
  }
}
