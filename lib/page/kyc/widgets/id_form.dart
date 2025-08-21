import 'package:bybirr_flutter/core/exception_message.dart';
import 'package:bybirr_flutter/models/kyc.dart';
import 'package:bybirr_flutter/page/auth/providers/auth_provider.dart';
import 'package:bybirr_flutter/page/kyc/kyc_provider.dart';
import 'package:bybirr_flutter/page/kyc/widgets/kyc_conformation.dart';
import 'package:bybirr_flutter/utils/style.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class IdForm extends StatefulWidget {
  const IdForm({super.key});

  @override
  State<IdForm> createState() => _IdFormState();
}

class _IdFormState extends State<IdForm> {
  @override
  Widget build(BuildContext context) {
    KycProvider kycProvider = Provider.of<KycProvider>(context);
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
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
                  child:
                      Container(
                        height: 100,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: colorScheme.surface,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        alignment: Alignment.center,
                        child: kycProvider.getFront != null
                            ? Image.file(
                                kycProvider.getFront!,
                                fit: BoxFit.cover,
                              )
                            : Text(
                                'Front Id',
                                style: theme.textTheme.displaySmall,
                              ),
                      ).onTap(() {
                        kycProvider.pickFront(ImageSource.gallery);
                      }),
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
                  child:
                      Container(
                        height: 100,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: colorScheme.surface,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        alignment: Alignment.center,
                        child: kycProvider.getBack != null
                            ? Image.file(
                                kycProvider.getBack!,
                                fit: BoxFit.cover,
                              )
                            : Text(
                                'Back Id',
                                style: theme.textTheme.displaySmall,
                              ),
                      ).onTap(() {
                        kycProvider.pickBack(ImageSource.gallery);
                      }),
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
                  child: kycProvider.getSelfie != null
                      ? Image.file(kycProvider.getSelfie!, fit: BoxFit.cover)
                      : Text('Selfi', style: theme.textTheme.displaySmall),
                ),
              )
              .onTap(() {
                kycProvider.takeSelfie();
              })
              .paddingAll(5),
          15.height,
          textFormAuth(
            controller: kycProvider.idNumberControoler,
            labelText: 'Id',
            hintText: 'Id number',
            icon: Icons.perm_identity,
          ),
          10.height,
          Expanded(child: SizedBox()),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  kycProvider.backPage();
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 8,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: Text(
                  'Back',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.2,
                  ),
                ),
              ),

              ElevatedButton(
                onPressed: () async {
                  if (kycProvider.getFront == null) {
                    return showErrorMessage(
                      null,
                      'Front side of your id image is required',
                    );
                  }
                  if (kycProvider.getBack == null) {
                    return showErrorMessage(
                      null,
                      'Back side of your id image is required',
                    );
                  }
                  if (kycProvider.getSelfie == null) {
                    return showErrorMessage(
                      null,
                      'Your selfie image is required',
                    );
                  }
                  if (kycProvider.idNumberControoler.text.isEmpty) {
                    return showErrorMessage(null, 'Id number is required');
                  }
                  KYCModel? kyc = await kycProvider.submitForm();
                  if (kyc != null) {
                    authProvider.setKyc = kyc;
                    finish(context);
                    return showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (context) {
                        return KycConformationDialog();
                      },
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                  foregroundColor: theme.colorScheme.onPrimary,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 8,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: kycProvider.getIsLoading
                    ? LoadingAnimationWidget.staggeredDotsWave(
                        color: theme.colorScheme.onPrimary,
                        size: 25,
                      )
                    : Text(
                        'Submit',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.2,
                        ),
                      ),
              ),
            ],
          ),
          10.height,
        ],
      ),
    );
  }
}
