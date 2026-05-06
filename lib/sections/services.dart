import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/gradient_icon.dart';

class FloatingWhatsApp extends StatelessWidget {
  const FloatingWhatsApp({super.key});

  void openWhatsApp() async {
    final Uri url = Uri.parse(
      "https://wa.me/2349139097783?text=Hello%20I%20have%20an%20app%20idea",
    );
    await launchUrl(url);
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 30,
      right: 30,
      child: GestureDetector(
        onTap: openWhatsApp,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF25D366),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.green.withOpacity(0.6),
                blurRadius: 20,
                spreadRadius: 2,
              ),
            ],
          ),
          child: const Icon(
            Icons.chat,
            color: Colors.white,
            size: 28,
          ),
        ),
      ),
    );
  }
}

class HoverCard extends StatefulWidget {
  final Widget child;
  final List<Color> gradient;

  const HoverCard({
    super.key,
    required this.child,
    required this.gradient,
  });

  @override
  State<HoverCard> createState() => _HoverCardState();
}

class _HoverCardState extends State<HoverCard> {
  bool isHovered = false;
  Offset mousePosition = Offset.zero;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      onHover: (event) {
        setState(() {
          mousePosition = event.localPosition;
        });
      },
      child: SizedBox(
        height: 220, // ✅ FIX: give HoverCard a height
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          transform: Matrix4.identity()
            ..scale(isHovered ? 1.03 : 1.0),
          decoration: isHovered
              ? BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            boxShadow: [
              BoxShadow(
                color: widget.gradient.first.withOpacity(0.4),
                blurRadius: 25,
                spreadRadius: 1,
                offset: Offset(
                  (mousePosition.dx - 130) / 10,
                  (mousePosition.dy - 110) / 10,
                ),
              ),
            ],
          )
              : null,
          child: Stack(
            children: [
              if (isHovered)
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      border: Border.all(
                        width: 1.5,
                        color: widget.gradient.first.withOpacity(0.6),
                      ),
                    ),
                  ),
                ),
              widget.child,
            ],
          ),
        ),
      ),
    );
  }
}

class ServicesSection extends StatelessWidget {
  const ServicesSection({super.key});

  Widget card(IconData icon, String title, String desc, List<Color> gradient) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.03),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white.withOpacity(0.1)),
            boxShadow: [
              BoxShadow(
                color: gradient.first.withOpacity(0.25),
                blurRadius: 20,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TweenAnimationBuilder<double>(
                duration: const Duration(milliseconds: 300),
                tween: Tween(begin: 1, end: 1),
                builder: (context, scale, child) {
                  return Transform.scale(
                    scale: scale,
                    child: child,
                  );
                },
                child: GradientIcon(
                  icon: icon,
                  colors: gradient,
                  size: 42,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                desc,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white70,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width < 600 ? 20 : 40,
        vertical: 60,
      ),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Column(
            children: [
              const Text(
                "What You Get",
                style: TextStyle(color: Colors.white, fontSize: 28),
              ),
              const SizedBox(height: 30),
              LayoutBuilder(
                builder: (context, constraints) {
                  int columns;

                  if (constraints.maxWidth > 1000) {
                    columns = 4; // desktop
                  } else if (constraints.maxWidth > 600) {
                    columns = 2; // tablet
                  } else {
                    columns = 1; // mobile
                  }

                  return Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: [
                      _responsiveItem(columns, HoverCard(
                        gradient: [Colors.blue, Colors.cyan],
                        child: card(
                          Icons.phone_android,
                          "Mobile Apps",
                          "Custom Flutter apps",
                          [Colors.blue, Colors.cyan],
                        ),
                      )),

                      _responsiveItem(columns, HoverCard(
                        gradient: [Colors.orange, Colors.deepOrange],
                        child: card(
                          Icons.storage,
                          "Backend",
                          "APIs & database systems",
                          [Colors.orange, Colors.deepOrange],
                        ),
                      )),

                      _responsiveItem(columns, HoverCard(
                        gradient: [Colors.purple, Colors.pink],
                        child: card(
                          Icons.dashboard,
                          "Dashboards",
                          "Admin panels",
                          [Colors.purple, Colors.pink],
                        ),
                      )),

                      _responsiveItem(columns, HoverCard(
                        gradient: [Colors.orangeAccent, Colors.yellow],
                        child: card(
                          Icons.lightbulb,
                          "Consultation",
                          "Idea to product",
                          [Colors.orangeAccent, Colors.yellow],
                        ),
                      )),
                    ],
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _responsiveItem(int columns, Widget child) {
    return SizedBox(
      width: columns == 1
          ? double.infinity
          : (1100 / columns) - 16, // keeps layout tight
      child: child,
    );
  }
}