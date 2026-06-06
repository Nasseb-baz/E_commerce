import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../models/onboarding_data.dart';

class OnboardingPage extends StatelessWidget {
  final OnboardingData data;

  const OnboardingPage({
    required this.data,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final horizontalPadding = constraints.maxWidth >= 700 ? 48.0 : 24.0;

        return SingleChildScrollView(
          padding:
              EdgeInsets.fromLTRB(horizontalPadding, 20, horizontalPadding, 16),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 620),
              child: Column(
                children: [
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(28),
                        child: AspectRatio(
                          aspectRatio: data.imageAspectRatio,
                          child: Image.asset(
                            data.imagePath,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      if (data.badgeLabel case final badgeLabel?)
                        Positioned(
                          right: 16,
                          top: -18,
                          child: _VerifiedBadge(label: badgeLabel),
                        ),
                    ],
                  ),
                  const SizedBox(height: 42),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: const TextStyle(
                        color: AppColors.textDark,
                        fontSize: 30,
                        height: 1.18,
                        fontWeight: FontWeight.w800,
                      ),
                      children: [
                        TextSpan(text: data.titleBeforeHighlight),
                        TextSpan(
                          text: data.highlightedTitle,
                          style: const TextStyle(color: AppColors.primary),
                        ),
                        TextSpan(text: data.titleAfterHighlight),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 520),
                    child: Text(
                      data.description,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: AppColors.textGrey,
                        fontSize: 16,
                        height: 1.55,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _VerifiedBadge extends StatelessWidget {
  final String label;

  const _VerifiedBadge({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.verified_user_outlined,
            color: AppColors.textDark,
            size: 20,
          ),
          const SizedBox(width: 9),
          Text(
            label,
            style: const TextStyle(
              color: AppColors.textDark,
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
