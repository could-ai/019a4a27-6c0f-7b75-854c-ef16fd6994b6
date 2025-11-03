import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Creator App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const ImageCreatorHomePage(),
    );
  }
}

class ImageCreatorHomePage extends StatefulWidget {
  const ImageCreatorHomePage({super.key});

  @override
  State<ImageCreatorHomePage> createState() => _ImageCreatorHomePageState();
}

class _ImageCreatorHomePageState extends State<ImageCreatorHomePage> {
  File? _selectedImage;
  File? _generatedImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
        _generatedImage = null; // Reset generated image when new image is selected
      });
    }
  }

  void _generateImage() {
    // Mock image generation: For now, just copy the selected image as generated.
    // In a real app, this would call an AI API like Gemini for image creation/modification.
    if (_selectedImage != null) {
      setState(() {
        _generatedImage = _selectedImage; // Placeholder: replace with actual generation logic
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Creator'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: _pickImage,
              child: const Text('Upload Image'),
            ),
            const SizedBox(height: 20),
            if (_selectedImage != null)
              Expanded(
                child: Column(
                  children: [
                    const Text('Uploaded Image:'),
                    Expanded(
                      child: Image.file(_selectedImage!),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _generateImage,
                      child: const Text('Create Image'),
                    ),
                  ],
                ),
              ),
            if (_generatedImage != null)
              Expanded(
                child: Column(
                  children: [
                    const Text('Generated Image:'),
                    Expanded(
                      child: Image.file(_generatedImage!),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}