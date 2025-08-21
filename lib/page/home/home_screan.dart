import 'package:bybirr_flutter/page/auth/providers/auth_provider.dart';
import 'package:bybirr_flutter/page/home/widgets/card_list_bootomsheet.dart';
import 'package:bybirr_flutter/page/home/widgets/card_widget.dart';
import 'package:bybirr_flutter/page/kyc/kyc_screen.dart';
import 'package:bybirr_flutter/page/kyc/widgets/kyc_conformation.dart';
import 'package:bybirr_flutter/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';

class HomeScrean extends StatefulWidget {
  const HomeScrean({super.key});

  @override
  State<HomeScrean> createState() => _HomeScreanState();
}

class _HomeScreanState extends State<HomeScrean> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final colorScheme = theme.colorScheme;
    final size = MediaQuery.of(context).size;
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text(
                  'Hello',
                  style: theme.textTheme.displaySmall!.copyWith(fontSize: 17),
                ),
                subtitle: Text(
                  'User name',
                  style: theme.textTheme.displaySmall!.copyWith(fontSize: 13),
                ),
                trailing: Icon(Icons.notifications).onTap(() {
                  themeProvider.setDarkMode = !themeProvider.getIsDarkMode;
                }),
              ),
              10.height,
              CardWidget(size: size, colorScheme: colorScheme, theme: theme),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(width: 0.5, color: greenColor),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      child: Icon(Icons.warning_outlined, color: redColor),
                    ),
                    15.width,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Complete your verfication',
                          style: theme.textTheme.bodySmall,
                        ),
                        if (authProvider.userModel!.kycModel != null)
                          authProvider.userModel!.kycModel!.status == 'Approved'
                              ? Row(
                                  children: [
                                    Icon(
                                      Icons.verified,
                                      color: greenColor,
                                      size: 15,
                                    ),
                                    8.width,
                                    Text(
                                      "verfied",
                                      style: theme.textTheme.bodySmall
                                          ?.copyWith(color: greenColor),
                                    ),
                                  ],
                                )
                              : Text(
                                  "${authProvider.userModel!.kycModel!.status},${authProvider.userModel!.kycModel!.reason ?? ''}",
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: colorScheme.error,
                                  ),
                                ),
                      ],
                    ),
                  ],
                ),
              ).onTap(() {
                if (authProvider.getUser!.kycModel != null &&
                    authProvider.getUser!.kycModel!.status == 'Pending') {
                  return showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (context) {
                      return KycConformationDialog();
                    },
                  );
                }
                if (authProvider.getUser!.kycModel!.status == 'Failed') {
                  KycScreen().launch(context);
                }
              }),
              10.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: colorScheme.surfaceBright,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(radius: 13),
                        10.height,
                        Text('My card', style: theme.textTheme.labelMedium),
                      ],
                    ),
                  ).onTap(() {
                    return showModalBottomSheet(
                      showDragHandle: true,
                      enableDrag: true,
                      isScrollControlled: true,
                      context: context,
                      builder: (context) {
                        return CardListBootomsheet(
                          kycModel: authProvider.getUser!.kycModel,
                        );
                      },
                    );
                  }),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: colorScheme.surfaceBright,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(radius: 13),
                        10.height,
                        Text('Deposit', style: theme.textTheme.labelMedium),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: colorScheme.surfaceBright,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(radius: 13),
                        10.height,
                        Text('Deposit', style: theme.textTheme.labelMedium),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: colorScheme.surfaceBright,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(radius: 13),
                        10.height,
                        Text('Deposit', style: theme.textTheme.labelMedium),
                      ],
                    ),
                  ),
                ],
              ).paddingOnly(left: 15, right: 15),
              15.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Transaction detail',
                    style: theme.textTheme.bodyLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text('View all', style: theme.textTheme.bodySmall),
                ],
              ),
              10.height,
              SizedBox(
                child: ListView.builder(
                  itemCount: 10,
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: colorScheme.surfaceBright,
                        border: Border.all(width: 0.3),
                      ),
                      child: ListTile(
                        leading: CircleAvatar(),
                        title: Text('Title', style: theme.textTheme.bodyLarge),
                        subtitle: Text(
                          '20 dec',
                          style: theme.textTheme.bodySmall,
                        ),
                        trailing: Text.rich(
                          TextSpan(
                            text: '\$34.34 \n', // default text
                            style: theme.textTheme.bodyMedium,
                            children: <TextSpan>[
                              TextSpan(
                                text: '12:34 pm',
                                style: theme.textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
