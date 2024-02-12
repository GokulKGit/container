// import 'package:flutter/material.dart';
// import 'package:docx/docx.dart' as docxLib;
// import 'dart:io';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: WordDocumentGenerator(),
//     );
//   }
// }

// class WordDocumentGenerator extends StatefulWidget {
//   @override
//   _WordDocumentGeneratorState createState() => _WordDocumentGeneratorState();
// }

// class _WordDocumentGeneratorState extends State<WordDocumentGenerator> {
//   final TextEditingController textFieldController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Word Document Generator'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: textFieldController,
//               decoration: InputDecoration(labelText: 'Enter Text'),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 generateWordDocument();
//               },
//               child: Text('Generate Word Document'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<void> generateWordDocument() async {
//     final doc = docxLib.Document();

//     // Add content to the Word document
//     doc.addParagraph(docxLib.Paragraph()..text = 'Word Document Example');
//     doc.addParagraph(docxLib.Paragraph()
//       ..text = 'Text from TextField: ${textFieldController.text}');

//     // Save the Word document to a file
//     final file = File('example.docx');
//     await file.writeAsBytes(await docxLib.saveDocument(doc));
//   }
// }
