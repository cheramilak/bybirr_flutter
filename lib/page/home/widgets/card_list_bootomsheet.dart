import 'package:bybirr_flutter/models/kyc.dart';
import 'package:bybirr_flutter/models/virtual_card_model.dart';
import 'package:bybirr_flutter/page/auth/providers/auth_provider.dart';
import 'package:bybirr_flutter/page/card/order_card_screen.dart';
import 'package:bybirr_flutter/page/card/providers/card_provider.dart';
import 'package:bybirr_flutter/page/home/widgets/card_widget.dart';
import 'package:bybirr_flutter/page/home/widgets/virification_dilaog.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class CardListBootomsheet extends StatefulWidget {
  final KYCModel? kycModel;
  final List<VirtualCardModel> cardList;
  const CardListBootomsheet({
    super.key,
    required this.kycModel,
    required this.cardList,
  });

  @override
  State<CardListBootomsheet> createState() => _CardListBootomsheetState();
}

class _CardListBootomsheetState extends State<CardListBootomsheet> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.all(16),
      height: MediaQuery.of(context).size.height * 0.6,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
            decoration: BoxDecoration(
              color: theme.colorScheme.primary,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Text(
              'Create',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.2,
                color: theme.colorScheme.onPrimary,
              ),
            ),
          ).onTap(() {
            Navigator.pop(context);
            if (widget.kycModel == null) {
              return showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return VirificationStartDilaog();
                },
              );
            }
            if (widget.kycModel!.status == 'Pending') {
              return showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return VirificationPendingDilaog();
                },
              );
            }
            if (widget.kycModel!.status == 'Failed') {
              return showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) {
                  return VirificationFailDilaog();
                },
              );
            }
            if (widget.kycModel!.status == 'Approved') {
              OrderCardScreen().launch(context);
            }
          }),
          Expanded(
            //height: 200,
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: widget.cardList.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return CardListWidget(
                  size: size,
                  colorScheme: colorScheme,
                  theme: theme,
                  cardModel: widget.cardList[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
