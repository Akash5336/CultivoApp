import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CropInput extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  const CropInput({super.key, required this.title, required this.controller});

  @override
  Widget build(BuildContext context) {
    final pageWidth = MediaQuery.of(context).size.width;
    final pageHeight = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 18,
            color: Theme.of(context).colorScheme.onSecondaryContainer,
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: pageHeight * 0.011),
          height: pageHeight * 0.044,
          width: pageWidth * 0.311,
          child: TextFormField(
            controller: controller,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            style: GoogleFonts.inter(
              fontSize: 18,
              // color: Colors.white,
              color: Theme.of(context).colorScheme.onSecondaryContainer,
            ),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                // vertical: pageHeight * 0.001,
                horizontal: pageWidth * 0.02,
              ),
              filled: true,
              // fillColor: const Color(0xff84AEA4),
              fillColor: Theme.of(context).colorScheme.primaryContainer,
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  // color: Color(0xff84AEA4),
                  color: Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  // color: Color(0xff84AEA4),
                  color: Theme.of(context).colorScheme.onTertiaryContainer,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
