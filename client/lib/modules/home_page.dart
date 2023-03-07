import 'package:flutter/material.dart';
import 'package:simple_hibernate_app/models/contact.dart';
import 'package:simple_hibernate_app/repositories/contact_repository.dart';
import 'package:simple_hibernate_app/widgets/base_page.dart';
import 'package:simple_hibernate_app/widgets/upsert_contact_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const route = '/';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<Contact>>? _future;

  final _repository = ContactRepository();

  Future<void> _create() async {
    final messenger = ScaffoldMessenger.of(context);

    final ans = await showDialog(
      context: context,
      builder: (context) {
        return const UpsertContactDialog(contact: null);
      },
    );

    if (ans is Contact) {
      setState(() {
        _future = null;
      });

      await _repository.create(contact: ans);

      messenger.showSnackBar(
        const SnackBar(
          content: Text('Contato criado.'),
          behavior: SnackBarBehavior.floating,
        ),
      );

      setState(() {
        _future = _repository.list();
      });
    }
  }

  Future<void> _update({required Contact contact}) async {
    final messenger = ScaffoldMessenger.of(context);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      final ans = await showDialog(
        context: context,
        builder: (context) {
          return UpsertContactDialog(contact: contact);
        },
      );

      if (ans is Contact) {
        setState(() {
          _future = null;
        });

        await _repository.update(contact: ans);

        messenger.showSnackBar(
          const SnackBar(
            content: Text('Contato ataulizado.'),
            behavior: SnackBarBehavior.floating,
          ),
        );

        setState(() {
          _future = _repository.list();
        });
      }
    });
  }

  Future<void> _delete({required String id}) async {
    final messenger = ScaffoldMessenger.of(context);

    setState(() {
      _future = null;
    });

    await _repository.delete(id: id);

    messenger.showSnackBar(
      const SnackBar(
        content: Text('Contato excluído.'),
        behavior: SnackBarBehavior.floating,
      ),
    );

    setState(() {
      _future = _repository.list();
    });
  }

  @override
  void initState() {
    super.initState();

    _future = _repository.list();
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Card(
            margin: EdgeInsets.zero,
            clipBehavior: Clip.antiAlias,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          'Contatos',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      const SizedBox(width: 16),
                      TextButton.icon(
                        icon: const Icon(Icons.add),
                        label: const Text('NOVO CONTATO'),
                        onPressed: _create,
                      ),
                    ],
                  ),
                ),
                FutureBuilder(
                  future: _future,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Padding(
                        padding: EdgeInsets.only(
                          left: 16,
                          right: 16,
                          bottom: 16,
                        ),
                        child: Text('Algo deu errado.'),
                      );
                    }

                    if (snapshot.connectionState == ConnectionState.done) {
                      final contacts = snapshot.data ?? [];

                      if (contacts.isEmpty) {
                        return const Padding(
                          padding: EdgeInsets.only(
                            left: 16,
                            right: 16,
                            bottom: 16,
                          ),
                          child: Text('Nenhum contato encontrado.'),
                        );
                      }

                      return ListView.separated(
                        shrinkWrap: true,
                        padding: const EdgeInsets.only(bottom: 8),
                        itemBuilder: (context, index) {
                          final contact = contacts[index];

                          return ListTile(
                            title: Text(contact.name ?? ''),
                            subtitle: Text(contact.address ?? ''),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(contact.phoneNumber ?? ''),
                                const SizedBox(width: 16),
                                PopupMenuButton<int>(
                                  tooltip: 'Mais opções',
                                  itemBuilder: (context) {
                                    return [
                                      PopupMenuItem(
                                        child: const Text('Editar'),
                                        onTap: () async {
                                          await _update(contact: contact);
                                        },
                                      ),
                                      PopupMenuItem(
                                        child: const Text('Excluir'),
                                        onTap: () async {
                                          await _delete(id: contact.id ?? '');
                                        },
                                      ),
                                    ];
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const Divider(
                            height: 0,
                            indent: 16,
                            endIndent: 16,
                          );
                        },
                        itemCount: contacts.length,
                      );
                    }

                    return const Padding(
                      padding: EdgeInsets.all(16),
                      child: Center(
                        child: SizedBox(
                          width: 32,
                          height: 32,
                          child: CircularProgressIndicator(),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
