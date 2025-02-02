import 'package:google_maps/models/contact_entity.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

const DATABASE_NAME = "AGENDA_RUBI";
const TABLE_NAME = "CONTATOS";
const CREATE_CONTACTS_TABLE_SCRIPT =
    "CREATE TABLE contatos(id INTEGER PRIMARY KEY, name TEXT, email TEXT, phone TEXT, image TEXT, latLng TEXT)";

class ContactRepository {
  Future create(ContactEntity model) async {
    try {
      final Database db = await _getDatabase();

      final index = await db.insert(
        TABLE_NAME,
        model.toMap(),
      );
    } catch (ex) {
      print(ex);
      return;
    }
  }

  Future<Database> _getDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), DATABASE_NAME),
      onCreate: (db, version) {
        return db.execute(CREATE_CONTACTS_TABLE_SCRIPT);
      },
      version: 1,
    );
  }

  Future<List<ContactEntity>> getContacts() async {
    try {
      final Database db = await _getDatabase();
      final List<Map<String, dynamic>> contacts = await db.query(TABLE_NAME);

      final list = List.generate(
        contacts.length,
        (i) {
          return ContactEntity.fromMap(contacts[i]);
        },
      );

      return list;
    } catch (ex) {
      print(ex);
      return [];
    }
  }

  Future<void> updateContact(ContactEntity contact) async {
    try {
      final Database db = await _getDatabase();

      await db.update(
        TABLE_NAME,
        contact.toMap(),
        where: "id = ?",
        whereArgs: [contact.id],
      );
    } catch (ex) {
      print(ex);
    }
  }

  Future<void> deleteContact(int id) async {
    try {
      final Database db = await _getDatabase();

      await db.delete(
        TABLE_NAME,
        where: "id = ?",
        whereArgs: [id],
      );
    } catch (ex) {
      print(ex);
    }
  }
}
