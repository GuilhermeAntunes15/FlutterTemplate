import 'package:flutter/material.dart';
import 'item_model.dart';

class CrudEditPage extends StatefulWidget {
  final Item item;

  const CrudEditPage({super.key, required this.item});

  @override
  State<CrudEditPage> createState() => _CrudEditPageState();
}

class _CrudEditPageState extends State<CrudEditPage> {
  late TextEditingController _nomeController;
  late TextEditingController _descController;

  @override
  void initState() {
    super.initState();
    _nomeController = TextEditingController(text: widget.item.nome);
    _descController = TextEditingController(text: widget.item.descricao);
  }

  void _salvar() {
    widget.item.nome = _nomeController.text;
    widget.item.descricao = _descController.text;
    Navigator.pop(context, widget.item);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar Item'),
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
