import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // No projeto real, esses dados viriam de algum provider/serviço persistido
    String nome = 'Admin';
    String email = 'admin@empresa.com';

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircleAvatar(
            radius: 50,
            child: Icon(Icons.person, size: 50),
          ),
          const SizedBox(height: 16),
          Text(
            nome,
            style: const TextStyle(fontSize: 24),
          ),
          const SizedBox(height: 8),
          Text(email),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, '/profileEdit');
            },
            child: const Text('Editar Perfil'),
          ),
        ],
      ),
    );
  }
}
