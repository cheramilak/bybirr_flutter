import 'package:bybirr_flutter/page/auth/providers/auth_provider.dart';
import 'package:bybirr_flutter/page/card/virtual_card_detal_screen.dart';
import 'package:bybirr_flutter/page/home/widgets/card_list_bootomsheet.dart';
import 'package:bybirr_flutter/page/home/widgets/card_widget.dart';
import 'package:bybirr_flutter/page/home/widgets/shimmer_loading_widget.dart';
import 'package:bybirr_flutter/page/home/widgets/transaction_detail_bottom_sheet.dart';
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
      child: RefreshIndicator(
        onRefresh: () {
          return Future.delayed(
            Duration(seconds: 2),
          ); //authProvider.getUserProfile();
        },
        child: Scaffold(
          // appBar: AppBar(),
          body: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.all(8),
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
                authProvider.getUser!.cards.isNotEmpty
                    ? CardWidget(
                        size: size,
                        colorScheme: colorScheme,
                        theme: theme,
                        cardModel: authProvider.getUser!.cards[0],
                      )
                    : ShimmerCardWidget(
                        size: size,
                        colorScheme: colorScheme,
                      ).onTap(() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const VirtualCardDetailScreen(
                              cardHolderName: "John Doe",
                              cardNumber: "1234567812345678",
                              expiryDate: "12/28",
                              cvv: "123",
                              balance: "\$1,200.50",
                              cardType: "Visa",
                            ),
                          ),
                        );
                      }),
                true
                    ? KycShimmerWidget()
                    : Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(width: 0.5, color: redColor),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              child: true
                                  ? Icon(
                                      Icons.verified_outlined,
                                      color: greenColor,
                                    )
                                  : Icon(
                                      Icons.warning_outlined,
                                      color: redColor,
                                    ),
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
                                  authProvider.userModel!.kycModel!.status ==
                                          'Approved'
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
                                          style: theme.textTheme.bodySmall
                                              ?.copyWith(
                                                color: colorScheme.error,
                                              ),
                                        ),
                              ],
                            ),
                          ],
                        ),
                      ).onTap(() {
                        if (authProvider.getUser!.kycModel != null &&
                            authProvider.getUser!.kycModel!.status ==
                                'Pending') {
                          return showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) {
                              return KycConformationDialog();
                            },
                          );
                        }
                        if (authProvider.getUser!.kycModel!.status ==
                            'Failed') {
                          KycScreen().launch(context);
                        }
                      }),
                10.height,
                true
                    ? ActionRowShimmer()
                    : Row(
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
                                Text(
                                  'My card',
                                  style: theme.textTheme.labelMedium,
                                ),
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
                                  cardList: authProvider.getUser!.cards,
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
                                Text(
                                  'Deposit',
                                  style: theme.textTheme.labelMedium,
                                ),
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
                                Text(
                                  'Deposit',
                                  style: theme.textTheme.labelMedium,
                                ),
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
                                Text(
                                  'Deposit',
                                  style: theme.textTheme.labelMedium,
                                ),
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
                      'Transactions',
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
                      return false
                          ? KycShimmerWidget()
                          : Container(
                              margin: EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: colorScheme.surfaceBright,
                                border: Border.all(width: 0.3),
                              ),
                              child: ListTile(
                                leading: CircleAvatar(),
                                title: Text(
                                  'Title',
                                  style: theme.textTheme.bodyLarge,
                                ),
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
                            ).onTap(() {
                              showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20),
                                  ),
                                ),
                                builder: (context) {
                                  return const TransactionDetailBottomSheet(
                                    title: "Amazon Purchase",
                                    amount: "\$34.34",
                                    date: "20 Dec 2025",
                                    time: "12:34 PM",
                                    status: "Completed",
                                    referenceId: "TXN123456789",
                                  );
                                },
                              );
                            });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
