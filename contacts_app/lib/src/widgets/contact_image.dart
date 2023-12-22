import 'package:flutter/material.dart';

class ContactImage extends StatelessWidget {
  const ContactImage(this.photoUrl, this.radius, {super.key});

  final double radius;
  final String photoUrl;

  @override
  Widget build(BuildContext context) => CircleAvatar(
        radius: radius,
        backgroundImage: NetworkImage(photoUrl, scale: 1.0),
      );
}
