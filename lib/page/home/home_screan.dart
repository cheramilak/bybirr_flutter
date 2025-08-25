import 'package:bybirr_flutter/page/auth/providers/auth_provider.dart';
import 'package:bybirr_flutter/page/card/virtual_card_detal_screen.dart';
import 'package:bybirr_flutter/page/home/providers/home_provider.dart';
import 'package:bybirr_flutter/page/home/widgets/card_list_bootomsheet.dart';
import 'package:bybirr_flutter/page/home/widgets/card_widget.dart';
import 'package:bybirr_flutter/page/home/widgets/shimmer_loading_widget.dart';
import 'package:bybirr_flutter/page/home/widgets/transaction_detail_bottom_sheet.dart';
import 'package:bybirr_flutter/page/home/widgets/virification_dilaog.dart';
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
    HomeProvider homeProvider = Provider.of<HomeProvider>(context);
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
                    homeProvider.userName,
                    style: theme.textTheme.displaySmall!.copyWith(fontSize: 13),
                  ),
                  trailing: Icon(Icons.notifications).onTap(() {
                    themeProvider.setDarkMode = !themeProvider.getIsDarkMode;
                  }),
                ),
                10.height,
                homeProvider.getIsLoading
                    ? ShimmerCardWidget(size: size, colorScheme: colorScheme)
                    : authProvider.getUser.cards.isNotEmpty
                    ? CardWidget(
                        size: size,
                        colorScheme: colorScheme,
                        theme: theme,
                        cardModel: authProvider.getUser.cards[0],
                      )
                    : DemoCardWidget(
                        size: size,
                        colorScheme: colorScheme,
                        theme: theme,
                      ),
                homeProvider.getIsLoading
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
                              child: homeProvider.isKYCVerified
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
                                homeProvider.isKYCVerified
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
                                        "${homeProvider.isKYCPending
                                            ? 'Pending'
                                            : homeProvider.isKYCFailed
                                            ? 'Failed ,${authProvider.userModel.kycModel!.reason ?? ''}'
                                            : 'Not Started'}",
                                        style: theme.textTheme.bodySmall
                                            ?.copyWith(
                                              color: homeProvider.isKYCFailed
                                                  ? colorScheme.error
                                                  : colorScheme.primary,
                                            ),
                                      ),
                              ],
                            ),
                          ],
                        ),
                      ).onTap(() {
                        if (homeProvider.isKYCNotStarted) {
                          return showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) {
                              return VirificationStartDilaog();
                            },
                          );
                        }
                        if (homeProvider.isKYCFailed) {
                          return KycScreen().launch(context);
                        } else if (homeProvider.isKYCPending) {
                          return showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) {
                              return VirificationPendingDilaog();
                            },
                          );
                        } else if (homeProvider.isKYCFailed) {
                          return showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (context) {
                              return VirificationFailDilaog();
                            },
                          );
                        }
                      }),
                10.height,
                homeProvider.getIsLoading
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
                            );
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
