import 'package:flutter/material.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/routes/app_routes.dart';
import '../widgets/auth_widgets.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String _code = '';

  void _addDigit(String digit) {
    if (_code.length < 6) {
      setState(() => _code += digit);
    }
  }

  void _removeDigit() {
    if (_code.isNotEmpty) {
      setState(() => _code = _code.substring(0, _code.length - 1));
    }
  }

  void _verify() {
    if (_code.length == 6) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        AppRoutes.home,
        (route) => false,
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Enter the complete 6-digit code')),
    );
  }

  String _maskedPhone(BuildContext context) {
    final phone = ModalRoute.of(context)?.settings.arguments as String? ?? '';
    final digits = phone.replaceAll(RegExp(r'\D'), '');
    final suffix =
        digits.length >= 2 ? digits.substring(digits.length - 2) : '00';
    return '+1 •••• ••• $suffix';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 8, 20, 8),
              child: Row(
                children: [
                  IconButton(
                    tooltip: 'Back',
                    onPressed: () => Navigator.pop(context),
                    icon:
                        const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
                  ),
                  const SizedBox(width: 4),
                  const Text(
                    'Verification',
                    style: TextStyle(
                      color: AppColors.textDark,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1, color: AppColors.border),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 36, 20, 24),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 480),
                    child: Column(
                      children: [
                        Container(
                          width: 64,
                          height: 64,
                          decoration: const BoxDecoration(
                            color: Color(0xFFF0F5FF),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.verified_user_outlined,
                            color: AppColors.primary,
                            size: 31,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'Enter Code',
                          style: TextStyle(
                            color: AppColors.textDark,
                            fontSize: 25,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 14),
                        const Text(
                          "We've sent a 6-digit verification code to",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppColors.textGrey,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          _maskedPhone(context),
                          style: const TextStyle(
                            color: AppColors.textDark,
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 42),
                        LayoutBuilder(
                          builder: (context, constraints) {
                            final boxWidth = ((constraints.maxWidth - 40) / 6)
                                .clamp(38.0, 48.0);

                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: List.generate(
                                6,
                                (index) => _OtpDigitBox(
                                  width: boxWidth,
                                  digit:
                                      index < _code.length ? _code[index] : '',
                                  isActive: index == _code.length,
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 72),
                        PrimaryAuthButton(
                          label: 'Verify Identity',
                          onPressed: _verify,
                        ),
                        const SizedBox(height: 34),
                        _NumberPad(
                          onDigitPressed: _addDigit,
                          onDeletePressed: _removeDigit,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OtpDigitBox extends StatelessWidget {
  final double width;
  final String digit;
  final bool isActive;

  const _OtpDigitBox({
    required this.width,
    required this.digit,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 54,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: digit.isNotEmpty || isActive
              ? AppColors.primary
              : AppColors.border,
          width: digit.isNotEmpty || isActive ? 2 : 1.4,
        ),
      ),
      child: Text(
        digit,
        style: const TextStyle(
          color: AppColors.textDark,
          fontSize: 22,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _NumberPad extends StatelessWidget {
  final ValueChanged<String> onDigitPressed;
  final VoidCallback onDeletePressed;

  const _NumberPad({
    required this.onDigitPressed,
    required this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    const keys = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '', '0'];

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      childAspectRatio: 2.25,
      children: [
        ...keys.map(
          (digit) => digit.isEmpty
              ? const SizedBox.shrink()
              : TextButton(
                  onPressed: () => onDigitPressed(digit),
                  child: Text(
                    digit,
                    style: const TextStyle(
                      color: AppColors.textDark,
                      fontSize: 21,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
        ),
        IconButton(
          tooltip: 'Delete digit',
          onPressed: onDeletePressed,
          icon: const Icon(Icons.backspace_outlined, size: 21),
        ),
      ],
    );
  }
}
