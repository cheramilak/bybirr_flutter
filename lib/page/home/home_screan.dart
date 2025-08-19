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
              Container(
                height: size.height * 0.2,
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                padding: EdgeInsets.all(15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: colorScheme.surfaceBright,
                  border: Border.all(width: 0.5),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Row(
                      //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('\$2,433', style: theme.textTheme.headlineLarge),
                        15.width,
                        Icon(Icons.visibility).paddingRight(10),
                      ],
                    ),
                    Expanded(
                      child: SizedBox(
                        child: Align(
                          alignment: AlignmentGeometry.centerRight,
                          child: Icon(Icons.wifi),
                        ),
                      ),
                    ),
                    Text(
                      '1038 3498 34764 4743',
                      style: theme.textTheme.bodyLarge,
                    ),
                    10.height,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('23/25', style: theme.textTheme.bodySmall),
                        Icon(Icons.card_membership).paddingRight(10),
                      ],
                    ),
                  ],
                ),
              ),
              10.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: colorScheme.surfaceBright,
                    ),
                    child: Column(
                      children: [
                        CircleAvatar(radius: 20),
                        3.height,
                        Text('Deposit', style: theme.textTheme.bodyLarge),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: colorScheme.surfaceBright,
                    ),
                    child: Column(
                      children: [
                        CircleAvatar(radius: 20),
                        3.height,
                        Text('Deposit', style: theme.textTheme.bodyLarge),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: colorScheme.surfaceBright,
                    ),
                    child: Column(
                      children: [
                        CircleAvatar(radius: 20),
                        3.height,
                        Text('Deposit', style: theme.textTheme.bodyLarge),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: colorScheme.surfaceBright,
                    ),
                    child: Column(
                      children: [
                        CircleAvatar(radius: 20),
                        3.height,
                        Text('Deposit', style: theme.textTheme.bodyLarge),
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
                      border: Border.all(width: 0.3)
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
