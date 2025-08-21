import 'package:bybirr_flutter/models/virtual_card_model.dart';
import 'package:bybirr_flutter/page/card/providers/card_provider.dart';
import 'package:bybirr_flutter/utils/util.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({
    super.key,
    required this.size,
    required this.colorScheme,
    required this.theme,
    required this.cardModel,
  });

  final Size size;
  final ColorScheme colorScheme;
  final ThemeData theme;
  final VirtualCardModel cardModel;

  @override
  Widget build(BuildContext context) {
    CardProvider cardProvider = Provider.of<CardProvider>(context);
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
              Text(
                cardProvider.isVissableBalance
                    ? '\$${cardModel.balance}'
                    : '\$*****',
                style: theme.textTheme.headlineLarge,
              ),
              15.width,
              Icon(
                    cardProvider.isVissableBalance
                        ? Icons.visibility
                        : Icons.visibility_off,
                  )
                  .onTap(() {
                    cardProvider.toogleBalanceVissable();
                  })
                  .paddingRight(10),
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
          Text(
            maskCardNumber(cardModel.cardNumber),
            style: theme.textTheme.bodyLarge,
          ),
          10.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(cardModel.expirationDate, style: theme.textTheme.bodySmall),
              Icon(Icons.card_membership).paddingRight(10),
            ],
          ),
        ],
      ),
    );
  }
}

class CardListWidget extends StatelessWidget {
  const CardListWidget({
    super.key,
    required this.size,
    required this.colorScheme,
    required this.theme,
    required this.cardModel,
  });

  final Size size;
  final ColorScheme colorScheme;
  final ThemeData theme;
  final VirtualCardModel cardModel;

  @override
  Widget build(BuildContext context) {
    CardProvider cardProvider = Provider.of<CardProvider>(context);
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('\$*****', style: theme.textTheme.headlineLarge),
          SizedBox(
            child: Align(
              alignment: AlignmentGeometry.centerRight,
              child: Icon(Icons.wifi),
            ),
          ),
          Text(
            maskCardNumber(cardModel.cardNumber),
            style: theme.textTheme.bodyLarge,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(cardModel.expirationDate, style: theme.textTheme.bodySmall),
              Icon(Icons.card_membership).paddingRight(10),
            ],
          ),
        ],
      ),
    );
  }
}

class ShimmerCardWidget extends StatelessWidget {
  const ShimmerCardWidget({
    super.key,
    required this.size,
    required this.colorScheme,
  });

  final Size size;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        height: size.height * 0.2,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: colorScheme.surfaceBright,
          border: Border.all(width: 0.5, color: Colors.grey.shade400),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Amount + Icon row
            Row(
              children: [
                Container(
                  height: 24,
                  width: 80,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(width: 15),
                Container(
                  height: 24,
                  width: 24,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ],
            ),

            const Spacer(),

            // Card number
            Container(
              height: 18,
              width: 200,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            const SizedBox(height: 10),

            // Expiry + Icon row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 16,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
