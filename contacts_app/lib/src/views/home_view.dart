import 'package:contacts_app/src/cubit/contacts_cubit.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../model/contact.dart';
import '../widgets/contact_tile.dart';
import '../app.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Future<void> loadContacts() async {
    await context.read<ContactsCubit>().fetchContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts App'),
        actions: [
          IconButton(
            onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  'Contacts: ${context.read<ContactsCubit>().state.contacts.length}',
                ),
                dismissDirection: DismissDirection.horizontal,
                duration: const Duration(seconds: 1),
                animation: CurvedAnimation(
                  parent: const AlwaysStoppedAnimation(5),
                  curve: Curves.easeInOut,
                ),
              ),
            ),
            icon: const Icon(Icons.numbers),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<ContactsCubit, ContactsState>(
          builder: (context, state) {
            if (state.isFetching) {
              return LinearProgressIndicator(color: palette.secondary);
            } else if (state.hasPermission == Future.value(false)) {
              return Center(
                child: TextButton(
                  onPressed: () async => await loadContacts(),
                  child: Text(
                    'Grant permission to access contacts',
                    style: TextStyle(color: palette.primary, fontSize: 18),
                  ),
                ),
              );
            } else if (state.contacts.isEmpty) {
              loadContacts();
            }
            return ContactsList(contacts: state.contacts);
          },
        ),
      ),
    );
  }
}

class ContactsList extends StatelessWidget {
  const ContactsList({super.key, required this.contacts});

  final List<Contact> contacts;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: RefreshIndicator(
        onRefresh: () => context.read<ContactsCubit>().fetchContacts(),
        child: ListView.builder(
          physics: const AlwaysScrollableScrollPhysics(),
          itemCount: contacts.length,
          itemBuilder: (context, index) => ContactTile(contacts[index]),
        ),
      ),
    );
  }
}
