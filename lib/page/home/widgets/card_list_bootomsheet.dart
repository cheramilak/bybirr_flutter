import 'package:bybirr_flutter/models/kyc.dart';
import 'package:bybirr_flutter/page/home/widgets/card_widget.dart';
import 'package:bybirr_flutter/page/home/widgets/virification_dilaog.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class CardListBootomsheet extends StatefulWidget {
  final KYCModel? kycModel;
  const CardListBootomsheet({super.key, required this.kycModel});

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
          }),
          Expanded(
            //height: 200,
            child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: 5,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return CardWidget(
                  size: size,
                  colorScheme: colorScheme,
                  theme: theme,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
