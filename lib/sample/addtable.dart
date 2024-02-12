import 'dart:convert';
import 'dart:io';

import 'package:container/models/container_clear_data.dart';
import 'package:container/models/damages_and_cleaning.dart';
import 'package:container/sample/pdf.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class DataEntryScreen extends StatefulWidget {
  @override
  _DataEntryScreenState createState() => _DataEntryScreenState();
}

class _DataEntryScreenState extends State<DataEntryScreen> {
  List<XFile>? _imageFiles = [];

  Future<void> _pickImages() async {
    List<XFile>? pickedImages = await ImagePicker().pickMultiImage(
      imageQuality: 80,
      maxWidth: 800,
    );
    if (pickedImages.isNotEmpty) {
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

  List<XFile>? _imageFilesCleaning = [];

  Future<void> _pickImagesCleaning() async {
    List<XFile>? pickedImages = await ImagePicker().pickMultiImage(
      imageQuality: 80,
      maxWidth: 800,
    );
    if (pickedImages.isNotEmpty) {
      setState(() {
        _imageFilesCleaning = pickedImages;
      });
    }
  }

  void _removeImageCleaning(int index) {
    setState(() {
      _imageFilesCleaning!.removeAt(index);
    });
  }

  List<XFile>? _imageFileDamages = [];

  Future<void> _pickImagesDamages() async {
    List<XFile>? pickedImages = await ImagePicker().pickMultiImage(
      imageQuality: 80,
      maxWidth: 800,
    );
    if (pickedImages.isNotEmpty) {
      setState(() {
        _imageFileDamages = pickedImages;
      });
    }
  }

  void _removeImageDamages(int index) {
    setState(() {
      _imageFileDamages!.removeAt(index);
    });
  }

  String _selectedIso = 'ISO/Size'; // Initially selected item

  // List of dropdown items
  final List<String> _dropdownIso = [
    'ISO/Size',
    '22G1',
    '25G1',
    '42G1',
    '45G1',
    '22R1'
  ];

  String _selectedAgent = 'Agent/Liner/Cus/NVOCC'; // Initially selected item

  // List of dropdown items
  final List<String> _dropdownAgent = [
    'Agent/Liner/Cus/NVOCC',
    'HMM',
    'TMM',
    'RMM',
    'HTS',
    'GH'
  ];

  String _selectedMovement = 'Movement Type'; // Initially selected item

  // List of dropdown items
  final List<String> _dropdownMovement = [
    'Movement Type',
    'IN-RETURN-CONSIGNEE',
    'IN-RETURN-IMPORT',
    'IN-RETURN-OFFHIRE',
    'IN-RETURN-DIPOT TRANSFER',
    'OUT-CONSIGNEE',
    'OUT-EXPORT',
    'OUT-REPO'
  ];

  String _selectedCleaningType = 'Cleaning Type'; // Initially selected item

  // List of dropdown items
  final List<String> _dropdownCleaningType = [
    'Cleaning Type',
    'Washing',
    'Welding',
    'Type2',
    'Type1',
  ];

  String _selectedAccount = 'Account'; // Initially selected item

  // List of dropdown items
  final List<String> _dropdownAccount = [
    'Account',
    'T',
    'O',
    'L',
    'I',
    'W',
  ];

  TextEditingController containerNumbersGeneral = TextEditingController();
  TextEditingController grossWeightGeneral = TextEditingController();
  TextEditingController tareWeightGeneral = TextEditingController();
  late TextEditingController manufactureDateGeneral;
  TextEditingController vechicleNumberGeneral = TextEditingController();
  TextEditingController bookingNumberGeneral = TextEditingController();
  TextEditingController CSCGeneral = TextEditingController();

  TextEditingController textEditingController1 = TextEditingController();
  TextEditingController textEditingController2 = TextEditingController();
  TextEditingController textEditingController3 = TextEditingController();
  TextEditingController textEditingController4 = TextEditingController();
  TextEditingController textEditingController5 = TextEditingController();
  TextEditingController textEditingController6 = TextEditingController();
  TextEditingController textEditingController7 = TextEditingController();
  TextEditingController textEditingController8 = TextEditingController();
  TextEditingController textEditingController9 = TextEditingController();
  TextEditingController textEditingController10 = TextEditingController();

  TextEditingController QTY = TextEditingController();
  TextEditingController ownerCharge = TextEditingController();
  TextEditingController thirdpartyCharge = TextEditingController();

  final List<ContainerCleaningData> _containerCleaningData = [];

  final List<DamagesAndCleaning> _damagesAndCleanings = [];

  @override
  void initState() {
    String currentDate = DateFormat('dd-mm-yyyy').format(DateTime.now());
    manufactureDateGeneral = TextEditingController(text: currentDate);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('GATE IN')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text("General Process"),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: containerNumbersGeneral,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 2.5, color: Colors.blueGrey),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintText: "Container Number",
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(width: 2.5, color: Colors.blueGrey),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedIso,
                        items: _dropdownIso.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 16.0,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedIso = newValue ?? _dropdownIso.first;
                          });
                        },
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 16.0,
                        ),
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          color: Colors.blueGrey,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: grossWeightGeneral,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 2.5, color: Colors.blueGrey),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      //borderSide:BorderSide(color: lightIconsColor),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintText: "Gross Weight",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: tareWeightGeneral,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 2.5, color: Colors.blueGrey),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      //borderSide:BorderSide(color: lightIconsColor),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintText: "Tare Weight",
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: manufactureDateGeneral,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                            width: 2.5, color: Colors.blueGrey),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      focusedBorder: OutlineInputBorder(
                        //borderSide:BorderSide(color: lightIconsColor),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      hintText: "Manufacture Date",
                      labelText: "Manufacture Date"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(width: 2.5, color: Colors.blueGrey),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedAgent,
                        items: _dropdownAgent.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 16.0,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedAgent = newValue ?? _dropdownAgent.first;
                          });
                        },
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 16.0,
                        ),
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          color: Colors.blueGrey,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(width: 2.5, color: Colors.blueGrey),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedMovement,
                        items: _dropdownMovement.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 16.0,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedMovement =
                                newValue ?? _dropdownMovement.first;
                          });
                        },
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 16.0,
                        ),
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          color: Colors.blueGrey,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: vechicleNumberGeneral,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 2.5, color: Colors.blueGrey),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      //borderSide:BorderSide(color: lightIconsColor),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintText: "Vehicle Number",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: bookingNumberGeneral,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 2.5, color: Colors.blueGrey),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      //borderSide:BorderSide(color: lightIconsColor),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintText: "Booking Number",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: CSCGeneral,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 2.5, color: Colors.blueGrey),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      //borderSide:BorderSide(color: lightIconsColor),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintText: "CSC",
                  ),
                ),
              ),
              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  // if (containerNumbersGeneral.text.isEmpty) {
                  //   showToast("Enter Container Number");
                  // } else if (_selectedIso == "ISO/Size") {
                  //   showToast("Choose ISO/Size");
                  // } else if (grossWeightGeneral.text.isEmpty) {
                  //   showToast("Enter Gross Weight");
                  // } else if (tareWeightGeneral.text.isEmpty) {
                  //   showToast("Enter Tare Weight");
                  // } else if (manufactureDateGeneral.text.isEmpty) {
                  //   showToast("Enter Manufacture Date");
                  // } else if (_selectedAgent == "Agent/Liner/Cus/NVOCC") {
                  //   showToast("Choose Agent/Liner/Cus/NVOCC");
                  // } else if (_selectedMovement == "Movement Type") {
                  //   showToast("Choose Agent/Liner/Cus/NVOCC");
                  // } else if (vechicleNumberGeneral.text.isEmpty) {
                  //   showToast("Enter Vechicle Number");
                  // } else if (bookingNumberGeneral.text.isEmpty) {
                  //   showToast("Enter Booking Number");
                  // } else if (CSCGeneral.text.isEmpty) {
                  //   showToast("Enter CSC");
                  // } else {
                  //   _pickImages();
                  // }

                  _pickImages();
                },
                child: Text('Select General Image'),
              ),
              SizedBox(height: 20),
              Column(
                children: [
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Wrap(
                        spacing: 8.0,
                        runSpacing: 8.0,
                        children: _imageFiles != null && _imageFiles!.isNotEmpty
                            ? _imageFiles!.map((XFile imageFile) {
                                int index = _imageFiles!.indexOf(imageFile);
                                return GestureDetector(
                                  onTap: () {
                                    _removeImage(index);
                                  },
                                  child: Stack(
                                    children: [
                                      Card(
                                        clipBehavior: Clip.antiAlias,
                                        child: Image.file(
                                          File(imageFile.path),
                                          height: 100,
                                          width: 100,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Positioned(
                                        top: 0,
                                        right: 0,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          padding: EdgeInsets.all(4),
                                          child: Icon(
                                            Icons.delete,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList()
                            : [
                                Center(
                                    child: Text(
                                        'Minimum 6 image upload in General Process'))
                              ],
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20),
              // ElevatedButton(
              //   onPressed: _uploadImages,
              //   child: Text('Upload Images'),
              // ),
              Divider(),

              Text("General Cleaning"),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(width: 2.5, color: Colors.blueGrey),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedCleaningType,
                        items: _dropdownCleaningType.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 16.0,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedCleaningType =
                                newValue ?? _dropdownCleaningType.first;
                          });
                        },
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 16.0,
                        ),
                        icon: Icon(
                          Icons.arrow_drop_down,
                          color: Colors.blueGrey,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: QTY,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 2.5, color: Colors.blueGrey),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintText: "QTY",
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(width: 2.5, color: Colors.blueGrey),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: _selectedAccount,
                        items: _dropdownAccount.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 16.0,
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedAccount =
                                newValue ?? _dropdownAccount.first;
                          });
                        },
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 16.0,
                        ),
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          color: Colors.blueGrey,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: ownerCharge,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 2.5, color: Colors.blueGrey),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintText: "Owner Charge",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: thirdpartyCharge,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 2.5, color: Colors.blueGrey),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintText: "Third Party Charges",
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_selectedCleaningType == "Cleaning Type") {
                    showToast("Choose Cleaning Type");
                  } else if (QTY.text.isEmpty) {
                    showToast("Enter QTY");
                  } else if (_selectedAccount == "Account") {
                    showToast("Choose Account");
                  } else if (ownerCharge.text.isEmpty) {
                    showToast("Enter Owner Charge");
                  } else if (thirdpartyCharge.text.isEmpty) {
                    showToast("Enter Third Party Charges");
                  } else {
                    final containerCleaningData = ContainerCleaningData(
                      type: _selectedCleaningType.toString(),
                      quantity: int.parse(QTY.text),
                      account: _selectedAccount.toString(),
                      ownerCharge: int.parse(ownerCharge.text),
                      thirdPartyCharges: int.parse(thirdpartyCharge.text),
                    );

                    if (!_containerCleaningData
                        .contains(containerCleaningData)) {
                      setState(() {
                        _containerCleaningData.add(containerCleaningData);
                        QTY.clear();
                        ownerCharge.clear();
                        thirdpartyCharge.clear();
                      });
                    } else {
                      showToast("Data Already Added");
                    }
                  }
                },
                child: Text('Add'),
              ),
              const SizedBox(height: 40),
              buildTableDisplay(),
              ElevatedButton(
                onPressed: _pickImagesCleaning,
                child: Text('Select Cleaning Image'),
              ),

              SizedBox(height: 20),
              Column(
                children: [
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Wrap(
                        spacing: 8.0,
                        runSpacing: 8.0,
                        children: _imageFilesCleaning != null &&
                                _imageFilesCleaning!.isNotEmpty
                            ? _imageFilesCleaning!.map((XFile imageFile) {
                                int index =
                                    _imageFilesCleaning!.indexOf(imageFile);
                                return GestureDetector(
                                  onTap: () {
                                    _removeImageCleaning(index);
                                  },
                                  child: Stack(
                                    children: [
                                      Card(
                                        clipBehavior: Clip.antiAlias,
                                        child: Image.file(
                                          File(imageFile.path),
                                          height: 100,
                                          width: 100,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Positioned(
                                        top: 0,
                                        right: 0,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          padding: const EdgeInsets.all(4),
                                          child: const Icon(
                                            Icons.delete,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList()
                            : [Center(child: Text('No images selected'))],
                      ),
                    ),
                  ),
                ],
              ),
              // Display table here
              const SizedBox(height: 20),
              const Divider(),
              const Text("Damages and Cleaning"),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: textEditingController1,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 2.5, color: Colors.blueGrey),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintText: "COMP CODE",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: textEditingController2,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 2.5, color: Colors.blueGrey),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintText: "DMG. CODE",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: textEditingController3,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 2.5, color: Colors.blueGrey),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintText: "REP. CODE",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: textEditingController4,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 2.5, color: Colors.blueGrey),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintText: "Location",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: textEditingController5,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 2.5, color: Colors.blueGrey),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintText: "Length",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: textEditingController6,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 2.5, color: Colors.blueGrey),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintText: "Width",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: textEditingController7,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 2.5, color: Colors.blueGrey),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintText: "QTY",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: textEditingController8,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 2.5, color: Colors.blueGrey),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintText: "ACC",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: textEditingController9,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 2.5, color: Colors.blueGrey),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintText: "MAN.HOUR",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextFormField(
                  controller: textEditingController10,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 2.5, color: Colors.blueGrey),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    hintText: "MATERIAL.PRICE",
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  if (textEditingController1.text.isEmpty) {
                    showToast("Enter COMP CODE");
                  } else if (textEditingController2.text.isEmpty) {
                    showToast("Enter DMG. CODE");
                  } else if (textEditingController3.text.isEmpty) {
                    showToast("Enter REP. CODE");
                  } else if (textEditingController4.text.isEmpty) {
                    showToast("Enter Location");
                  } else if (textEditingController5.text.isEmpty) {
                    showToast("Enter Length");
                  } else if (textEditingController6.text.isEmpty) {
                    showToast("Enter Width");
                  } else if (textEditingController7.text.isEmpty) {
                    showToast("Enter QTY");
                  } else if (textEditingController8.text.isEmpty) {
                    showToast("Enter ACC");
                  } else if (textEditingController9.text.isEmpty) {
                    showToast("Enter MAN.HOUR");
                  } else if (textEditingController10.text.isEmpty) {
                    showToast("Enter MATERIAL.PRICE");
                  } else {
                    setState(() {
                      _damagesAndCleanings.add(DamagesAndCleaning(
                        compCode: textEditingController1.text,
                        dmgCode: textEditingController2.text,
                        repCode: textEditingController3.text,
                        location: textEditingController4.text,
                        length: textEditingController5.text,
                        width: textEditingController6.text,
                        quantity: textEditingController7.text,
                        acc: textEditingController8.text,
                        manHour: textEditingController9.text,
                        materialPrice: textEditingController10.text,
                      ));
                      // Clear text fields after adding data
                      textEditingController1.clear();
                      textEditingController2.clear();
                      textEditingController3.clear();
                      textEditingController4.clear();
                      textEditingController5.clear();
                      textEditingController6.clear();
                      textEditingController7.clear();
                      textEditingController8.clear();
                      textEditingController9.clear();
                      textEditingController10.clear();
                    });
                  }
                },
                child: Text('Add'),
              ),
              SizedBox(
                height: 20,
              ),
              buildTableDisplayDamages(),

              ElevatedButton(
                onPressed: _pickImagesDamages,
                child: Text('Select Damages & Repair Image'),
              ),
              SizedBox(height: 20),
              Column(
                children: [
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Wrap(
                        spacing: 8.0,
                        runSpacing: 8.0,
                        children: _imageFileDamages != null &&
                                _imageFileDamages!.isNotEmpty
                            ? _imageFileDamages!.map((XFile imageFile) {
                                int index =
                                    _imageFilesCleaning!.indexOf(imageFile);
                                return GestureDetector(
                                  onTap: () {
                                    _removeImageCleaning(index);
                                  },
                                  child: Stack(
                                    children: [
                                      Card(
                                        clipBehavior: Clip.antiAlias,
                                        child: Image.file(
                                          File(imageFile.path),
                                          height: 100,
                                          width: 100,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Positioned(
                                        top: 0,
                                        right: 0,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          padding: const EdgeInsets.all(4),
                                          child: const Icon(
                                            Icons.delete,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }).toList()
                            : [
                                const Center(
                                  child: Text(
                                    'No images selected',
                                  ),
                                ),
                              ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey,
                  padding: const EdgeInsets.all(10),
                ),
                onPressed: () async {
                  await postToAPIUsingMultiPart();
                  // if (containerNumbersGeneral.text.isEmpty) {
                  //   showToast("Enter Container Number");
                  // } else if (_selectedIso == "ISO/Size") {
                  //   showToast("Choose ISO/Size");
                  // } else if (grossWeightGeneral.text.isEmpty) {
                  //   showToast("Enter Gross Weight");
                  // } else if (tareWeightGeneral.text.isEmpty) {
                  //   showToast("Enter Tare Weight");
                  // } else if (manufactureDateGeneral.text.isEmpty) {
                  //   showToast("Enter Manufacture Date");
                  // } else if (_selectedAgent == "Agent/Liner/Cus/NVOCC") {
                  //   showToast("Choose Agent/Liner/Cus/NVOCC");
                  // } else if (_selectedMovement == "Movement Type") {
                  //   showToast("Choose Agent/Liner/Cus/NVOCC");
                  // } else if (vechicleNumberGeneral.text.isEmpty) {
                  //   showToast("Enter Vechicle Number");
                  // } else if (bookingNumberGeneral.text.isEmpty) {
                  //   showToast("Enter Booking Number");
                  // } else if (CSCGeneral.text.isEmpty) {
                  //   showToast("Enter CSC");
                  // } else if (_imageFiles!.length < 6) {
                  //   showToast("Upload min. 6 image in General Process");
                  // } else if (_selectedCleaningType == "Cleaning Type") {
                  //   showToast("Choose Cleaning Type");
                  // } else if (QTY.text.isEmpty) {
                  //   showToast("Enter QTY");
                  // } else if (_selectedAccount == "Account") {
                  //   showToast("Choose Account");
                  // } else if (ownerCharge.text.isEmpty) {
                  //   showToast("Enter Owner Charge");
                  // } else if (thirdpartyCharge.text.isEmpty) {
                  //   showToast("Enter Third Party Charges");
                  // } else if (_imageFilesCleaning!.length < 6) {
                  //   showToast("Upload min. 6 image in Cleaning");
                  // } else if (textEditingController1.text.isEmpty) {
                  //   showToast("Enter COMP CODE");
                  // } else if (textEditingController2.text.isEmpty) {
                  //   showToast("Enter DMG. CODE");
                  // } else if (textEditingController3.text.isEmpty) {
                  //   showToast("Enter REP. CODE");
                  // } else if (textEditingController4.text.isEmpty) {
                  //   showToast("Enter Location");
                  // } else if (textEditingController5.text.isEmpty) {
                  //   showToast("Enter Length");
                  // } else if (textEditingController6.text.isEmpty) {
                  //   showToast("Enter Width");
                  // } else if (textEditingController7.text.isEmpty) {
                  //   showToast("Enter QTY");
                  // } else if (textEditingController8.text.isEmpty) {
                  //   showToast("Enter ACC");
                  // } else if (textEditingController9.text.isEmpty) {
                  //   showToast("Enter MAN.HOUR");
                  // } else if (textEditingController10.text.isEmpty) {
                  //   showToast("Enter MATERIAL.PRICE");
                  // } else if (_imageFileDamages!.length < 6) {
                  //   showToast("Upload min. 6 image in Damages and Repair");
                  // } else {
                  //   postToAPI();
                  //   // DynamicFieldsDamages damageAndDamage = DynamicFieldsDamages(
                  //   //   textEditingController1.text as List<String>,
                  //   //   textEditingController2.text as List<String>,
                  //   //   textEditingController3.text as List<String>,
                  //   //   textEditingController4.text as List<String>,
                  //   //   textEditingController5.text as List<String>,
                  //   //   textEditingController6.text as List<String>,
                  //   //   textEditingController7.text as List<String>,
                  //   //   textEditingController8.text as List<String>,
                  //   //   textEditingController9.text as List<String>,
                  //   //   textEditingController10.text as List<String>,
                  //   // );

                  //   // DamagesAndCleaning damagesAndCleaning = DamagesAndCleaning(
                  //   //     compCode: textEditingController1.text,
                  //   //     dmgCode: textEditingController2.text,
                  //   //     repCode: textEditingController3.text,
                  //   //     location: textEditingController4.text,
                  //   //     length: textEditingController5.text,
                  //   //     width: textEditingController6.text,
                  //   //     quantity: textEditingController7.text,
                  //   //     acc: textEditingController8.text,
                  //   //     manHour: textEditingController9.text,
                  //   //     materialPrice: textEditingController10.text);

                  //   // SubmitData(
                  //   //   containerNumbersGeneral.text,
                  //   //   _selectedIso,
                  //   //   grossWeightGeneral.text,
                  //   //   tareWeightGeneral.text,
                  //   //   manufactureDateGeneral.text,
                  //   //   _selectedAgent,
                  //   //   _selectedMovement,
                  //   //   vechicleNumberGeneral.text,
                  //   //   bookingNumberGeneral.text,
                  //   //   CSCGeneral.text,
                  //   //   damageAndDamage,
                  //   //   damageAndCleaning,
                  //   // );
                  // // }
                  // // Navigator.push(
                  // //   context,
                  // //   MaterialPageRoute(builder: (context) => Done()
                  // //       // DisplayDataScreen(tableData: tableData),
                  // //       ),
                  // // );
                },
                child: const Text(
                  'Submit',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showToast(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black,
      textColor: Colors.white,
    );
  }

  Widget buildTableDisplay() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Cleaning Container Data',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: const [
              DataColumn(label: Text('CLEANING TYPE')),
              DataColumn(label: Text('QTY')),
              DataColumn(label: Text('ACCOUNT')),
              DataColumn(label: Text('OWNER CHARGE')),
              DataColumn(label: Text('THIRD PARTY CHRGE')),
              DataColumn(label: Text('REMOVE')),
            ],
            rows: _containerCleaningData.map((e) {
              return DataRow(cells: [
                DataCell(Text(e.type)),
                DataCell(Text(e.quantity.toString())),
                DataCell(Text(e.account.toString())),
                DataCell(Text(e.ownerCharge.toString())),
                DataCell(Text(e.thirdPartyCharges.toString())),
                DataCell(IconButton(
                  onPressed: () {
                    setState(() {
                      _containerCleaningData.remove(e);
                    });
                  },
                  icon: const Icon(Icons.close),
                ))
              ]);
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget buildTableDisplayDamages() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Damages & Repair Container Data',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: const [
              DataColumn(label: Text('COMP CODE')),
              DataColumn(label: Text('DMG. CODE')),
              DataColumn(label: Text('REP. CODE')),
              DataColumn(label: Text('LOCATION')),
              DataColumn(label: Text('LENGTH')),
              DataColumn(label: Text('WIDTH')),
              DataColumn(label: Text('QTY')),
              DataColumn(label: Text('ACC')),
              DataColumn(label: Text('MAN.HOUR')),
              DataColumn(label: Text('MATERIAL.PRICE')),
              DataColumn(label: Text('REMOVE')),
            ],
            rows: _damagesAndCleanings.map((data) {
              return DataRow(
                cells: [
                  DataCell(Text(data.compCode)),
                  DataCell(Text(data.dmgCode)),
                  DataCell(Text(data.repCode)),
                  DataCell(Text(data.location)),
                  DataCell(Text(data.length)),
                  DataCell(Text(data.width)),
                  DataCell(Text(data.quantity)),
                  DataCell(Text(data.acc)),
                  DataCell(Text(data.manHour)),
                  DataCell(Text(data.materialPrice)),
                  DataCell(IconButton(
                    onPressed: () {
                      setState(() {
                        _damagesAndCleanings.remove(data);
                      });
                    },
                    icon: const Icon(Icons.close),
                  ))
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

// using Multi part
  Future<void> postToAPIUsingMultiPart() async {
    final apiUrl = 'https://mcsa.dnarentalstudio.com/public/api/gateone';

    var request = http.MultipartRequest('POST', Uri.parse(apiUrl));

    List<Map<String, dynamic>> cleaningDataList = _containerCleaningData
        .map((data) => {
              "type": data.type,
              "quantity": data.quantity,
              "account": data.account,
              "ownercharge": data.ownerCharge,
              "third_party_charges": data.thirdPartyCharges,
            })
        .toList();

    List<Map<String, dynamic>> damagesAndCleaningsList = _damagesAndCleanings
        .map((data) => {
              "compcode": data.compCode,
              "dmgcode": data.dmgCode,
              "repcode": data.repCode,
              "location": data.location,
              "length": data.length,
              "width": data.width,
              "damage_quantity": data.quantity,
              "acc": data.acc,
              "manhour": data.manHour,
              "metalprice": data.materialPrice,
            })
        .toList();

    // Add text data to the request
    request.fields.addAll({
      "container_number": containerNumbersGeneral.text,
      "iso_size": _selectedIso,
      "gross_weight": grossWeightGeneral.text,
      "tare_weight": tareWeightGeneral.text,
      "manifacture_date": manufactureDateGeneral.text,
      "agent_liner": _selectedAgent,
      "movement_type": _selectedMovement,
      "vehicle_number": vechicleNumberGeneral.text,
      "booking_number": bookingNumberGeneral.text,
      "csc": CSCGeneral.text,
      "dynamicFieldsGeneralCleaning[cleaningType]":
          cleaningDataList.map((data) => data["type"]).join(','),
      "dynamicFieldsGeneralCleaning[quantity]":
          cleaningDataList.map((data) => data["quantity"].toString()).join(','),
      "dynamicFieldsGeneralCleaning[account]":
          cleaningDataList.map((data) => data["account"]).join(','),
      "dynamicFieldsGeneralCleaning[ownercharge]": cleaningDataList
          .map((data) => data["ownercharge"].toString())
          .join(','),
      "dynamicFieldsGeneralCleaning[third_party_charges]": cleaningDataList
          .map((data) => data["third_party_charges"].toString())
          .join(','),
      "dynamicFieldsDamages[compcode]":
          damagesAndCleaningsList.map((data) => data["compcode"]).join(','),
      "dynamicFieldsDamages[dmgcode]":
          damagesAndCleaningsList.map((data) => data["dmgcode"]).join(','),
      "dynamicFieldsDamages[repcode]":
          damagesAndCleaningsList.map((data) => data["repcode"]).join(','),
      "dynamicFieldsDamages[location]":
          damagesAndCleaningsList.map((data) => data["location"]).join(','),
      "dynamicFieldsDamages[length]":
          damagesAndCleaningsList.map((data) => data["length"]).join(','),
      "dynamicFieldsDamages[width]":
          damagesAndCleaningsList.map((data) => data["width"]).join(','),
      "dynamicFieldsDamages[damage_quantity]": damagesAndCleaningsList
          .map((data) => data["damage_quantity"])
          .join(','),
      "dynamicFieldsDamages[acc]":
          damagesAndCleaningsList.map((data) => data["acc"]).join(','),
      "dynamicFieldsDamages[manhour]":
          damagesAndCleaningsList.map((data) => data["manhour"]).join(','),
      "dynamicFieldsDamages[metalprice]":
          damagesAndCleaningsList.map((data) => data["metalprice"]).join(','),
    });

    // Add image files to the request
    if (_imageFilesCleaning != null && _imageFilesCleaning!.isNotEmpty) {
      for (var imageFile in _imageFilesCleaning!) {
        var stream = http.ByteStream(imageFile.readAsBytes().asStream());
        var length = await imageFile.length();

        var multipartFile = http.MultipartFile(
          'cleaning_images[]', // This should match the field name in your API
          stream,
          length,
          filename: 'image.jpg',
        );

        request.files.add(http.MultipartFile.fromBytes(
          'cleaning_images[]',
          await imageFile.readAsBytes(),
          filename: 'image.jpg',
        ));
      }
    }

    // Send the request
    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        // Handle success
        print('POST request successful');
        print('Response: ${await response.stream.bytesToString()}');
        showToast('POST request successful');

        final responseData = json.decode(await response.stream.bytesToString());
        final passResponse = response;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MyApp(yourResponseData: responseData),
          ),
        );
        // ... (handle navigation or other actions)
      } else {
        showToast('Something went wrong');
        // Handle errors
        print(
            'Failed to make POST request. Status code: ${response.statusCode}');
        print('Response: ${await response.stream.bytesToString()}');
      }
    } catch (e) {
      // Handle exceptions
      print('Exception during POST request: $e');
    }
  }

// normal api call for text
  Future<void> postToAPI() async {
    final apiUrl = 'https://mcsa.dnarentalstudio.com/public/api/gateone';

    List<Map<String, dynamic>> cleaningDataList = _containerCleaningData
        .map((data) => {
              "type": data.type,
              "quantity": data.quantity,
              "account": data.account,
              "ownercharge": data.ownerCharge,
              "third_party_charges": data.thirdPartyCharges,
            })
        .toList();

    List<Map<String, dynamic>> damagesAndCleaningsList = _damagesAndCleanings
        .map((data) => {
              "compcode": data.compCode,
              "dmgcode": data.dmgCode,
              "repcode": data.repCode,
              "location": data.location,
              "length": data.length,
              "width": data.width,
              "damage_quantity": data.quantity,
              "acc": data.acc,
              "manhour": data.manHour,
              "metalprice": data.materialPrice,
            })
        .toList();

    final requestBody = {
      "container_number": containerNumbersGeneral.text,
      "iso_size": _selectedIso,
      "gross_weight": grossWeightGeneral.text,
      "tare_weight": tareWeightGeneral.text,
      "manifacture_date": manufactureDateGeneral.text,
      "agent_liner": _selectedAgent,
      "movement_type": _selectedMovement,
      "vehicle_number": vechicleNumberGeneral.text,
      "booking_number": bookingNumberGeneral.text,
      "csc": CSCGeneral.text,
      "dynamicFieldsGeneralCleaning": {
        "cleaningType": cleaningDataList.map((data) => data["type"]).toList(),
        "quantity": cleaningDataList
            .map((data) => data["quantity"].toString())
            .toList(),
        "account": cleaningDataList.map((data) => data["account"]).toList(),
        "ownercharge": cleaningDataList
            .map((data) => data["ownercharge"].toString())
            .toList(),
        "third_party_charges": cleaningDataList
            .map((data) => data["third_party_charges"].toString())
            .toList(),
        "cleaning_images":
            _imageFilesCleaning != null && _imageFilesCleaning!.isNotEmpty
                ? _imageFilesCleaning!
                    .map((XFile imageFile) {
                      try {
                        List<int> imageBytes =
                            File(imageFile.path).readAsBytesSync();
                        String base64Image = base64Encode(imageBytes);
                        return base64Image;
                      } catch (e) {
                        print("Error encoding image: $e");
                        return null;
                      }
                    })
                    .where((encodedImage) => encodedImage != null)
                    .toList()
                : [],
      },
      "dynamicFieldsDamages": {
        "compcode":
            damagesAndCleaningsList.map((data) => data["compcode"]).toList(),
        "dmgcode":
            damagesAndCleaningsList.map((data) => data["dmgcode"]).toList(),
        "repcode":
            damagesAndCleaningsList.map((data) => data["repcode"]).toList(),
        "location":
            damagesAndCleaningsList.map((data) => data["location"]).toList(),
        "length":
            damagesAndCleaningsList.map((data) => data["length"]).toList(),
        "width": damagesAndCleaningsList.map((data) => data["width"]).toList(),
        "damage_quantity": damagesAndCleaningsList
            .map((data) => data["damage_quantity"])
            .toList(),
        "acc": damagesAndCleaningsList.map((data) => data["acc"]).toList(),
        "manhour":
            damagesAndCleaningsList.map((data) => data["manhour"]).toList(),
        "metalprice":
            damagesAndCleaningsList.map((data) => data["metalprice"]).toList(),
      },
    }; // Remove the extra set of curly braces

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        // Handle success
        print('POST request successful');
        print('Response: ${response.body}');
        showToast('POST request successful');
        final responseData = json.decode(response.body);
        final passResponse = response.body;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MyApp(yourResponseData: responseData),
          ),
        );
      } else {
        showToast('Something went wrong');
        // Handle errors
        print(
            'Failed to make POST request. Status code: ${response.statusCode}');
        print('Response: ${response.body}');
      }
    } catch (e) {
      // Handle exceptions
      print('Exception during POST request: $e');
    }
  }
}

class DisplayDataScreen extends StatelessWidget {
  final List<List<String>> tableData;

  const DisplayDataScreen({super.key, required this.tableData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Display Data')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: tableData.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(tableData[index].join(', ')),
            );
          },
        ),
      ),
    );
  }
}
