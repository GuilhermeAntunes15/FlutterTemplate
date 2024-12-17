import 'package:flutter/material.dart';
import 'item_model.dart';
import 'crud_create_page.dart';
import 'crud_edit_page.dart';

// Uma lista estática em memória só pra exemplo
List<Item> itens = [
  Item(id: 1, nome: 'Item 1', descricao: 'Descrição 1'),
  Item(id: 2, nome: 'Item 2', descricao: 'Descrição 2'),
  Item(id: 3, nome: 'Item 3', descricao: 'Descrição 3'),
];

class CrudListPage extends StatefulWidget {
  const CrudListPage({super.key});

  @override
  State<CrudListPage> createState() => _CrudListPageState();
}

class _CrudListPageState extends State<CrudListPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  // Confirma exclusão
  void _confirmDelete(BuildContext context, Item item) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Excluir'),
        content: Text('Deseja excluir o item "${item.nome}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                itens.removeWhere((element) => element.id == item.id);
              });
              Navigator.pop(context);
            },
            child: const Text('Confirmar'),
          ),
        ],
      ),
    );
  }

  Widget _buildTabela() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
        columns: const [
          DataColumn(label: Text('ID')),
          DataColumn(label: Text('Nome')),
          DataColumn(label: Text('Descrição')),
          DataColumn(label: Text('Ações')),
        ],
        rows: itens.map((item) {
          return DataRow(
            cells: [
              DataCell(Text(item.id.toString())),
              DataCell(Text(item.nome)),
              DataCell(Text(item.descricao)),
              DataCell(
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      onPressed: () async {
                        // Rota para edição
                        final atualizado = await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CrudEditPage(item: item),
                          ),
                        );
                        if (atualizado != null && atualizado is Item) {
                          setState(() {
                            // Atualiza a lista com os dados retornados
                            final index = itens
                                .indexWhere((el) => el.id == atualizado.id);
                            if (index != -1) {
                              itens[index] = atualizado;
                            }
                          });
                        }
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        _confirmDelete(context, item);
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildCards() {
    return ListView.builder(
      itemCount: itens.length,
      itemBuilder: (context, index) {
        final item = itens[index];
        return Card(
          child: ListTile(
            title: Text(item.nome),
            subtitle: Text(item.descricao),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.blue),
                  onPressed: () async {
                    final atualizado = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CrudEditPage(item: item),
                      ),
                    );
                    if (atualizado != null && atualizado is Item) {
                      setState(() {
                        final i =
                            itens.indexWhere((el) => el.id == atualizado.id);
                        if (i != -1) {
                          itens[i] = atualizado;
                        }
                      });
                    }
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    _confirmDelete(context, item);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CRUD Listagem'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.table_chart), text: 'Tabela'),
            Tab(icon: Icon(Icons.view_agenda), text: 'Cards'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildTabela(),
          _buildCards(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final novoItem = await Navigator.pushNamed(context, '/crudCreate');
          if (novoItem != null && novoItem is Item) {
            setState(() {
              itens.add(novoItem);
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
