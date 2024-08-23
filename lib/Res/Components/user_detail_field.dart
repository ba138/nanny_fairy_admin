import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nanny_fairy_admin/Res/Components/colors.dart';

class UserDetailField extends StatelessWidget {
  const UserDetailField({super.key, required this.title, required this.data});
  final String title;
  final String data;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.getFont(
            "Poppins",
            textStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: AppColor.textColor1,
            ),
          ),
        ),
        Container(
          height: 38,
          width: 192,
          decoration: BoxDecoration(
            color: Colors.transparent,
            border: Border.all(
              color: AppColor.borderColor,
            ),
            borderRadius: BorderRadius.circular(
              6,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Text(
              data,
              style: GoogleFonts.getFont(
                "Poppins",
                textStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColor.textColor1,
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
