import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class FirebaseStorageLesson extends StatefulWidget {
  const FirebaseStorageLesson({Key? key}) : super(key: key);
  @override
  State<FirebaseStorageLesson> createState() => _FirebaseStorageLessonState();
}

class _FirebaseStorageLessonState extends State<FirebaseStorageLesson> {
  final ImagePicker _picker = ImagePicker();
  File? _image;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? _retrievedImageUrl;

  Future getImage() async {
    var image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = File(image!.path);
    });
  }

  // Future uploadImage() async {
  //   final storageRef = FirebaseStorage.instance.ref().child('profilePicture');
  //   UploadTask uploadTask = storageRef.putFile(_image!);
  //   String imageUrl = await storageRef.getDownloadURL();
  //   await _firestore.collection('users').doc('user1').set({
  //     'profileImage': imageUrl,
  //   });
  // }

  Future retrieveImage() async {}

  Future uploadMultipleImages() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase Storage'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 300,
              child: (_retrievedImageUrl != null)
                  ? Image.network(_retrievedImageUrl!)
                  : const Text('No image'),
            ),
            ElevatedButton(
              onPressed: () {
                getImage();
              },
              child: const Text('Get Image'),
            ),
            ElevatedButton(
              onPressed: () {
                //uploadImage();
              },
              child: const Text('Upload'),
            ),
            ElevatedButton(
              onPressed: () {
                retrieveImage();
              },
              child: const Text('Retrieve Image'),
            ),
            ElevatedButton(
              onPressed: () {
                uploadMultipleImages();
              },
              child: const Text('Upload List'),
            ),
          ],
        ),
      ),
    );
  }
}
