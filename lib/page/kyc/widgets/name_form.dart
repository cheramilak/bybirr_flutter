import 'package:bybirr_flutter/core/exception_message.dart';
import 'package:bybirr_flutter/page/kyc/kyc_provider.dart';
import 'package:bybirr_flutter/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class NameForm extends StatefulWidget {
  const NameForm({super.key});

  @override
  State<NameForm> createState() => _NameFormState();
}

class _NameFormState extends State<NameForm> {
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
          Text('Identity verfication', style: theme.textTheme.titleLarge),
          30.height,
          textFormAuth(
            controller: kycProvider.fNameControoler,
            labelText: 'Name',
            hintText: 'Enter first name',
            icon: Icons.person,
          ),
          textFormAuth(
            controller: kycProvider.lNameControoler,
            labelText: 'Name',
            hintText: 'Enter your last name',
            icon: Icons.person,
          ),
          textFormAuth(
            controller: kycProvider.phoneController,
            labelText: 'Phone',
            hintText: 'Enter your phone',
            icon: Icons.phone,
          ),

          textFormAuth(
            controller: kycProvider.emailControoler,
            labelText: 'Email',
            hintText: 'Enter your email',
            icon: Icons.email,
          ),
          10.height,
          Expanded(child: SizedBox()),
          ElevatedButton(
            onPressed: () {
              if (kycProvider.emailControoler.text.isEmpty ||
                  kycProvider.fNameControoler.text.isEmpty ||
                  kycProvider.lNameControoler.text.isEmpty ||
                  kycProvider.phoneController.text.isEmpty) {
                return showErrorMessage(null, 'All form is required');
              }
              kycProvider.nextPage();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colorScheme.primary,
              foregroundColor: theme.colorScheme.onPrimary,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
            child: Text(
              'Next',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                letterSpacing: 1.2,
              ),
            ),
          ),
          10.height,
        ],
      ),
    );
  }
}
