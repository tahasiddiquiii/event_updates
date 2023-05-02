import 'package:event_updates_tif/constants/global_variables.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final Color? color;
  const CustomButton({
    Key? key,
    required this.text,
    required this.onTap,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: GlobalVariables.secondaryColor,
        ),
        height: 60,
        width: 270,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(
              width: 35,
            ),
            Expanded(
              child: Center(
                child: Text(
                  text,
                  style: TextStyle(
                    color: color == null ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: GlobalVariables.thirdColor,
              ),
              height: 35,
              width: 35,
              child: const Icon(
                Icons.arrow_forward,
                color: GlobalVariables.backgroundColor,
              ),
            ),
            const SizedBox(
              width: 13,
            )
          ],
        ),
        // Other button style properties can be added here
      ),
    );
  }
}
