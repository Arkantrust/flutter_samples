import 'package:fast_contacts/fast_contacts.dart' as fast;

class Contact {
  final String id;
  final String name;
  final String phone;
  final String email;
  final String photo;

  static const String randomPhotoUrl = 'https://picsum.photos/200';

  const Contact({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    this.photo = randomPhotoUrl,
  });

  Contact.fromFast({required fast.Contact contact})
      : this(
          id: contact.id,
          name: contact.displayName,
          phone:contact.phones.isEmpty ? '' : contact.phones.first.number,
          email: contact.emails.isEmpty ? '' : contact.emails.first.address,
        );
}
