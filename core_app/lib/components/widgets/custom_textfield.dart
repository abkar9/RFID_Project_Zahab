import 'package:flutter/material.dart';
import 'package:rfid_c72_plugin_example/components/colors_theme.dart';
import 'package:rfid_c72_plugin_example/components/widgets/custom_text.dart';
import 'package:rfid_c72_plugin_example/provider/model_provider.dart';
import 'package:rfid_c72_plugin_example/view/info_add_tag.dart';
import 'package:provider/provider.dart';
import '../custom_sizes.dart';

TextEditingController _controller = TextEditingController();
Widget customTextField(BuildContext context,
    {String? title,
    TextAlign? textAlign = TextAlign.start,
    Color? color,
    double? size,
    var data}) {
  return Column(
    children: [
      Container(
        child: customText(
            text: title,
            textColor: color,
            textAlign: textAlign,
            fontSize: size),
        width: CustomSizes.width! / 2,
      ),
      SizedBox(
        height: 5,
      ),
      Container(
        width: CustomSizes.width! / 1.5,
        child: SizedBox(
          height: CustomSizes.height! / 15,
          child: TextField(
            controller: _controller,
            keyboardType: TextInputType.phone,
            textAlign: TextAlign.end,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(width: 1),
              ),
              focusColor: ColorThemeRFID.brown,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: ColorThemeRFID.brown, width: 2),
              ),
            ),
          ),
        ),
      ),
      SizedBox(
        height: 20,
      ),
      ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(ColorThemeRFID.brown),
          ),
          onPressed: () async {
            if (_controller.text.isNotEmpty) {
              data!.docs.forEach((element) {
                if (element["idNumber"] == _controller.text) {
                  Provider.of<ProviderModel>(context, listen: false)
                      .changevalueFromElement(element: element);

                  Navigator.of(context).push(PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        InfoAddTag(),
                  ));
                  _controller.clear();
                } else if (_controller.text != element["idNumber"]) {}
              });
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  shape: BeveledRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  backgroundColor: ColorThemeRFID.brown,
                  content: Center(child: Text('ادخل رقم الهوية')),
                  duration: Duration(seconds: 2),
                ),
              );
            }
          },
          child: Text("موافق"))
    ],
  );
}
