import 'package:sqflite/sqflite.dart' as sq;
import 'package:path/path.dart';
class Note {
  String id;
  String title;
  String description;

  Note({
    required this.id,
    required this.title,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
    };
  }

  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      title: map['title'],
      description: map['description'],
    );
  }
}
Future<sq.Database> openDatabase() async {
  String databasePath = await sq.getDatabasesPath();
  String path = join(databasePath, 'my_database.db');
  return await sq.openDatabase(path);
}
Future<void> createNote(Note note) async {
  sq.Database database = await openDatabase();
  await database.execute('''
    CREATE TABLE IF NOT EXISTS notes (
      id TEXT PRIMARY KEY,
      title TEXT,
      description TEXT
    )
  ''');
  await database.insert('notes', note.toMap());
}
Future<void> deleteNoteById(String id) async {
  sq.Database database = await openDatabase();
  await database.delete('notes', where: 'id = ?', whereArgs: [id]);
}
Future<List<Map<String,dynamic>>> loadList() async {
  sq.Database database = await openDatabase();
  return await database.query('notes');
}
Future<void> updateNote(Note note) async {
  sq.Database database = await openDatabase();
  await database.update(
    'notes',
    note.toMap(),
    where: 'id = ?',
    whereArgs: [note.id],
  );
}
void closeDatabase(sq.Database database) {
  database.close();
}