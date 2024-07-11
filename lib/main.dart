import 'package:flutter/material.dart';

void main() {
  runApp(NotesApp());
}

class NotesApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notes App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: NotesScreen(),
    );
  }
}

class NotesScreen extends StatefulWidget {
  @override
  _NotesScreenState createState() => _NotesScreenState();
}

class _NotesScreenState extends State<NotesScreen> {
  List<Note> _notes = [];
  List<bool> _selectedNotes = [];
  TextEditingController _textEditingController = TextEditingController();
  bool _isSelecting = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _isSelecting ? const Text('Delete Notes') : const Text('Notes'),
        actions: [
          if (_isSelecting)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                _deleteSelectedNotes();
              },
            ),
          IconButton(
            icon: Icon(_isSelecting ? Icons.close : Icons.select_all),
            onPressed: () {
              setState(() {
                if (_isSelecting) {
                  _selectedNotes = List<bool>.filled(_notes.length, false);
                }
                _isSelecting = !_isSelecting;
              });
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/image.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(146, 205, 190, 190),
                  ),
                  child: Center(
                    child: const Text(
                      "Notes App",
                      style: TextStyle(
                        color: Color.fromARGB(255, 0, 0, 0),
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                ),
                ListTile(
                  leading: const Icon(
                    Icons.info,
                    color: Colors.black,
                  ),
                  title: const Text(
                    'About',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context); // Close the drawer
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AboutPage()),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.settings,
                    color: Colors.black,
                  ),
                  title: const Text(
                    'Settings',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context); // Close the drawer
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SettingsPage()),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'My Notes',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _textEditingController,
              decoration: const InputDecoration(
                hintText: 'Enter a new note...',
                border: OutlineInputBorder(),
              ),
              onSubmitted: _addNote,
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _notes.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      if (_isSelecting) {
                        setState(() {
                          _selectedNotes[index] = !_selectedNotes[index];
                        });
                      }
                    },
                    child: Card(
                      elevation: 3,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      color: _isSelecting && _selectedNotes[index]
                          ? Colors.green[100]
                          : Colors.white,
                      child: ListTile(
                        title: Text(_notes[index].text),
                        subtitle: Text(_notes[index].timestamp),
                        trailing: _isSelecting
                            ? Checkbox(
                                value: _selectedNotes[index],
                                onChanged: (value) {
                                  setState(() {
                                    _selectedNotes[index] = value!;
                                  });
                                },
                              )
                            : null,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _addNote(String noteText) {
    if (noteText.isNotEmpty) {
      setState(() {
        _notes.add(Note(
          text: noteText,
          timestamp: DateTime.now().toString(),
        ));
        _selectedNotes.add(false);
        _textEditingController.clear();
      });
    }
  }

  void _deleteSelectedNotes() {
    setState(() {
      for (int i = _selectedNotes.length - 1; i >= 0; i--) {
        if (_selectedNotes[i]) {
          _notes.removeAt(i);
          _selectedNotes.removeAt(i);
        }
      }
      _isSelecting = false;
    });
  }
}

class Note {
  final String text;
  final String timestamp;

  Note({
    required this.text,
    required this.timestamp,
  });
}

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: const Center(
        child: Text('Settings Page'),
      ),
    );
  }
}

class AboutPage extends StatelessWidget {
  // Define a list of group members with their IDs
  final List<Map<String, String>> groupMembers = [
    {'name': 'Mahlet Yimenu', 'id': 'BDU1208964'},
    {'name': 'Fitsum Seid', 'id': 'BDU1208664'},
    {'name': 'Hbtamu Kassahun', 'id': 'BDU'},
    {'name': 'Brihan Ayalew', 'id': 'BDU'},

    // Add more members as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Bahirdar Institute of Technology',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Mobile Application Development Group Assignment',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            DataTable(
              columns: [
                DataColumn(
                  label: Text(
                    'Name',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'ID',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
              rows: groupMembers
                  .map((member) => DataRow(
                        cells: [
                          DataCell(Text(member['name'] ?? '')),
                          DataCell(Text(member['id'] ?? '')),
                        ],
                      ))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
