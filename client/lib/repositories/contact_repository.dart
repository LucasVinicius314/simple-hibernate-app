import 'package:simple_hibernate_app/models/contact.dart';
import 'package:simple_hibernate_app/utils/api.dart';

class ContactRepository {
  Future<void> create({required Contact contact}) async {
    await Api.post(path: 'contact', queryParameters: {}, body: {
      'address': contact.address,
      'name': contact.name,
      'phoneNumber': contact.phoneNumber,
    });
  }

  Future<List<Contact>> list() async {
    final res =
        await Api.get(path: 'contact', queryParameters: {}) as List<dynamic>;

    return res.map((e) => Contact.fromJson(e)).toList();
  }

  Future<void> update({required Contact contact}) async {
    await Api.patch(path: 'contact/${contact.id}', queryParameters: {}, body: {
      'address': contact.address,
      'name': contact.name,
      'phoneNumber': contact.phoneNumber,
    });
  }

  Future<void> delete({required String id}) async {
    await Api.delete(path: 'contact/$id', queryParameters: {}, body: {});
  }
}
