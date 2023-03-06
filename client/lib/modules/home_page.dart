import 'package:flutter/material.dart';
import 'package:simple_hibernate_app/models/contact.dart';
import 'package:simple_hibernate_app/repositories/contact_repository.dart';
import 'package:simple_hibernate_app/widgets/base_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  static const route = '/';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<Contact>>? _future;

  final _repository = ContactRepository();

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'Contatos',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                FutureBuilder(
                  future: _future,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Text('Algo deu errado.');
                    }

                    if (snapshot.connectionState == ConnectionState.done) {
                      final contacts = snapshot.data ?? [];

                      return Column(
                        children: contacts.map((e) {
                          return ListTile(
                            title: Text(e.name ?? ''),
                            subtitle: Text(e.address ?? ''),
                          );
                        }).toList(),
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
