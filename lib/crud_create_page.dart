import 'package:flutter/material.dart';
import 'item_model.dart';

class CrudCreatePage extends StatefulWidget {
  const CrudCreatePage({super.key});

  @override
  State<CrudCreatePage> createState() => _CrudCreatePageState();
}

class _CrudCreatePageState extends State<CrudCreatePage> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  int _nextId() {
    // Calcula ID automaticamente
    // Pega o maior ID da lista ou retorna 1
    // (Se estivesse numa API real, esse ID normalmente viria do banco ou do back-end)
    // Mas vamos simular:
    // Importante: essa lógica pode ser melhorada em um app real
    return DateTime.now().millisecondsSinceEpoch;
  }

  void _salvar() {
    if (_nomeController.text.isNotEmpty && _descController.text.isNotEmpty) {
      final novoItem = Item(
        id: _nextId(),
        nome: _nomeController.text,
        descricao: _descController.text,
      );
      Navigator.pop(context, novoItem);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastrar Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nomeController,
              decoration: const InputDecoration(labelText: 'Nome'),
            ),
            TextField(
              controller: _descController,
              decoration: const InputDecoration(labelText: 'Descrição'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _salvar,
              child: const Text('Salvar'),
            )
          ],
        ),
      ),
    );
  }
}
