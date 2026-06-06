class OnboardingData {
  final String imagePath;
  final String titleBeforeHighlight;
  final String highlightedTitle;
  final String titleAfterHighlight;
  final String description;
  final String buttonLabel;
  final String? badgeLabel;
  final String? footerLabel;
  final double imageAspectRatio;

  const OnboardingData({
    required this.imagePath,
    required this.titleBeforeHighlight,
    required this.highlightedTitle,
    required this.description,
    this.titleAfterHighlight = '',
    this.buttonLabel = 'Next Step',
    this.badgeLabel,
    this.footerLabel,
    this.imageAspectRatio = 1.45,
  });
}

const onboardingPages = <OnboardingData>[
  OnboardingData(
    imagePath: 'lib/assets/images/onboarding1.png',
    titleBeforeHighlight: 'Shop the Latest\n',
    highlightedTitle: 'Tech Gadgets',
    description:
        'Experience the future of electronics with our curated selection of high-performance devices.',
  ),
  OnboardingData(
    imagePath: 'lib/assets/images/onboarding2.png',
    titleBeforeHighlight: 'Discover ',
    highlightedTitle: 'Trusted',
    titleAfterHighlight: '\nStores',
    description:
        'Shop with confidence from a curated selection of certified tech retailers and official brand stores.',
  ),
  OnboardingData(
    imagePath: 'lib/assets/images/onboarding3.png',
    titleBeforeHighlight: 'Fast & Secure Login',
    highlightedTitle: '',
    description:
        'Access your account in seconds with biometric security and end-to-end data encryption for all your tech purchases.',
    buttonLabel: 'Get Started',
    badgeLabel: 'Verified',
    footerLabel: 'BANK-GRADE SECURITY PROTOCOL',
    imageAspectRatio: 1,
  ),
];
