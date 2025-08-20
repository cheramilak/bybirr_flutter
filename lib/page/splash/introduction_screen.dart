import 'package:bybirr_flutter/core/user_data.dart';
import 'package:bybirr_flutter/page/auth/login_screan.dart';
import 'package:bybirr_flutter/page/auth/signup_screan.dart';
import 'package:bybirr_flutter/page/splash/providers/introduction_provider.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({super.key});

  @override
  State<IntroductionScreen> createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    IntroductionProvider introductionProvider =
        Provider.of<IntroductionProvider>(context);
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: introductionProvider.getController,
              itemCount: getIntroductionList.length,
              onPageChanged: (index) {
                introductionProvider.setIndex = index;
              },
              itemBuilder: (context, index) {
                return IntroductionWidget(model: getIntroductionList[index]);
              },
            ),
          ),
          Center(
            child: SmoothPageIndicator(
              controller: introductionProvider.getController,
              count: getIntroductionList.length,
              axisDirection: Axis.horizontal,
              effect: ExpandingDotsEffect(),
            ),
          ),
          10.height,
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: (){
                  LoginScrean().launch(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: theme.colorScheme.primary,
                  foregroundColor: theme.colorScheme.onPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Login',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              15.width,
              ElevatedButton(
                onPressed: () {
                  SignupScrean().launch(context);
                },
                style: ElevatedButton.styleFrom(
                 // backgroundColor: theme.colorScheme.primary,
                 // oregroundColor: theme.colorScheme.onPrimary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Signup',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ],
          ).paddingOnly(left: 10, right: 10),
          20.height,
        ],
      ),
    );
  }
}

class IntroductionWidget extends StatelessWidget {
  final IntroductionModel model;
  const IntroductionWidget({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        25.height,
        Expanded(
          child: Lottie.asset('assets/lottie/lottie${model.assetIndex}.json'),
        ),
        20.height,
        Text(
          model.title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        5.height,
        Text(model.description, textAlign: TextAlign.center),
        140.height,
      ],
    );
  }
}

class IntroductionModel {
  final String title;
  final String description;
  final int assetIndex;

  IntroductionModel({
    required this.title,
    required this.description,
    required this.assetIndex,
  });
}

List<IntroductionModel> getIntroductionList = [
  IntroductionModel(
    title: 'Learn from Experts',
    description:
        'Access courses, strategies, and market insights tailored for all levels.',
    assetIndex: 5,
  ),
  IntroductionModel(
    title: 'Risk-Free Demo Trading',
    description:
        'Trade with virtual money in a real-time simulated environment.',
    assetIndex: 2,
  ),
  IntroductionModel(
    title: 'Track Your Progress',
    description:
        'Get performance analytics and insights to refine your strategy.',
    assetIndex: 4,
  ),
  IntroductionModel(
    title: 'Master Candlestick Patterns',
    description:
        'Learn how to read candlestick patterns like a pro! Understand market movements, identify trends, and improve your trading strategy with interactive lessons and real-world examples.',
    assetIndex: 1,
  ),
  IntroductionModel(
    title: 'Test Your Forex Knowledge!',
    description:
        'Think you know Forex trading? Challenge yourself with interactive quizzes on candlestick patterns, trading strategies, and market trends. Compete with friends and climb the leaderboard!',
    assetIndex: 3,
  ),
];
