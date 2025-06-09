import 'package:flutter/material.dart';
import '../data/saved_phrases_manager.dart';
// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_element
// ignore_for_file: sort_child_properties_last

class MyDrawer extends StatelessWidget {
  final SavedPhrasesManager phrasesManager;

  const MyDrawer({super.key, required this.phrasesManager});

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();

    return Drawer(
      child: AnimatedBuilder(
        animation: phrasesManager,
        builder: (context, _) {
          return ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(color: Colors.yellow),
                child: Icon(Icons.favorite, size: 48),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text('H O M E'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/homepage');
                },
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('SITTING'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/sittingpage');
                },
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text("العبارات المحفوظة",
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              ...phrasesManager.phrases.map((phrase) => ListTile(
                    title: Text(phrase),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => phrasesManager.removePhrase(phrase),
                    ),
                  )),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: controller,
                        decoration: InputDecoration(
                          hintText: 'أضف عبارة جديدة',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.add, color: Colors.green),
                      onPressed: () {
                        phrasesManager.addPhrase(controller.text.trim());
                        controller.clear();
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
