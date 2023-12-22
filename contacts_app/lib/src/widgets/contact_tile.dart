import 'package:flutter/material.dart';

import 'contact_image.dart';
import '../views/contact_view.dart';
import '../model/contact.dart';
import '../app.dart';

class ContactTile extends StatelessWidget {
  final Contact contact;

  const ContactTile(this.contact, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => ContactView(contact.id),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: palette.secondary),
            borderRadius: BorderRadius.circular(50),
            color: palette.surface,
            boxShadow: List.generate(
              5,
              (index) => BoxShadow(
                color: palette.surface.withOpacity((index + 1) * 0.1),
                blurStyle: BlurStyle.outer,
              ),
            ).reversed.toList(),
          ),
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              ContactImage(contact.photo, 30),
              SizedBox(width: MediaQuery.of(context).size.width * 0.05),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    contact.name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(contact.phone, style: const TextStyle(fontSize: 12)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
