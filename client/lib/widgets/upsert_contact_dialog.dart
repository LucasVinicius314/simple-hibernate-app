import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:simple_hibernate_app/models/contact.dart';

class UpsertContactDialog extends StatefulWidget {
  const UpsertContactDialog({
    super.key,
    required this.contact,
  });

  final Contact? contact;

  @override
  State<UpsertContactDialog> createState() => _UpsertContactDialogState();
}

class _UpsertContactDialogState extends State<UpsertContactDialog> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();

  final _addressController = TextEditingController();

  final _phoneNumberController = TextEditingController();

  var _phoneNumberFormatter = MaskTextInputFormatter(
    mask: '(##) #####-####',
    filter: {'#': RegExp(r'[0-9]')},
  );

  Future<void> _onPressed(BuildContext context) async {
    if (_formKey.currentState?.validate() != true) {
      return;
    }

    await Navigator.of(context).maybePop(
      Contact(
        id: widget.contact?.id ?? '',
        name: _nameController.text.trim(),
        address: _addressController.text.trim(),
        phoneNumber: _phoneNumberController.text.trim(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    final contact = widget.contact;

    var phoneNumber = '';

    if (contact != null) {
      phoneNumber = contact.phoneNumber ?? '';

      _addressController.text = contact.address ?? '';
      _nameController.text = contact.name ?? '';
      _phoneNumberController.text = contact.phoneNumber ?? '';
    }

    _phoneNumberFormatter = MaskTextInputFormatter(
      mask: '(##) #####-####',
      initialText: phoneNumber,
      filter: {'#': RegExp(r'[0-9]')},
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.contact == null ? 'Novo contato' : 'Editar contato'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Nome'),
              validator: (value) {
                value ??= '';

                if (value.length < 3) {
                  return 'Nome muito curto.';
                }

                return null;
              },
            ),
            TextFormField(
              controller: _addressController,
              decoration: const InputDecoration(labelText: 'Endereço'),
              validator: (value) {
                value ??= '';

                if (value.length < 3) {
                  return 'Endereço muito curto.';
                }

                return null;
              },
            ),
            TextFormField(
              controller: _phoneNumberController,
              decoration: const InputDecoration(labelText: 'Telefone'),
              inputFormatters: [
                _phoneNumberFormatter,
              ],
              validator: (value) {
                value ??= '';

                if (value.length < 15) {
                  return 'Telefone muito curto.';
                }

                return null;
              },
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          child: Text(widget.contact == null ? 'CRIAR' : 'SALVAR'),
          onPressed: () async {
            await _onPressed(context);
          },
        ),
        TextButton(
          style: TextButton.styleFrom(foregroundColor: Colors.grey),
          child: const Text('CANCELAR'),
          onPressed: () async {
            await Navigator.of(context).maybePop();
          },
        ),
      ],
    );
  }
}
