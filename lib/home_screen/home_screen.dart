import 'package:flutter/material.dart';
import 'package:supabase_app/login_screen/login_screen.dart';

import '../main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //Sign Out User
  Future<void> signOut() async {
    await supabase.auth.signOut();
    if (!mounted) return;
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  final noteStream = supabase.from('notes').stream(primaryKey: ['id']);

  //Create Note
  Future<void> createNote(String note) async {
    await supabase.from('notes').insert({'body': note});
  }

  // Update Note
  Future<void> updateNote(String noteId, String updatedNote) async {
    await supabase.from('notes').update({'body': updatedNote}).eq('id', noteId);
  }

  // Delete Note
  Future<void> deleteNote(String noteId) async {
    await supabase.from('notes').delete().eq('id', noteId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("My Notes"),
        actions: [
          IconButton(
            onPressed: signOut,
            icon: const Icon(Icons.logout_outlined),
          )
        ],
        automaticallyImplyLeading: false,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return SimpleDialog(
                  title: const Text('Add a note'),
                  children: [
                    TextFormField(
                      onFieldSubmitted: (value) {
                        createNote(value);
                        if (mounted) Navigator.pop(context);
                      },
                    )
                  ],
                );
              });
        },
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder(
        stream: noteStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: Text('CRUD with Supabase'),
            );
            //return const Center(child: CircularProgressIndicator());
          }
          final notes = snapshot.data!;

          return ListView.builder(
            itemCount: notes.length,
            itemBuilder: (context, index) {
              final note = notes[index];
              final noteId = note['id'].toString();

              return ListTile(
                title: Text(note['body']),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return SimpleDialog(
                              title: const Text('Edit a note'),
                              children: [
                                TextFormField(
                                  initialValue: note['body'],
                                  onFieldSubmitted: (value) async {
                                    await updateNote(noteId, value);
                                    if (mounted) Navigator.pop(context);
                                  },
                                )
                              ],
                            );
                          },
                        );
                      },
                      icon: const Icon(Icons.edit),
                    ),
                    IconButton(
                      onPressed: () async {
                        bool deletedConfirmed = await showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Delete note'),
                              content: const Text(
                                  'Are you sure you want to delete this note?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context, false);
                                  },
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context, true);
                                  },
                                  child: const Text('Delete'),
                                ),
                              ],
                            );
                          },
                        );
                        if (deletedConfirmed) {
                          await deleteNote(noteId);
                        }
                      },
                      icon: const Icon(Icons.delete),
                    )
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
