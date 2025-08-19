import 'package:bybirr_flutter/page/kyc/kyc_provider.dart';
import 'package:bybirr_flutter/utils/style.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class IdForm extends StatefulWidget {
  const IdForm({super.key});

  @override
  State<IdForm> createState() => _IdFormState();
}

class _IdFormState extends State<IdForm> {
  TextEditingController idNumberControoler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    KycProvider kycProvider = Provider.of<KycProvider>(context);

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          20.height,
          Text(
            'Tell us about your self more',
            style: theme.textTheme.headlineLarge,
          ),
          30.height,
          Row(
            children: [
              Expanded(
                child: DottedBorder(
                  options: RectDottedBorderOptions(
                    color: gray.withOpacity(0.5),
                    strokeWidth: 1,
                    dashPattern: [6, 3], // 5px dash, 3px gap
                  ),
                  child: Container(
                    height: 100,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: colorScheme.surface,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Front Id',
                      style: theme.textTheme.displaySmall,
                    ),
                  ),
                ),
              ),
              15.width,
              Expanded(
                child: DottedBorder(
                  options: RectDottedBorderOptions(
                    color: gray.withOpacity(0.5),
                    strokeWidth: 1,
                    dashPattern: [6, 3], // 5px dash, 3px gap
                  ),
                  child: Container(
                    height: 100,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: colorScheme.surface,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    alignment: Alignment.center,
                    child: Text('Back Id', style: theme.textTheme.displaySmall),
                  ),
                ),
              ),
            ],
          ),
          15.height,
          DottedBorder(
            options: RectDottedBorderOptions(
              color: gray.withOpacity(0.5),
              strokeWidth: 1,
              dashPattern: [6, 3], // 5px dash, 3px gap
            ),
            child: Container(
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                color: colorScheme.surface,
                borderRadius: BorderRadius.circular(5),
              ),
              alignment: Alignment.center,
              child: Text('Selfi', style: theme.textTheme.displaySmall),
            ),
          ).paddingAll(5),
          15.height,
          textFormAuth(
            controller: idNumberControoler,
            labelText: 'Id',
            hintText: 'Id number',
            icon: Icons.perm_identity,
          ),
          10.height,
          Expanded(child: SizedBox()),
          Padding(
            padding: const EdgeInsets.all(10),
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: 1,
              child: false
                  ? LoadingAnimationWidget.staggeredDotsWave(
                      color: greenColor,
                      size: 30,
                    )
                  : ElevatedButton(
                      onPressed: false
                          ? null
                          : () async {
                              kycProvider.nextPage();
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.colorScheme.primary,
                        foregroundColor: theme.colorScheme.onPrimary,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 60,
                          vertical: 18,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Text(
                        'Submit',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
