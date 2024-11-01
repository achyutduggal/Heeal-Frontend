import 'package:flutter/material.dart';
import 'package:heeal/presentation/resources/assets_manager.dart';
import 'package:heeal/presentation/resources/strings_manager.dart';
import '../resources/color_manager.dart';
import '../resources/routes_manager.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<Map<String, String>> _onboardingData = [
    {
      "image": ImageAssets.onboarding1,
      "title": AppStrings.onBoardingTitle1,
      "description": AppStrings.onBoardingSubTitle1,
    },
    {
      "image": ImageAssets.onboarding2,
      "title": AppStrings.onBoardingTitle2,
      "description": AppStrings.onBoardingSubTitle2,
    },
    {
      "image": ImageAssets.onboarding3,
      "title": AppStrings.onBoardingTitle3,
      "description": AppStrings.onBoardingSubTitle3
    },
  ];

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: _onPageChanged,
                itemCount: _onboardingData.length,
                itemBuilder: (context, index) {
                  return _buildOnboardingPage(
                    image: _onboardingData[index]["image"]!,
                    title: _onboardingData[index]["title"]!,
                    description: _onboardingData[index]["description"]!,
                  );
                },
              ),
            ),
            _buildIndicator(),
            const SizedBox(height: 24),
            _buildGetStartedButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildOnboardingPage({
    required String image,
    required String title,
    required String description,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          image,
          height: 300,
          fit: BoxFit.cover,
        ),
        const SizedBox(height: 24),
        Text(
          title,
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: ColorManager.darkGrey,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Text(
          description,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: ColorManager.grey,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(_onboardingData.length, (index) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          width: _currentIndex == index ? 12.0 : 8.0,
          height: 8.0,
          decoration: BoxDecoration(
            color: _currentIndex == index ? ColorManager.primary : ColorManager.grey,
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }

  Widget _buildGetStartedButton() {
    return _currentIndex == _onboardingData.length - 1
        ? ElevatedButton(
      onPressed: () {
        Navigator.pushReplacementNamed(context, Routes.loginRoute);
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        backgroundColor: ColorManager.primary,
      ),
      child: const Text(
        "Get Started",
        style: TextStyle(color: Colors.white),
      ),
    )
        : TextButton(
      onPressed: () {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.ease,
        );
      },
      child: Text(
        "Next",
        style: TextStyle(color: ColorManager.primary),
      ),
    );
  }
}

