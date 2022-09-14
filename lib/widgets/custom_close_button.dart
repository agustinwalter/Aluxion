import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomCloseButton extends StatelessWidget {
  const CustomCloseButton({super.key, this.ligthMode = false});

  final bool ligthMode;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(
        26,
        MediaQuery.of(context).padding.top + 29,
        26,
        0,
      ),
      child: SvgPicture.asset(
        'assets/svg/close.svg',
        width: 37,
        color: ligthMode ? Colors.white : const Color(0xFF030303),
      ),
    );
  }
}
