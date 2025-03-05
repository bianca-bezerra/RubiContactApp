import 'package:flutter/widgets.dart';
import 'package:google_maps/text_styles.dart';

class FieldBox extends StatelessWidget {
  final String title;
  final Widget inputWidget;
  const FieldBox({super.key, required this.title, required this.inputWidget});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyles.bodyLarge,
          ),
          const SizedBox(height: 4.0),
          inputWidget,
          const SizedBox(height: 10.0)
        ],
      ),
    );
  }
}
