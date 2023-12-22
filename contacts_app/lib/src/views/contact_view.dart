import 'package:contacts_app/src/app.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/contacts_cubit.dart';
import '../widgets/contact_image.dart';
import '../model/contact.dart';

class ContactView extends StatefulWidget {
  const ContactView(
    this.contactId, {
    super.key,
  });

  final String contactId;

  @override
  State<ContactView> createState() => _ContactViewState();
}

class _ContactViewState extends State<ContactView> {
  late Contact contact;

  late Duration timeTaken;

  Future<void> loadContact() async {
    if (!context.read<ContactsCubit>().state.isFetching) {
      final sw = Stopwatch()..start();
      contact = await context
          .read<ContactsCubit>()
          .fetchContact(widget.contactId)
          .then((value) {
        timeTaken = (sw..stop()).elapsed;
        return value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadContact(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              'Error: ${snapshot.error}',
              style: const TextStyle(color: Colors.red),
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              title: Text(contact.name),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ContactImage(contact.photo, 100),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: palette.surface,
                        borderRadius: BorderRadius.circular(8),
                        
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('Took: ${timeTaken.inMilliseconds}ms'),
                          const SizedBox(height: 25),
                          ContactField(label: 'ID', value: contact.id),
                          const SizedBox(height: 14),
                          ContactField(label: 'Phone', value: contact.phone),
                          const SizedBox(height: 14),
                          ContactField(label: 'Email', value: contact.email),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}

class ContactField extends StatelessWidget {
  final String label;
  final dynamic value;

  const ContactField({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {

    const double textSize = 18; // TODO: Make responsive

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(
            '$label: ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: palette.secondary,
              fontSize: textSize,
            ),
          ),
          Flexible(
            fit: FlexFit.loose,
            child: Text(
              value,
              style: const TextStyle(
                fontSize: textSize,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
