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
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailControoler = TextEditingController();
  TextEditingController fNameControoler = TextEditingController();
  TextEditingController lNameControoler = TextEditingController();
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
            'Start with your self',
            style: theme.textTheme.headlineLarge,
          ),
          30.height,
          textFormAuth(
            controller: fNameControoler,
            labelText: 'Name',
            hintText: 'Enter first name',
            icon: Icons.person,
          ),
          textFormAuth(
            controller: lNameControoler,
            labelText: 'Name',
            hintText: 'Enter your last name',
            icon: Icons.person,
          ),
          textFormAuth(
            controller: phoneController,
            labelText: 'Phone',
            hintText: 'Enter your phone',
            icon: Icons.phone,
          ),
          
          textFormAuth(
            controller: emailControoler,
            labelText: 'Email',
            hintText: 'Enter your email',
            icon: Icons.email,
          ),
          10.height,
          const Text(
            'Select Gender:',
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.start,
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: colorScheme.surface.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                      strokeAlign: 0.8,
                      width: 2.5,
                      color: true
                          ? blueColor
                          : gray),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AnimatedScale(
                      scale: 1,
                      duration: const Duration(milliseconds: 200),
                      child: Icon(
                        Icons.male,
                        size: 40,
                        // color: color,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Male',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        //color: color,
                      ),
                    ),
                  ],
                ),
              ).onTap(() {
                
              }),
              20.width,
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: colorScheme.surface.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                      strokeAlign: 0.8,
                      width: 2.5,
                      color: false
                          ? blueColor
                          : gray),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AnimatedScale(
                      scale: 1,
                      duration: const Duration(milliseconds: 200),
                      child: Icon(
                        Icons.female,
                        size: 40,
                        // color: color,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Female',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        //color: color,
                      ),
                    ),
                  ],
                ),
              ).onTap(() {
                //profileProvider.setSelectedSex = 0;
              }),
            ],
          ),
          Expanded(child: SizedBox()),
          Padding(
            padding: const EdgeInsets.all(10),
            child: AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: 1,
              child: false
                  ? LoadingAnimationWidget.staggeredDotsWave(
                      color: greenColor, size: 30)
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
                            horizontal: 60, vertical: 18),
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
