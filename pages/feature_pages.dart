import 'package:flutter/material.dart';
import 'package:flutter_project1/db/feature_database.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'login_page.dart';


class FirstAidPage extends StatefulWidget {
  const FirstAidPage({super.key});

  @override
  State<FirstAidPage> createState() => _FirstAidPageState();
}

class _FirstAidPageState extends State<FirstAidPage> {
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final db = FirstAidDatabase();

  void showGuideDialog({int? id, String? currentTitle, String? currentDesc}) {
    if (currentTitle != null) {
      _titleController.text = currentTitle;
      _descController.text = currentDesc ?? '';
    } else {
      _titleController.clear();
      _descController.clear();
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(id != null ? 'Edit Guide' : 'Add Guide'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: _descController,
              decoration: InputDecoration(labelText: 'Description'),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _titleController.clear();
              _descController.clear();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              try {
                if (id != null) {
                  await db.updateGuide(id, _titleController.text, _descController.text);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Update successful")));
                } else {
                  await db.createGuide(_titleController.text, _descController.text);
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Insertion successful")));
                }
                Navigator.pop(context);
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $e")));
              }
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }

  void deleteGuide(int id) async {
    try {
      await db.deleteGuide(id);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Deletion successful")));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error: $e")));
    }
  }

  Future<void> logout() async {
    await Supabase.instance.client.auth.signOut();
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Aid Guide'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: logout,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showGuideDialog(),
        child: Icon(Icons.add),
      ),
      body: StreamBuilder(
        stream: db.table.stream(primaryKey: ['id']),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
          final guides = snapshot.data!;
          return ListView.builder(
            itemCount: guides.length,
            itemBuilder: (context, index) {
              final guide = guides[index];
              final id = guide['id'];
              final title = guide['title'];
              final desc = guide['description'];

              return Card(
                child: ListTile(
                  title: Text(title),
                  subtitle: Text(desc),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () => showGuideDialog(id: id, currentTitle: title, currentDesc: desc),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () => deleteGuide(id),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}