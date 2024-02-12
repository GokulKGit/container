import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ImageSelectionScreen(),
    );
  }
}

class ImageSelectionScreen extends StatefulWidget {
  @override
  _ImageSelectionScreenState createState() => _ImageSelectionScreenState();
}

class _ImageSelectionScreenState extends State<ImageSelectionScreen> {
  List<XFile>? _imageFiles = [];

  Future<void> _pickImages() async {
    List<XFile>? pickedImages = await ImagePicker().pickMultiImage(
      imageQuality: 80,
      maxWidth: 800,
    );
    if (pickedImages != null && pickedImages.isNotEmpty) {
      setState(() {
        _imageFiles = pickedImages;
      });
    }
  }

  void _removeImage(int index) {
    setState(() {
      _imageFiles!.removeAt(index);
    });
  }

  Future<void> _uploadImages() async {
    if (_imageFiles != null && _imageFiles!.isNotEmpty) {
      List<File> images =
          _imageFiles!.map((image) => File(image.path)).toList();

      // Simulate posting images to an API
      String url = 'YOUR_API_ENDPOINT_HERE'; // Replace with your API endpoint
      var request = http.MultipartRequest('POST', Uri.parse(url));
      for (var image in images) {
        String fileName = image.path.split('/').last;
        request.files.add(
          await http.MultipartFile.fromPath(
            'images[]', // Replace 'images[]' with your API parameter name for multiple images
            image.path,
            filename: fileName,
          ),
        );
      }

      try {
        final response = await request.send();
        if (response.statusCode == 200) {
          // Handle success response
          print('Images uploaded successfully!');
        } else {
          // Handle error response
          print('Failed to upload images. Status code: ${response.statusCode}');
        }
      } catch (error) {
        // Handle exceptions
        print('Error uploading images: $error');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          ElevatedButton(
            onPressed: _pickImages,
            child: Text('Select Images'),
          ),
          SizedBox(height: 20),
          Expanded(
            child: _imageFiles != null && _imageFiles!.isNotEmpty
                ? GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemCount: _imageFiles!.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Stack(
                          children: [
                            Image.file(
                              File(_imageFiles![index].path),
                              height: 100,
                              width: 100,
                              fit: BoxFit.cover,
                            ),
                            Positioned(
                              top: 0,
                              right: 0,
                              child: GestureDetector(
                                onTap: () {
                                  _removeImage(index);
                                },
                                child: Container(
                                  padding: EdgeInsets.all(4),
                                  color: Colors.red,
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  )
                : Center(
                    child: Text('No images selected'),
                  ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _uploadImages,
            child: Text('Upload Images'),
          ),
        ],
      ),
    );
  }
}
