import 'package:google_maps/models/contact_entity.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

const DATABASE_NAME = "AGENDA_RUBI";
const TABLE_NAME = "CONTATOS";
const CREATE_CONTACTS_TABLE_SCRIPT =
    "CREATE TABLE contacts(id INTEGER PRIMARY KEY, name TEXT, email TEXT, phone TEXT, image TEXT, latLng TEXT)";

class ContactRepository {
  Future create(ContactEntity model) async {
    try {
      final Database db = await _getDatabase();

      await db.insert(
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
      final List<Map<String, dynamic>> maps = await db.query(TABLE_NAME);

      return List.generate(
        maps.length,
        (i) {
          return ContactEntity.fromMap(maps[i]);
        },
      );
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

  Future<List<ContactEntity>> getMockContactList() async {
    // Simula um atraso de 2 segundos
    await Future.delayed(const Duration(seconds: 2));
    return [
      ContactEntity(
        id: 1,
        name: 'John Doe',
        phoneNumber: '+1 (555) 123-4567',
        email: 'johndoe@example.com',
        image: 'https://randomuser.me/api/portraits/men/1.jpg',
        address: Coordinates(
            latitude: 37.7749, longitude: -122.4194), // São Francisco
      ),
      ContactEntity(
        id: 2,
        name: 'Jane Smith',
        phoneNumber: '+1 (555) 987-6543',
        email: 'janesmith@example.com',
        image: 'https://randomuser.me/api/portraits/women/1.jpg',
        address:
            Coordinates(latitude: 34.0522, longitude: -118.2437), // Los Angeles
      ),
      ContactEntity(
        id: 3,
        name: 'Michael Johnson',
        phoneNumber: '+1 (555) 555-5555',
        email: 'michael.johnson@example.com',
        image: 'https://randomuser.me/api/portraits/men/2.jpg',
        address:
            Coordinates(latitude: 40.7128, longitude: -74.0060), // Nova York
      ),
      ContactEntity(
        id: 4,
        name: 'Emily Davis',
        phoneNumber: '+1 (555) 333-4444',
        email: 'emily.davis@example.com',
        image: 'https://randomuser.me/api/portraits/women/2.jpg',
        address: Coordinates(latitude: 51.5074, longitude: -0.1278), // Londres
      ),
      ContactEntity(
        id: 5,
        name: 'Chris Brown',
        phoneNumber: '+1 (555) 222-3333',
        email: 'chris.brown@example.com',
        image: 'https://randomuser.me/api/portraits/men/3.jpg',
        address: Coordinates(latitude: 48.8566, longitude: 2.3522), // Paris
      ),
    ];
  }
}
