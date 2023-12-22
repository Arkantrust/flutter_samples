import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:permission_handler/permission_handler.dart';
import 'package:fast_contacts/fast_contacts.dart' show FastContacts;

import '../model/contact.dart';

part 'contacts_state.dart';

class ContactsCubit extends Cubit<ContactsState> {
  ContactsCubit() : super(const ContactsState());

  Future<void> fetchContacts() async {
    if (! await state.hasPermission) {
      await _requestPermission();
    } else {
      await _fetchContacts();
    }
  }

  Future<void> _requestPermission() async {
    try {
      final permissionStatus = await Permission.contacts.request();
      final hasPermission = permissionStatus == PermissionStatus.granted;
      emit(state.copyWith(hasPermission: hasPermission));
    } catch (e) {
      log('Permission to access contacts not granted.\nCaught error: $e');
    }
  }

  Future<void> _fetchContacts() async {
    emit(state.copyWith(isFetching: true));
    final List<Contact> contacts = await FastContacts.getAllContacts().then(
      (value) => value.map((e) => Contact.fromFast(contact: e)).toList(),
    );
    emit(state.copyWith(contacts: contacts, isFetching: false));
  }

  Future<Contact> fetchContact(String id) async {
    emit(state.copyWith(isFetching: true));

    final contactFromPhone = await FastContacts.getContact(id);

    emit(state.copyWith(isFetching: false));

    return Future.value(Contact.fromFast(contact: contactFromPhone!));
  }
}
