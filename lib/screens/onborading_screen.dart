import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Onboarding(),
    );
  }
}

class Onboarding extends StatefulWidget {
  const Onboarding({Key? key}) : super(key: key);

  @override
  _OnboardingState createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0; // Track the current page index

  // Define a list of background colors corresponding to each page
  final List<Color> pageColors = [Colors.blue, Colors.red, Colors.green, Colors.orange];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToNextPage() {
    // Go to the next page if not on the last page
    if (_currentPage < onboardingData.length - 1) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 500),
        curve: Curves.ease,
      );
      setState(() {
        _currentPage++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container( // Use a Container for background color
          color: pageColors[_currentPage], // Set background color based on current page
          child: PageView.builder(
            controller: _pageController,
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: onboardingData.length,
            itemBuilder: (context, index) {
              return OnboardPage(
                text: onboardingData[index]['text']!,
                imageAssetPath: onboardingData[index]['image']!,
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentPage,
        onTap: (index) {
          // Handle taps on the bottom navigation items
          if (index == _currentPage + 1) {
            _goToNextPage();
          } else if (index == _currentPage - 1) {
            // Handle going to the previous page if needed
            _pageController.previousPage(
              duration: Duration(milliseconds: 500),
              curve: Curves.ease,
            );
            setState(() {
              _currentPage--;
            });
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.navigate_before),
            label: 'Previous',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.navigate_next),
            label: 'Next',
          ),
        ],
      ),
    );
  }
}

class OnboardPage extends StatelessWidget {
  final String text;
  final String imageAssetPath;

  OnboardPage({required this.text, required this.imageAssetPath});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          imageAssetPath,
          height: 200, // Adjust the height as needed
        ),
        SizedBox(height: 16),
        Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 24),
        ),
      ],
    );
  }
}

final List<Map<String, String>> onboardingData = [
  {
    'text': 'penguin.',
    'image': 'Asset/Images/error.png',    
  },
  {
    'text': 'Dog.',
    'image': 'Asset/Images/dog.png',
  },
  {
    'text': 'Tiger.',
    'image': 'Asset/Images/tiger.png',
  },
  {
    'text': 'Kangaroo.',
    'image': 'Asset/Images/kangaroo.png',
  },
  {
    'text': 'Whale.',
    'image': 'Asset/Images/whale.png',
  },
];

