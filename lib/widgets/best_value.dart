import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class BestCrop extends StatefulWidget {
  const BestCrop({super.key});

  @override
  State<BestCrop> createState() => _BestCropState();
}

class _BestCropState extends State<BestCrop> {
  final TextEditingController _cropController = TextEditingController();
  String N = "Nitrogen: ";
  String P = "Phosphorus: ";
  String K = "Pottasium: ";
  String temp = "Temperature: ";
  String hum = "Humidity: ";
  String rain = "Rainfall: ";
  String pH = "pH: ";
  String result = "Result";

  @override
  void dispose() {
    _cropController.dispose();
    super.dispose();
  }

  bool _isLoading = false;

  Future<String> _getResult(String data) async {
    final res = await http.post(
      // Uri.parse('http://192.168.137.1:8000/manual.html/bestcrop'),
      // Uri.parse('http://192.168.1.14:8000/manual.html/bestcrop'),
      Uri.parse('https://cc10-59-92-46-175.in.ngrok.io/manual.html/bestcrop'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'crop': data,
      }),
    );
    if (res.statusCode == 200) {
      setState(() {
        N = "Nitrogen: ${jsonDecode(res.body)["N"]}";
        P = "Phosporus: ${jsonDecode(res.body)["P"]}";
        K = "Potassium: ${jsonDecode(res.body)["K"]}";
        temp = "Temperature: ${jsonDecode(res.body)["Temperature"]}";
        pH = "pH: ${jsonDecode(res.body)["pH"]}";
        hum = "Humidity: ${jsonDecode(res.body)["Humidity"]}";
        rain = "Rainfall: ${jsonDecode(res.body)["Rainfall"]}";
        _isLoading = false;
      });
      return jsonDecode(res.body)["N"].toString();
    } else {
      return "Error Fetching Data";
    }
  }

  @override
  Widget build(BuildContext context) {
    final pageWidth = MediaQuery.of(context).size.width;
    final pageHeight = MediaQuery.of(context).size.height;
    String data = "";
    void getData() {
      data = _cropController.text.toString().toLowerCase();
    }

    return SafeArea(
      child: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                // color: Color(0xff123A32),
                color: Theme.of(context).colorScheme.secondaryContainer,
              ),
            )
          : Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: pageHeight * 0.015,
                    left: pageWidth * 0.178,
                    right: pageWidth * 0.178,
                  ),
                  child: Text(
                    "Best Crop Values",
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
                        Text(
                          "Enter Crop:",
                          style: GoogleFonts.inter(
                            fontSize: 20,
                            color: Theme.of(context)
                                .colorScheme
                                .onSecondaryContainer,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: pageHeight * 0.011),
                          child: SizedBox(
                            height: pageHeight * 0.05125,
                            width: pageWidth * 0.7,
                            child: TextFormField(
                              controller: _cropController,
                              style: GoogleFonts.inder(
                                fontSize: 20,
                                // color: Colors.white,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSecondaryContainer,
                              ),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                  vertical: pageHeight * 0.005,
                                  horizontal: pageWidth * 0.02,
                                ),
                                filled: true,
                                // fillColor: const Color(0xff84AEA4),
                                fillColor: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    // color: Color(0xff84AEA4),
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onPrimaryContainer,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    // color: Color(0xff84AEA4),
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onTertiaryContainer,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: pageHeight * 0.03625,
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
                                if (_cropController.text.isEmpty) {
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
                                      backgroundColor: const Color(0xff123A32),
                                      content: Text(
                                        "Enter the crop to get the values.",
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
                                    _getResult(data);
                                    result = _cropController.text
                                        .toString()
                                        .toUpperCase();
                                    _cropController.clear();
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
                          margin: EdgeInsets.only(top: pageHeight * 0.075),
                          width: pageWidth * 0.705,
                          height: pageHeight * 0.448,
                          padding: EdgeInsets.symmetric(
                            horizontal: pageWidth * 0.075,
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
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  bottom: pageHeight * 0.005,
                                ),
                                child: Center(
                                  child: Text(
                                    result,
                                    style: GoogleFonts.inter(
                                      fontSize: 28,
                                      // color: const Color(0xff123A32),
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onPrimary,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              ResultText(text: N),
                              ResultText(text: P),
                              ResultText(text: K),
                              ResultText(text: temp),
                              ResultText(text: hum),
                              ResultText(text: rain),
                              ResultText(text: pH),
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

class ResultText extends StatelessWidget {
  const ResultText({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    final pageHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.only(
        top: pageHeight * 0.007,
      ),
      child: Text(
        text,
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
