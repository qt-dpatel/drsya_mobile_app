import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:drsya_mobile_app/home/categories.dart';
import 'package:drsya_mobile_app/survey_screens/new_servey.dart';
import 'package:drsya_mobile_app/survey_screens/recommonded_survey.dart';
import 'package:drsya_mobile_app/survey_screens/survey_card.dart';
import 'package:drsya_mobile_app/survey_screens/survey_closing_soon.dart';

import '../survey_screens/data/survey_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  double _appBarHeight = 140;
  double _cornerRadius = 32;
  double _searchBarOpacity = 1;
  double _appBarElevation = 0;
  bool _showSearchIcon = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_handleScroll);

    // Set system UI overlay to blend the status bar with app bar background
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Transparent to allow SVG background
      statusBarIconBrightness: Brightness.light, // White icons for contrast
    ));
  }

  void _handleScroll() {
    double offset = _scrollController.offset;
    double minScroll = 0;
    double maxScroll = 100; // Scroll range for animation

    double progress = (offset - minScroll) / (maxScroll - minScroll);
    progress = progress.clamp(0, 1);

    double screenHeight = MediaQuery.of(context).size.height;

    double maxAppBarHeight =
        screenHeight * 0.22; // Example: ~22% of screen height
    double minAppBarHeight =
        screenHeight * 0.12; // Example: ~12% of screen height

    setState(() {
      _appBarHeight =
          maxAppBarHeight - (progress * (maxAppBarHeight - minAppBarHeight));
      _cornerRadius = 32 - (progress * 16);
      _searchBarOpacity = 1 - progress;
      _appBarElevation = progress * 5;
      _showSearchIcon = progress == 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      body: Column(
        children: [
          // Animated AppBar with SVG Background
          Stack(
            children: [
              AnimatedContainer(
                duration: Duration(milliseconds: 100),
                height: _appBarHeight + statusBarHeight,
                decoration: BoxDecoration(
                  color: Colors.blue.shade100, // Light background
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(_cornerRadius),
                  ),
                  boxShadow: [
                    if (_appBarElevation > 0)
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: _appBarElevation,
                        spreadRadius: 1,
                      ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(_cornerRadius),
                  ),
                  child: SvgPicture.asset(
                    'assets/drysa_background.svg',
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              ),

              // AppBar Content
              Positioned(
                top: 40,
                left: 16,
                right: 16,
                child: Column(
                  children: [
                    // Top Row with Logo and Icons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          spacing: 4.0,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SvgPicture.asset(
                              'assets/drysa_logo.svg', // Replace with your asset
                              fit: BoxFit.cover,
                              height: 16,
                            ),
                            Text(
                              'Drsya Consumer App',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 10),
                            ),
                          ],
                        ),

                        // Icons (Search, Notification, Avatar)
                        Row(
                          children: [
                            // Search Icon appears when search bar disappears
                            if (_showSearchIcon)
                              Icon(Icons.search, color: Colors.white, size: 24),
                            SizedBox(width: _showSearchIcon ? 16 : 0),
                            Stack(
                              children: [
                                Icon(Icons.notifications_none_rounded,
                                    color: Colors.white),
                                Positioned(
                                  right: 2,
                                  top: 3,
                                  child: CircleAvatar(
                                    backgroundColor: Colors.red,
                                    radius: 4,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(width: 16),
                            CircleAvatar(
                              backgroundColor: Colors.grey.shade800,
                              radius: 18,
                              child: Icon(Icons.person, color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),

                    SizedBox(height: 16),

                    // Search Bar with Fade Effect
                    AnimatedOpacity(
                      duration: Duration(milliseconds: 200),
                      opacity: _searchBarOpacity,
                      child: Visibility(
                        visible: _searchBarOpacity > 0,
                        child: SizedBox(
                          height: 48,
                          child: TextField(
                            style: TextStyle(color: Colors.black),
                            decoration: InputDecoration(
                              hintText: 'Search for a survey',
                              hintStyle: TextStyle(color: Colors.black54),
                              prefixIcon:
                                  Icon(Icons.search, color: Colors.black),
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding:
                                  EdgeInsets.symmetric(vertical: 10),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          // Scrollable Content
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                spacing: 20,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  NewSurveys(),
                  Categories(),
                  SurveyListPage(
                    surveys: dummySurveys,
                  ),
                  SurveyClosingSoon(surveys: surveysClosingSoon),
                  RecommondedSurvey(surveys: recommondedDummySurvey),
                  SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
