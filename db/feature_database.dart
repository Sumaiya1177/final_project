import 'package:supabase_flutter/supabase_flutter.dart';

class FirstAidDatabase {
  final table = Supabase.instance.client.from('Snap to diagnose');

  Future<void> createGuide(String title, String description) async {
    await table.insert({
      'title': title,
      'description': description,
    });
  }


  Future<void> updateGuide(int id, String newTitle, String newDescription) async {
    await table.update({
      'title': newTitle,
      'description': newDescription,
    }).eq('id', id);
  }


  Future<void> deleteGuide(int id) async {
    await table.delete().eq('id', id);
  }

  Future<List<Map<String, dynamic>>> fetchGuides() async {
    final response = await table.select();
    return List<Map<String, dynamic>>.from(response);
  }
}
