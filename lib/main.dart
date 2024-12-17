import 'package:flutter/material.dart';
import 'login_page.dart';
import 'home_page.dart';
import 'profile_edit_page.dart';
import 'crud_list_page.dart';
import 'crud_create_page.dart';
import 'crud_edit_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Meu App Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/home': (context) => const HomePage(),

        // NOVAS ROTAS
        '/profileEdit': (context) => const ProfileEditPage(),
        '/crudList': (context) => const CrudListPage(),
        '/crudCreate': (context) => const CrudCreatePage(),
        // Para edição, iremos passar parâmetros, então veremos nos arquivos específicos
      },
    );
  }
}
