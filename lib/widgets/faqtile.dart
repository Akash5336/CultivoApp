import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FAQTile extends StatefulWidget {
  final String question;
  final String ans;
  const FAQTile({
    super.key,
    required this.question,
    required this.ans,
  });

  @override
  State<FAQTile> createState() => _FAQTileState();
}

class _FAQTileState extends State<FAQTile> {
  bool _tileExpanded = false;
  _tileChanged(bool value) {
    setState(() {
      _tileExpanded = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final pageWidth = MediaQuery.of(context).size.width;
    final pageHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.only(
        left: pageWidth * 0.061,
        right: pageWidth * 0.061,
        bottom: pageHeight * 0.025,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(14),
        child: ExpansionTile(
          title: Text(
            widget.question,
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: const Color(0xff123A32),
            ),
          ),
          backgroundColor: const Color(0xffA9DBCF),
          collapsedBackgroundColor:
              Theme.of(context).colorScheme.primaryContainer,
          // collapsedBackgroundColor: const Color(0xff65998D),

          trailing: !_tileExpanded
              ? Image.asset("assets/arrow_icon_down.png")
              : Image.asset("assets/arrow_icon_up.png"),
          onExpansionChanged: (bool value) {
            _tileChanged(value);
          },
          children: [
            Padding(
              padding: EdgeInsets.only(
                left: pageWidth * 0.04,
                bottom: pageHeight * 0.02,
                right: pageWidth * 0.04,
              ),
              child: Text(
                widget.ans,
                style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xff1F5B51)),
                textAlign: TextAlign.justify,
              ),
            )
          ],
        ),
      ),
    );
  }
}
