import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({
    super.key,
    required this.size,
    required this.colorScheme,
    required this.theme,
  });

  final Size size;
  final ColorScheme colorScheme;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.2,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: colorScheme.surfaceBright,
        border: Border.all(width: 0.5, color: gray),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Row(
            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('\$2,433', style: theme.textTheme.headlineLarge),
              15.width,
              Icon(Icons.visibility).paddingRight(10),
            ],
          ),
          Expanded(
            child: SizedBox(
              child: Align(
                alignment: AlignmentGeometry.centerRight,
                child: Icon(Icons.wifi),
              ),
            ),
          ),
          Text('1038 3498 34764 4743', style: theme.textTheme.bodyLarge),
          10.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('23/25', style: theme.textTheme.bodySmall),
              Icon(Icons.card_membership).paddingRight(10),
            ],
          ),
        ],
      ),
    );
  }
}
