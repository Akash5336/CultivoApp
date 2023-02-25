import 'package:flutter/material.dart';

import '../widgets/best_value.dart';
import '../widgets/predict_screen.dart';
import '../widgets/faq.dart';

class FeatureScreen extends StatefulWidget {
  const FeatureScreen({super.key});

  @override
  State<FeatureScreen> createState() => _FeatureScreenState();
}

class _FeatureScreenState extends State<FeatureScreen>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _selectedTabIndex = 0;

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 3,
      vsync: this,
    );
  }

  final List<Widget> _bodyView = const <Widget>[
    PredictionScreen(),
    BestCrop(),
    FAQScreen(),
  ];

  void _onPageChanged(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  void _onItemTapped(int i) {
    _pageController.animateToPage(
      i,
      duration: const Duration(milliseconds: 700),
      curve: Curves.ease,
    );
  }

  Widget _tabItem(Widget child, {bool isSelected = false}) {
    final pageWidth = MediaQuery.of(context).size.width;
    final pageHeight = MediaQuery.of(context).size.height;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      alignment: Alignment.center,
      margin: EdgeInsets.all(pageHeight * 0.008),
      padding: EdgeInsets.all(pageWidth * 0.0175),
      decoration: !isSelected
          ? BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Theme.of(context).colorScheme.background,
            )
          : BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Theme.of(context).colorScheme.onBackground,
            ),
      child: child,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> icons = [
      Image.asset(
        "assets/Predict.png",
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      Image.asset(
        "assets/Monitor.png",
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
      Image.asset(
        "assets/FAQ.png",
        color: Theme.of(context).colorScheme.primaryContainer,
      ),
    ];
    final pageWidth = MediaQuery.of(context).size.width;
    final pageHeight = MediaQuery.of(context).size.height;
    dynamic curTime;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // backgroundColor: const Color(0xff84aea4),
      // backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
      body: WillPopScope(
        onWillPop: () {
          DateTime now = DateTime.now();
          if (curTime == null ||
              now.difference(curTime) > const Duration(seconds: 2)) {
            curTime = now;
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text("Press back again to exit!"),
            ));
            return Future.value(false);
          }
          return Future.value(true);
        },
        child: PageView(
          controller: _pageController,
          onPageChanged: _onPageChanged,
          physics: const NeverScrollableScrollPhysics(),
          children: _bodyView,
        ),
      ),
      bottomNavigationBar: Container(
        height: pageHeight * 0.0875,
        padding: EdgeInsets.only(
          left: pageWidth * 0.18,
          right: pageWidth * 0.18,
          bottom: pageHeight * 0.015,
          top: pageHeight * 0.0075,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(35),
          child: Container(
            color: Theme.of(context).colorScheme.secondaryContainer,
            child: TabBar(
              onTap: _onItemTapped,
              indicator: const UnderlineTabIndicator(
                borderSide: BorderSide.none,
              ),
              tabs: [
                for (int i = 0; i < icons.length; i++)
                  _tabItem(
                    icons[i],
                    isSelected: i == _selectedTabIndex,
                  ),
              ],
              controller: _tabController,
            ),
          ),
        ),
      ),
    );
  }
}
