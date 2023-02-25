import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import 'crop_input.dart';

class PredictionScreen extends StatefulWidget {
  const PredictionScreen({super.key});

  @override
  State<PredictionScreen> createState() => _PredictionScreenState();
}

@override
class _PredictionScreenState extends State<PredictionScreen> {
  final TextEditingController _nController = TextEditingController();
  final TextEditingController _pController = TextEditingController();
  final TextEditingController _kController = TextEditingController();
  final TextEditingController _tempController = TextEditingController();
  final TextEditingController _phController = TextEditingController();
  final TextEditingController _humController = TextEditingController();
  final TextEditingController _rainController = TextEditingController();
  late List formData = [
    {'title': 'Nitrogen:', 'controller': _nController},
    {'title': 'Phosphorus:', 'controller': _pController},
    {'title': 'Potassium:', 'controller': _kController},
    {'title': 'Temperature:', 'controller': _tempController},
    {'title': 'pH:', 'controller': _phController},
    {'title': 'Humidity:', 'controller': _humController},
    {'title': 'Rainfall:', 'controller': _rainController}
  ];
  var passData = [];

  bool _isLoading = false;
  String pred1 = "Please give values";
  String pred2 = "to get the desired";
  String pred3 = "Crop Prediction!!";
  @override
  void dispose() {
    _nController.dispose();
    _pController.dispose();
    _kController.dispose();
    _tempController.dispose();
    _phController.dispose();
    _humController.dispose();
    _rainController.dispose();
    super.dispose();
  }

  void _clearData() {
    _nController.clear();
    _pController.clear();
    _kController.clear();
    _tempController.clear();
    _phController.clear();
    _humController.clear();
    _rainController.clear();
  }

  Future<String> _getResult(List data) async {
    final res = await http.post(
      // Uri.parse('http://192.168.137.1:8000/manual.html/test'),
      // Uri.parse('http://192.168.1.14:8000/manual.html/test'),
      Uri.parse('https://cc10-59-92-46-175.in.ngrok.io/manual.html/test'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, List>{
        'params': data,
      }),
    );
    if (res.statusCode == 200) {
      setState(() {
        pred1 = jsonDecode(res.body)["result"][0];
        pred2 = jsonDecode(res.body)["result"][1];
        pred3 = jsonDecode(res.body)["result"][2];
        _isLoading = false;
      });
      return jsonDecode(res.body)["result"][0];
    } else {
      return "Error Fetching Data";
    }
  }

  @override
  Widget build(BuildContext context) {
    final pageWidth = MediaQuery.of(context).size.width;
    final pageHeight = MediaQuery.of(context).size.height;

    var passData = [];
    void getData() {
      var N = double.parse(_nController.text);
      var P = double.parse(_pController.text);
      var K = double.parse(_kController.text);
      var pH = double.parse(_phController.text);
      var temp = double.parse(_tempController.text);
      var hum = double.parse(_humController.text);
      var rain = double.parse(_rainController.text);
      passData.add(N);
      passData.add(P);
      passData.add(K);
      passData.add(temp);
      passData.add(hum);
      passData.add(pH);
      passData.add(rain);
    }

    return _isLoading
        ? Center(
            child: CircularProgressIndicator(
              // color: Color(0xff123A32),
              color: Theme.of(context).colorScheme.secondaryContainer,
            ),
          )
        : SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: pageHeight * 0.015,
                    left: pageWidth * 0.178,
                    right: pageWidth * 0.178,
                  ),
                  child: Text(
                    "Crop Prediction",
                    style: GoogleFonts.inter(
                      fontSize: 30,
                      // color: const Color(0xff123A32),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: pageHeight * 0.008,
                    left: pageWidth * 0.097,
                    right: pageWidth * 0.097,
                  ),
                  child: Container(
                    height: pageHeight * 0.78,
                    width: pageWidth * 0.81,
                    padding: EdgeInsets.only(
                        top: pageHeight * 0.04, left: pageWidth * 0.05),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      // color: const Color(0xff65998D),
                      color: Theme.of(context).colorScheme.secondaryContainer,
                      boxShadow: [
                        BoxShadow(
                          offset: const Offset(0, 4),
                          blurRadius: 4,
                          spreadRadius: 2,
                          color: Colors.black.withOpacity(0.25),
                        )
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: pageHeight * 0.24,
                          width: pageWidth * 0.805,
                          child: GridView.builder(
                            itemCount: formData.length - 1,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: pageWidth *
                                  0.311 /
                                  (pageHeight * 0.025 + pageHeight * 0.038),
                            ),
                            itemBuilder: (context, index) {
                              return CropInput(
                                title: formData[index]['title'],
                                controller: formData[index]['controller'],
                              );
                            },
                          ),
                        ),
                        Center(
                            child: CropInput(
                          title: formData[formData.length - 1]["title"],
                          controller: formData[formData.length - 1]
                              ["controller"],
                        )),
                        Padding(
                          padding: EdgeInsets.only(
                            top: pageHeight * 0.044,
                            left: pageWidth * 0.061,
                          ),
                          child: SizedBox(
                            height: pageHeight * 0.0575,
                            width: pageWidth * 0.580,
                            child: ElevatedButton(
                              // style: ElevatedButton.styleFrom(
                              //   shape: RoundedRectangleBorder(
                              //     borderRadius: BorderRadius.circular(9),
                              //   ),
                              //   backgroundColor: const Color(0xff133B33),
                              // ),
                              onPressed: () {
                                if (_nController.text.isEmpty ||
                                    _pController.text.isEmpty ||
                                    _kController.text.isEmpty ||
                                    _tempController.text.isEmpty ||
                                    _phController.text.isEmpty ||
                                    _humController.text.isEmpty ||
                                    _rainController.text.isEmpty) {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: Text(
                                        "Input Notice!",
                                        style: GoogleFonts.inter(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 20,
                                          color: const Color(0xff65998D),
                                        ),
                                      ),
                                      backgroundColor: const Color(0xff133B33),
                                      content: Text(
                                        "Enter the all the fields to get a crop prediction.",
                                        style: GoogleFonts.inter(
                                          color: const Color(0xff84AEA4),
                                          fontWeight: FontWeight.w500,
                                          fontSize: 17,
                                        ),
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text(
                                            "Understood",
                                            style: GoogleFonts.inter(
                                              fontSize: 14,
                                              color: const Color(0xffF1FAF8),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                } else {
                                  setState(() {
                                    _isLoading = true;
                                    getData();
                                    _getResult(passData);
                                    _clearData();
                                  });
                                }
                              },
                              child: Text(
                                "Submit",
                                style: TextStyle(
                                  fontSize: pageWidth * 0.055,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: pageWidth * 0.705,
                          height: pageHeight * 0.265,
                          margin: EdgeInsets.only(top: pageHeight * 0.043),
                          padding: EdgeInsets.symmetric(
                            horizontal: pageHeight * 0.03,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            // color: const Color(0xffB9C6C3).withOpacity(0.55),
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.7),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: (pred1 == "Please give values")
                                ? CrossAxisAlignment.center
                                : CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Text(
                                  "Result",
                                  style: GoogleFonts.inter(
                                    fontSize: 28,
                                    // color: const Color(0xff123A32),
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              ResultContent(pred: pred1),
                              ResultContent(pred: pred2),
                              ResultContent(pred: pred3),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
  }
}

class ResultContent extends StatelessWidget {
  const ResultContent({
    super.key,
    required this.pred,
  });

  final String pred;

  @override
  Widget build(BuildContext context) {
    final pageHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.only(
        top: pageHeight * 0.01,
      ),
      child: Text(
        pred,
        textAlign: TextAlign.left,
        style: GoogleFonts.inter(
          fontSize: 20,
          // color: const Color(0xff123A32),
          color: Theme.of(context).colorScheme.onPrimary,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
