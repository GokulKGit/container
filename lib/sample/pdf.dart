import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

// void main() {
//   runApp(MyApp());
// }

class MyApp extends StatefulWidget {
  MyApp({required this.yourResponseData});
  Map<String, dynamic> yourResponseData;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Bill Preview'),
      ),
      body: FutureBuilder<Uint8List>(
        future: pdfBuilder(widget.yourResponseData),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return InteractiveViewer(
              panEnabled: false,
              boundaryMargin: const EdgeInsets.all(80),
              minScale: 0.5,
              maxScale: 4,
              child: PdfPreview(build: (context) => snapshot.data!),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Future<Uint8List> pdfBuilder(Map<String, dynamic> responseData) async {
    final pdf = pw.Document();

    final imageLogo = MemoryImage(
        (await rootBundle.load('assets/tec-1.png')).buffer.asUint8List());

    // Extract necessary data from responseData
    final containerDetails = responseData['data']['container_details'];
    final cleaningDetails = responseData['data']['cleaning_details'];
    final damageDetails = responseData['data']['damage_details'];

    // Create a header row for cleaning details table
    final headerRow = pw.TableRow(
      children: [
        pw.Padding(
          padding: const pw.EdgeInsets.all(4),
          child: pw.Text("ID"),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.all(4),
          child: pw.Text("Cleaning Type"),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.all(4),
          child: pw.Text("Quantity"),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.all(4),
          child: pw.Text("Account"),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.all(4),
          child: pw.Text("Owner Charge"),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.all(4),
          child: pw.Text("Third Party Charges"),
        ),
      ],
    );

    // Create a header row for damage details table
    final damageHeaderRow = pw.TableRow(
      children: [
        pw.Padding(
          padding: const pw.EdgeInsets.all(4),
          child: pw.Text("ID"),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.all(4),
          child: pw.Text("Comp Code"),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.all(4),
          child: pw.Text("Damage Code"),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.all(4),
          child: pw.Text("Repair Code"),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.all(4),
          child: pw.Text("Location"),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.all(4),
          child: pw.Text("Length"),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.all(4),
          child: pw.Text("Width"),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.all(4),
          child: pw.Text("Damage Quantity"),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.all(4),
          child: pw.Text("Account"),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.all(4),
          child: pw.Text("Manhour"),
        ),
        pw.Padding(
          padding: const pw.EdgeInsets.all(4),
          child: pw.Text("Metal Price"),
        ),
      ],
    );

    // Add header row to the table
    pdf.addPage(
      pw.Page(
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              // pw.Image(),
              pw.Table(
                border: pw.TableBorder.all(
                  color: PdfColor.fromInt(
                    0xFF0F0F0F,
                  ),
                ),
                children: [
                  pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text("Container Number"),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child:
                            pw.Text("${containerDetails['container_number']}"),
                      ),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text("ISO size"),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text("${containerDetails['iso_size']}"),
                      ),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text("Gross Weight"),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text("${containerDetails['gross_weight']}"),
                      ),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text("Tare Weight"),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text("${containerDetails['tare_weight']}"),
                      ),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text("Manifacture Date"),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child:
                            pw.Text("${containerDetails['manifacture_date']}"),
                      ),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text("Agent Liner"),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text("${containerDetails['agent_liner']}"),
                      ),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text("Movement Type"),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text("${containerDetails['movement_type']}"),
                      ),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text("Vehicle Number"),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text("${containerDetails['vehicle_number']}"),
                      ),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text("Booking Number"),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text("${containerDetails['booking_number']}"),
                      ),
                    ],
                  ),
                  pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text("CSC"),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(4),
                        child: pw.Text("${containerDetails['csc']}"),
                      ),
                    ],
                  ),
                ],
              ),

              pw.Padding(
                padding: const pw.EdgeInsets.only(top: 20, bottom: 5),
                child: pw.Text("General Cleaning"),
              ),

              // Dynamic table for cleaningDetails
              pw.Table(
                border: pw.TableBorder.all(
                  color: PdfColor.fromInt(0xFF0F0F0F),
                ),
                children: [headerRow, ..._buildCleaningRows(cleaningDetails)],
              ),

              pw.Padding(
                padding: const pw.EdgeInsets.only(top: 20, bottom: 5),
                child: pw.Text("Damages"),
              ),

              // Dynamic table for damageDetails
              pw.Table(
                border: pw.TableBorder.all(
                  color: PdfColor.fromInt(0xFF0F0F0F),
                ),
                children: [damageHeaderRow, ..._buildDamageRows(damageDetails)],
              ),

              // ... additional content
            ],
          );
        },
      ),
    );

    return pdf.save();
  }

  // Function to dynamically build rows for cleaningDetails table
  List<pw.TableRow> _buildCleaningRows(List<dynamic> cleaningDetails) {
    List<pw.TableRow> rows = [];

    for (var cleaningDetail in cleaningDetails) {
      final dataRow = pw.TableRow(
        children: [
          pw.Padding(
            padding: const pw.EdgeInsets.all(4),
            child: pw.Text("${cleaningDetail['id']}"),
          ),
          pw.Padding(
            padding: const pw.EdgeInsets.all(4),
            child: pw.Text("${cleaningDetail['cleaningtype']}"),
          ),
          pw.Padding(
            padding: const pw.EdgeInsets.all(4),
            child: pw.Text("${cleaningDetail['quantity']}"),
          ),
          pw.Padding(
            padding: const pw.EdgeInsets.all(4),
            child: pw.Text("${cleaningDetail['account']}"),
          ),
          pw.Padding(
            padding: const pw.EdgeInsets.all(4),
            child: pw.Text("${cleaningDetail['ownercharge']}"),
          ),
          pw.Padding(
            padding: const pw.EdgeInsets.all(4),
            child: pw.Text("${cleaningDetail['third_party_charges']}"),
          ),
        ],
      );

      rows.add(dataRow);
    }

    return rows;
  }

  // Function to dynamically build rows for damageDetails table
  List<pw.TableRow> _buildDamageRows(List<dynamic> damageDetails) {
    List<pw.TableRow> rows = [];

    for (var damageDetail in damageDetails) {
      final dataRow = pw.TableRow(
        children: [
          pw.Padding(
            padding: const pw.EdgeInsets.all(4),
            child: pw.Text("${damageDetail['id']}"),
          ),
          pw.Padding(
            padding: const pw.EdgeInsets.all(4),
            child: pw.Text("${damageDetail['compcode']}"),
          ),
          pw.Padding(
            padding: const pw.EdgeInsets.all(4),
            child: pw.Text("${damageDetail['dmgcode']}"),
          ),
          pw.Padding(
            padding: const pw.EdgeInsets.all(4),
            child: pw.Text("${damageDetail['repcode']}"),
          ),
          pw.Padding(
            padding: const pw.EdgeInsets.all(4),
            child: pw.Text("${damageDetail['location']}"),
          ),
          pw.Padding(
            padding: const pw.EdgeInsets.all(4),
            child: pw.Text("${damageDetail['length']}"),
          ),
          pw.Padding(
            padding: const pw.EdgeInsets.all(4),
            child: pw.Text("${damageDetail['width']}"),
          ),
          pw.Padding(
            padding: const pw.EdgeInsets.all(4),
            child: pw.Text("${damageDetail['damage_quantity']}"),
          ),
          pw.Padding(
            padding: const pw.EdgeInsets.all(4),
            child: pw.Text("${damageDetail['acc']}"),
          ),
          pw.Padding(
            padding: const pw.EdgeInsets.all(4),
            child: pw.Text("${damageDetail['manhour']}"),
          ),
          pw.Padding(
            padding: const pw.EdgeInsets.all(4),
            child: pw.Text("${damageDetail['metalprice']}"),
          ),
        ],
      );

      rows.add(dataRow);
    }

    return rows;
  }

  // Map<String, dynamic> yourResponseData = {
  //   'success': true,
  //   'message':
  //       'Container details, images, cleaning, and damages uploaded successfully!',
  //   'data': {
  //     'container_details': {
  //       'container_number': '62727277',
  //       'iso_size': '25G1',
  //       'gross_weight': '17',
  //       'tare_weight': '72',
  //       'manifacture_date': '05-07-2024',
  //       'agent_liner': 'HTS',
  //       'movement_type': 'IN-RETURN-DIPOT TRANSFER',
  //       'vehicle_number': '62727',
  //       'booking_number': '72727',
  //       'csc': 'vshshh',
  //       'id': 16,
  //     },
  //     'cleaning_details': [
  //       {
  //         'id': 25,
  //         'cleaningtype': 'Type2',
  //         'quantity': '6',
  //         'account': 'I',
  //         'ownercharge': '6488',
  //         'third_party_charges': '646469',
  //         'gateone_id': 16,
  //         'cleaning_images': null
  //       },
  //       {
  //         'id': 26,
  //         'cleaningtype': 'Type2',
  //         'quantity': '6',
  //         'account': 'I',
  //         'ownercharge': '6488',
  //         'third_party_charges': '646469',
  //         'gateone_id': 16,
  //         'cleaning_images': null
  //       }
  //     ],
  //     'damage_details': [
  //       {
  //         'id': 20,
  //         'compcode': '77',
  //         'dmgcode': '76',
  //         'repcode': '77',
  //         'location': 'jsjeh',
  //         'length': '88',
  //         'width': '87',
  //         'damage_quantity': '1',
  //         'acc': '6',
  //         'manhour': '56',
  //         'metalprice': '7177',
  //         'gateone_id': 16,
  //         'damage_images': null
  //       },
  //       {
  //         'id': 21,
  //         'compcode': '77',
  //         'dmgcode': '76',
  //         'repcode': '77',
  //         'location': 'jsjeh',
  //         'length': '88',
  //         'width': '87',
  //         'damage_quantity': '1',
  //         'acc': '6',
  //         'manhour': '56',
  //         'metalprice': '7177',
  //         'gateone_id': 16,
  //         'damage_images': null
  //       }
  //     ]
  //   }
  // };
}
