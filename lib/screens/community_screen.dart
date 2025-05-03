import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../services/firebase_service.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({Key? key}) : super(key: key);
  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  final FirebaseService _firebase = FirebaseService();
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _firebase.initNotifications();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Community Reports')),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _firebase.firestore
                  .collection('reports')
                  .orderBy('timestamp', descending: true)
                  .snapshots(),
              builder: (ctx, snap) {
                if (snap.hasError) {
                  return const Center(child: Text('Error loading reports'));
                }
                if (snap.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                final docs = snap.data!.docs;
                return ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (i, idx) {
                    final data = docs[idx].data() as Map<String, dynamic>;
                    final Timestamp? ts = data['timestamp'] as Timestamp?;
                    return ListTile(
                      leading: const Icon(Icons.report),
                      title: Text(data['text'] ?? ''),
                      subtitle: Text(
                        ts != null ? ts.toDate().toLocal().toString() : '',
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      labelText: 'What\'s happening?',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    final text = _controller.text.trim();
                    if (text.isNotEmpty) {
                      _firebase.saveReport(text);
                      _controller.clear();
                    }
                  },
                  child: const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
