import 'package:faker/faker.dart';
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

  Future<void> createMock() async {
    var faker = Faker();
    const image =
        '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';
    final mock = ContactEntity(
        id: -1,
        name: faker.person.name(),
        phoneNumber: faker.phoneNumber.us(),
        email: faker.internet.email(),
        image: image,
        address: Coordinates(
            latitude: faker.geo.latitude(), longitude: faker.geo.longitude()));
    await create(mock);
  }
}
