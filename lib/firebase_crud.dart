import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class FirebaseCrud extends StatefulWidget {
  const FirebaseCrud({Key? key}) : super(key: key);
  @override
  State<FirebaseCrud> createState() => _FirebaseCrudState();
}

class _FirebaseCrudState extends State<FirebaseCrud> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  void _create() async {
    try {
      await firestore.collection('users').doc('testUser').set({
        'firstName': 'test',
        'lastName': 'user',
      });
    } catch (e) {
      print(e);
    }
  }

  void _read() async {
    DocumentSnapshot snapshot;
    try {
      snapshot = await firestore.collection('users').doc('testUser').get();
      print(snapshot.data());
    } catch (e) {
      print(e);
    }
  }

  void _update() async {
    try {
      firestore
          .collection('users')
          .doc('testUser')
          .update({'firstName': 'test2'});
    } catch (e) {
      print(e);
    }
  }

  void _delete() async {
    try {
      firestore.collection('users').doc('testUser').delete();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase CRUD'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                _create();
              },
              child: Text('Create'),
            ),
            ElevatedButton(
              onPressed: () {
                _read();
              },
              child: Text('Read'),
            ),
            ElevatedButton(
              onPressed: () {
                _update();
              },
              child: Text('Update'),
            ),
            ElevatedButton(
              onPressed: () {
                _delete();
              },
              child: Text('Delete'),
            ),
          ],
        ),
      ),
    );
  }
}
