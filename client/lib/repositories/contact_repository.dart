import 'package:simple_hibernate_app/models/contact.dart';
import 'package:simple_hibernate_app/utils/api.dart';

class ContactRepository {
  Future<List<Contact>> list() async {
    final res =
        await Api.get(path: 'contact', queryParameters: {}) as List<dynamic>;

    return res.map((e) => Contact.fromJson(e)).toList();
  }
}
