import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/contacts_cubit.dart';
import 'views/home_view.dart';

class ContactsApp extends StatelessWidget {
  const ContactsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ContactsCubit(),
      child: MaterialApp(
        title: 'Contacts App',
        restorationScopeId: 'contacts_app',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: AppBarTheme(
              centerTitle: true,
              color: palette.background,
              foregroundColor: palette.primary,
              toolbarHeight: MediaQuery.of(context).size.height * 0.05,
              elevation: 0,
              scrolledUnderElevation: 0,
              systemOverlayStyle: SystemUiOverlayStyle.dark),
          snackBarTheme: SnackBarThemeData(
            backgroundColor: palette.surface,
            behavior: SnackBarBehavior.floating,
            contentTextStyle: TextStyle(color: palette.primary, fontSize: 18),
          ),
          brightness: Brightness.dark,
          colorScheme: palette,
        ),
        home: const HomeView(),
      ),
    );
  }
}

const palette = ColorScheme.dark(
  primary: Colors.cyan,
  secondary: Colors.pinkAccent,
  surface: Color.fromRGBO(30, 30, 30, 1),
);
