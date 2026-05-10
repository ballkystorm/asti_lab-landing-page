import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CTASection extends StatefulWidget {
  const CTASection({super.key});

  @override
  State<CTASection> createState() => _CTASectionState();
}

class _CTASectionState extends State<CTASection> {
  bool hovering = false;

  void openWhatsApp() async {
    final Uri url = Uri.parse(
      "https://wa.me/2349139097783?text=Hi%20ASTI%20Labs,%20I%20want%20to%20discuss%20my%20project.",
    );

    await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 40,
        vertical: 80,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            padding: EdgeInsets.all(isMobile ? 30 : 50),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(32),
              gradient: LinearGradient(
                colors: [
                  Colors.white.withOpacity(0.04),
                  Colors.orange.withOpacity(0.08),
                ],
              ),
              border: Border.all(
                color: Colors.orange.withOpacity(0.25),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.orange.withOpacity(0.12),
                  blurRadius: 40,
                  spreadRadius: 2,
                )
              ],
            ),

            child: isMobile
                ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _leftContent(isMobile),
                const SizedBox(height: 30),
                _button(),
              ],
            )
                : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: _leftContent(isMobile)),
                const SizedBox(width: 40),
                _button(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _leftContent(bool isMobile) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Have an App Idea?\nLet’s Turn It Into Reality.",
          style: TextStyle(
            color: Colors.white,
            fontSize: isMobile ? 30 : 42,
            fontWeight: FontWeight.bold,
            height: 1.2,
          ),
        ),

        const SizedBox(height: 20),

        Text(
          "Get a free project discussion and roadmap for your mobile or web app.",
          style: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize: 16,
            height: 1.6,
          ),
        ),

        const SizedBox(height: 16),

        Row(
          children: [
            const Icon(
              Icons.access_time_rounded,
              color: Colors.green,
              size: 18,
            ),

            const SizedBox(width: 8),

            Text(
              "Usually replies within 5 minutes",
              style: TextStyle(
                color: Colors.green.shade400,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _button() {
    return MouseRegion(
      onEnter: (_) => setState(() => hovering = true),
      onExit: (_) => setState(() => hovering = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: openWhatsApp,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.symmetric(
            horizontal: 32,
            vertical: 20,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            gradient: const LinearGradient(
              colors: [
                Color(0xFFFF6A00),
                Color(0xFFFFA040),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.orange.withOpacity(
                  hovering ? 0.5 : 0.25,
                ),
                blurRadius: hovering ? 30 : 18,
                spreadRadius: hovering ? 4 : 1,
              )
            ],
          ),

          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.rocket_launch_rounded,
                color: Colors.white,
              ),

              const SizedBox(width: 12),

              Text(
                "Book Free Consultation",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: hovering ? 0.5 : 0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}