import 'text_styles.dart';
import 'theme.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminFixturesPage extends StatefulWidget {
  final String clubId;
  const AdminFixturesPage({super.key, required this.clubId});

  @override
  State<AdminFixturesPage> createState() => _AdminFixturesPageState();
}

class _AdminFixturesPageState extends State<AdminFixturesPage> {
  final _formKey = GlobalKey<FormState>();
  String? idToEdit;
  Map<String, dynamic> formData = {
    'date': '',
    'opponent': '',
    'duration': '',
    'score': '',
    'location': '',
    'livestream': '',
    'scorers': [],
  };

  final TextEditingController dateController = TextEditingController();
  final TextEditingController opponentController = TextEditingController();
  final TextEditingController durationController = TextEditingController();
  final TextEditingController scoreController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController livestreamController = TextEditingController();

  String tempScorerName = '';
  int tempScorerGoals = 0;

  void clearForm() {
    setState(() {
      idToEdit = null;
      formData = {
        'date': '',
        'opponent': '',
        'duration': '',
        'score': '',
        'location': '',
        'livestream': '',
        'scorers': [],
      };
      dateController.clear();
      opponentController.clear();
      durationController.clear();
      scoreController.clear();
      locationController.clear();
      livestreamController.clear();
      tempScorerName = '';
      tempScorerGoals = 0;
    });
  }

  Future<void> saveFixture() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final ref = FirebaseFirestore.instance.collection('clubs').doc(widget.clubId).collection('fixtures');

      if (idToEdit != null) {
        await ref.doc(idToEdit).update(formData);
      } else {
        await ref.add(formData);
      }

      clearForm();
    }
  }

  Future<void> deleteFixture(String id) async {
    final ref = FirebaseFirestore.instance.collection('clubs').doc(widget.clubId).collection('fixtures');
    await ref.doc(id).delete();
  }

void populateForm(DocumentSnapshot doc) {
  final data = doc.data() as Map<String, dynamic>;
  setState(() {
    idToEdit = doc.id;
    formData = Map<String, dynamic>.from(data);

    // Ensure scorers is a non-null list
    formData['scorers'] = formData['scorers'] != null && formData['scorers'] is List
        ? List<Map<String, dynamic>>.from(formData['scorers'])
        : [];

    dateController.text = formData['date'] ?? '';
    opponentController.text = formData['opponent'] ?? '';
    durationController.text = formData['duration'] ?? '';
    scoreController.text = formData['score'] ?? '';
    locationController.text = formData['location'] ?? '';
    livestreamController.text = formData['livestream'] ?? '';
  });
}

  @override
  Widget build(BuildContext context) {
    final ref = FirebaseFirestore.instance.collection('clubs').doc(widget.clubId).collection('fixtures');

    return Scaffold(
      appBar: AppBar(title: const Text('Manage Fixtures')),
      body: Row(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: ref.orderBy('date').snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
                final docs = snapshot.data!.docs;
                return ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    final data = docs[index].data() as Map<String, dynamic>;
                    return ListTile(
                      title: Text(data['opponent'] ?? ''),
                      subtitle: Text(data['date'] ?? ''),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () => populateForm(docs[index]),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () => deleteFixture(docs[index].id),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
          const VerticalDivider(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      TextFormField(
                        controller: dateController,
                        decoration: const InputDecoration(labelText: 'Date'),
                        onSaved: (val) => formData['date'] = val ?? '',
                      ),
                      TextFormField(
                        controller: opponentController,
                        decoration: const InputDecoration(labelText: 'Opponent'),
                        onSaved: (val) => formData['opponent'] = val ?? '',
                      ),
                      TextFormField(
                        controller: durationController,
                        decoration: const InputDecoration(labelText: 'Duration'),
                        onSaved: (val) => formData['duration'] = val ?? '',
                      ),
                      TextFormField(
                        controller: scoreController,
                        decoration: const InputDecoration(labelText: 'Score'),
                        onSaved: (val) => formData['score'] = val ?? '',
                      ),
                      TextFormField(
                        controller: locationController,
                        decoration: const InputDecoration(labelText: 'Location'),
                        onSaved: (val) => formData['location'] = val ?? '',
                      ),
                      TextFormField(
                        controller: livestreamController,
                        decoration: const InputDecoration(labelText: 'Livestream'),
                        onSaved: (val) => formData['livestream'] = val ?? '',
                      ),
                      const SizedBox(height: 16),
                      const Text('Scorers', style: TextStyle(fontWeight: FontWeight.bold)),
                      for (int i = 0; i < formData['scorers'].length; i++)
                        ListTile(
                          title: Text(formData['scorers'][i]['name']),
                          subtitle: Text('Goals: ${formData['scorers'][i]['goals']}'),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              setState(() {
                                formData['scorers'].removeAt(i);
                              });
                            },
                          ),
                        ),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              decoration: const InputDecoration(labelText: 'Scorer Name'),
                              onChanged: (val) => tempScorerName = val,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: TextFormField(
                              decoration: const InputDecoration(labelText: 'Goals'),
                              keyboardType: TextInputType.number,
                              onChanged: (val) => tempScorerGoals = int.tryParse(val) ?? 0,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () {
                              if (tempScorerName.trim().isEmpty || tempScorerGoals <= 0) return;
                              setState(() {
                                formData['scorers'].add({
                                  'name': tempScorerName,
                                  'goals': tempScorerGoals,
                                });
                                tempScorerName = '';
                                tempScorerGoals = 0;
                              });
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: saveFixture,
                        child: Text(idToEdit != null ? 'Update Fixture' : 'Add Fixture'),
                      ),
                      if (idToEdit != null)
                        TextButton(onPressed: clearForm, child: const Text('Cancel Edit')),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

extension on String {
  String capitalize() => isEmpty ? this : '${this[0].toUpperCase()}${substring(1)}';
}
