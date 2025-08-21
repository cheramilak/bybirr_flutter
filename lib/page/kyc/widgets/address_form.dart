import 'package:bybirr_flutter/core/exception_message.dart';
import 'package:bybirr_flutter/page/kyc/kyc_provider.dart';
import 'package:bybirr_flutter/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class AddressForm extends StatefulWidget {
  const AddressForm({super.key});

  @override
  State<AddressForm> createState() => _AddressFormState();
}

class _AddressFormState extends State<AddressForm> {
  @override
  Widget build(BuildContext context) {
    KycProvider kycProvider = Provider.of<KycProvider>(context);

    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          20.height,
          Text(
            'Tell us about your self more',
            style: theme.textTheme.titleLarge,
          ),
          30.height,
          textFormAuth(
            controller: kycProvider.stateController,
            labelText: 'State',
            hintText: 'Enter your address',
            icon: Icons.map,
          ),
          textFormAuth(
            controller: kycProvider.cityControoler,
            labelText: 'City',
            hintText: 'Enter your city',
            icon: Icons.location_city,
          ),
          textFormAuth(
            controller: kycProvider.line1Controoler,
            labelText: 'Line 1',
            hintText: 'Line 1 address',
            icon: Icons.map,
          ),
          textFormAuth(
            controller: kycProvider.zipCodeControoler,
            labelText: 'Zip code',
            hintText: 'zip code',
            icon: Icons.maps_home_work,
          ),

          textFormAuth(
            controller: kycProvider.houseNumberControoler,
            labelText: 'House',
            hintText: 'House number',
            icon: Icons.house,
          ),
          dateFormField(
            labelText: "Date of Birth",
            icon: Icons.calendar_today,
            controller: kycProvider.dobController,
            context: context,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please select your date of birth";
              }
              return null;
            },
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
                onPressed: () {
                  if (kycProvider.stateController.text.isEmpty ||
                      kycProvider.cityControoler.text.isEmpty ||
                      kycProvider.zipCodeControoler.text.isEmpty ||
                      kycProvider.houseNumberControoler.text.isEmpty ||
                      kycProvider.line1Controoler.text.isEmpty ||
                      kycProvider.dobController.text.isEmpty) {
                    return showErrorMessage(null, 'All form is required');
                  }
                  kycProvider.nextPage();
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
                child: Text(
                  'Next',
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
