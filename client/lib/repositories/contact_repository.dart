import 'package:simple_hibernate_app/models/contact.dart';
import 'package:simple_hibernate_app/utils/api.dart';

class ContactRepository {
  Future<void> create() async {
    // TODO: fix
    await Api.post(path: 'contact', queryParameters: {}, body: {});
  }

  Future<List<Contact>> list() async {
    final res =
        await Api.get(path: 'contact', queryParameters: {}) as List<dynamic>;

    return res.map((e) => Contact.fromJson(e)).toList();
  }

  Future<void> update() async {
    // TODO: fix
    await Api.patch(path: 'contact', queryParameters: {}, body: {});
  }

  Future<void> delete({required String id}) async {
    await Api.delete(path: 'contact/$id', queryParameters: {}, body: {});
  }
}
