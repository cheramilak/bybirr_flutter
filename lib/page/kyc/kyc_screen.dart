import 'package:bybirr_flutter/page/kyc/kyc_provider.dart';
import 'package:bybirr_flutter/page/kyc/widgets/address_form.dart';
import 'package:bybirr_flutter/page/kyc/widgets/id_form.dart';
import 'package:bybirr_flutter/page/kyc/widgets/name_form.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class KycScreen extends StatefulWidget {
  const KycScreen({super.key});

  @override
  State<KycScreen> createState() => _KycScreenState();
}

class _KycScreenState extends State<KycScreen> {
  @override
  void initState() {
    super.initState();
    
  }

  @override
  Widget build(BuildContext context) {
    KycProvider kycProvider = Provider.of<KycProvider>(context);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Container(
          width: size.width * 0.7,
          child: LinearProgressIndicator(
            value: (kycProvider.getIndex + 1) /
                kycProvider.getColorList.length,
            backgroundColor: theme.dividerColor,
            valueColor: AlwaysStoppedAnimation(theme.colorScheme.primary),
            minHeight: 13,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      body: PageView.builder(
          controller: kycProvider.getController,
          physics: kycProvider.getScrollPhysics(),
          onPageChanged: (value) {
            kycProvider.setIndex = value;
          },
          itemCount: 3,
          itemBuilder: (context, index) {
          if(index == 0)
          {
            return  NameForm();
          }
          if(index == 1)
          {
            return  AddressForm();
          }
          if(index == 2)
          {
            return  IdForm();
          }
          return  NameForm();
          }),
    );
  }
}
