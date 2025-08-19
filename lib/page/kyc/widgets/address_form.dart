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
  TextEditingController stateController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController cityControoler = TextEditingController();
  TextEditingController zipCodeControoler = TextEditingController();
  TextEditingController houseNumberControoler = TextEditingController();
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
          textFormAuth(
            controller: stateController,
            labelText: 'State',
            hintText: 'Enter your address',
            icon: Icons.map,
          ),
          textFormAuth(
            controller: cityControoler,
            labelText: 'City',
            hintText: 'Enter your city',
            icon: Icons.location_city,
          ),
          textFormAuth(
            controller: zipCodeControoler,
            labelText: 'Zip code',
            hintText: 'zip code',
            icon: Icons.maps_home_work,
          ),
          
          textFormAuth(
            controller: houseNumberControoler,
            labelText: 'House',
            hintText: 'House number',
            icon: Icons.house,
          ),
          dateFormField(
        labelText: "Date of Birth",
        icon: Icons.calendar_today,
        controller: dobController,
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
