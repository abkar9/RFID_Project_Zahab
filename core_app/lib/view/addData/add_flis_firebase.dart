import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:flutter/services.dart' show SystemUiOverlayStyle, rootBundle;
import 'package:csv/csv.dart';
import 'package:rfid_c72_plugin_example/components/colors_theme.dart';
import 'package:rfid_c72_plugin_example/components/custom_sizes.dart';
import 'package:rfid_c72_plugin_example/components/widgets/castom_appbar.dart';
import 'package:rfid_c72_plugin_example/components/widgets/custom_card_personal_info.dart';
import 'package:rfid_c72_plugin_example/components/widgets/custom_show.dart';
import 'package:rfid_c72_plugin_example/components/widgets/show_bottom_sheet.dart';
import 'package:rfid_c72_plugin_example/model/firebase/flirebase_get.dart';

class bulkUpload extends StatefulWidget {
  const bulkUpload({Key? key}) : super(key: key);

  @override
  State<bulkUpload> createState() => _bulkUploadState();
}

class _bulkUploadState extends State<bulkUpload> {
  List<List<dynamic>> _data = [];
  String? filePath;
  @override
  void initState() {
    super.initState();
    FirebaseMethods().initAndGetData;
  }
  // This function is triggered when the  button is pressed

  @override
  Widget build(BuildContext context) {
    List existe = [];
    return Scaffold(
        appBar: backAppBar(title: "رفع الملف ", context: context),
        floatingActionButton: Container(
          width: CustomSizes.width! / 1.1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              FloatingActionButton(
                  child: Text(_data.length.toString()),
                  backgroundColor: ColorThemeRFID.brown,
                  onPressed: () {}),
              Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                FloatingActionButton(
                    child: Icon(Icons.note_add),
                    backgroundColor: ColorThemeRFID.brown,
                    onPressed: () {
                      _pickFile();
                    }),
                SizedBox(height: 20),
                FloatingActionButton(
                    child: Icon(Icons.publish_outlined),
                    backgroundColor: ColorThemeRFID.brown,
                    onPressed: () async {
                      if (_data.isNotEmpty) {
                        customShowDialog(
                            context: context,
                            textTitle: "رفع البيانات",
                            textContent: "هل انت متأكد من رفع البيانات",
                            textButton: "موافق",
                            onPressed: () async {
                              _data.forEach((element) async {
                                await FirebaseMethods().addUser(
                                    name: element[3].toString(),
                                    address: element[16].toString(),
                                    phoneNumber: element[4].toString(),
                                    almajlis: element[0].toString(),
                                    idNumber: element[5].toString(),
                                    bookingNumber: element[6].toString(),
                                    nationality: element[1].toString(),
                                    typeOfSex: element[2].toString(),
                                    monaCamp: element[7].toString(),
                                    almajlisMona: element[8].toString(),
                                    mnamMona: element[9].toString(),
                                    arafaCamp: element[13].toString(),
                                    almajlisarafa: element[14].toString(),
                                    tag1: '',
                                    tag2: '',
                                    tag3: '',
                                    mnamarafaa: element[15].toString());
                              });

                              Navigator.pop(context);
                            });
                      } else {
                        showBottom(context, text: "يجب اختيار ملف");
                      }
                    }),
              ]),
            ],
          ),
        ),
        body: ListView(
          children: [
            for (var ele in _data.skip(1))
              ListView.builder(
                controller: ScrollController(keepScrollOffset: false),
                itemCount: 1,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemBuilder: (_, index) {
                  existe.add(ele[14]);
                  existe.add(ele[15]);
                  existe.add(ele[16]);
                  return customCardPersonalInfo(
                    context,
                    name: ele[3].toString(),
                    bookingNumber: ele[6].toString(),
                    idNumber: ele[5].toString(),
                    nationality: ele[1].toString(),
                    phoneNumber: ele[4].toString(),
                  );
                },
              ),
          ],
        ));
  }

  void _pickFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    // if no file is picked
    if (result == null) return;
    // we will log the name, size and path of the
    // first picked file (if multiple are selected)
    filePath = result.files.first.path!;

    final input = File(filePath!).openRead();
    final fields = await input
        .transform(utf8.decoder)
        .transform(const CsvToListConverter())
        .toList();
    if (fields.isNotEmpty) {
      setState(() {
        _data = fields;
      });
    }
  }
}
