import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker_example/utils/image_picker_handler.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(body: SafeArea(child: _ImagePickerExample())),
    );
  }
}

class _ImagePickerExample extends StatefulWidget {
  const _ImagePickerExample({super.key});

  @override
  State<_ImagePickerExample> createState() => _ImagePickerExampleState();
}

class _ImagePickerExampleState extends State<_ImagePickerExample> {
  String imagePath = '';
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    return SizedBox(
      width: width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [ const SizedBox(
            height: 15,
          ),
          _PlaceholderOrPicture(imagePath: imagePath),
          const SizedBox(
            height: 15,
          ),
          ElevatedButton.icon(
            style: ButtonStyle(
                fixedSize: MaterialStateProperty.resolveWith(
                    (states) => const Size(150, 40))),
            onPressed: () async {
              final imagePickerHandler = ImagePickerHandler();
              final xFile = await imagePickerHandler.takePicture();
              if (xFile != null) {
                final imagePath =
                    '${(await path_provider.getTemporaryDirectory()).path}${DateTime.now()}.jpg';
    
                xFile.saveTo(imagePath).then((value) {
                  setState(() {
                    this.imagePath = imagePath;
                  });
                });
              }
            },
            label: Text('Take a picture'),
            icon: Icon(Icons.camera),
          ),
          const SizedBox(
            height: 15,
          ),
          ElevatedButton.icon(
            style: ButtonStyle(
                fixedSize: MaterialStateProperty.resolveWith(
                    (states) => const Size(150, 40))),
            onPressed: () async {
              final imagePickerHandler = ImagePickerHandler();
              final xFile = await imagePickerHandler.selectFromGallery();
              if (xFile != null) {
                final imagePath =
                    '${(await path_provider.getTemporaryDirectory()).path}${DateTime.now()}.jpg';
    
                xFile.saveTo(imagePath).then((value) {
                  setState(() {
                    this.imagePath = imagePath;
                  });
                });
              }
            },
            label: Text('Select from gallery'),
            icon: Icon(Icons.image),
          ),
          
        ],
      ),
    );
  }
}

class _PlaceholderOrPicture extends StatelessWidget {
  const _PlaceholderOrPicture({
    super.key,
    required this.imagePath,
  });

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Visibility(
        replacement: Container(
          width: imageWidth,
          height: imageHeight,
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          child: const Center(
            child: Icon(
              Icons.image,
              size: 200,
            ),
          ),
        ),
        visible: imagePath.isNotEmpty,
        child: Center(
          child: Image.file(
            File(imagePath),
            height: imageHeight,
            width: imageWidth,
          ),
        ));
  }
}

const imageWidth = 250.0;
const imageHeight = 250.0;