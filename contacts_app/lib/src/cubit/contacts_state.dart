part of 'contacts_cubit.dart';

final class ContactsState extends Equatable {
  final List<Contact> contacts;
  final bool isFetching;

  Future<bool> get hasPermission async => await Permission.contacts.isGranted;

  const ContactsState({
    this.contacts = const [],
    this.isFetching = false,
  });

  @override
  List get props => [contacts, isFetching, hasPermission];

  ContactsState copyWith({
    List<Contact>? contacts,
    bool? isFetching,
    bool? hasPermission,
  }) {
    return ContactsState(
      contacts: contacts ?? this.contacts,
      isFetching: isFetching ?? this.isFetching,
    );
  }
}
