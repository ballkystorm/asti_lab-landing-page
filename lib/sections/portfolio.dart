import 'package:flutter/material.dart';

class PortfolioSection extends StatelessWidget {
  const PortfolioSection({super.key});

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
          child: Column(
            children: [
              const Text(
                "Our Work",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 40),

              LayoutBuilder(
                builder: (context, constraints) {
                  double width = constraints.maxWidth;

                  int crossAxisCount =
                  width > 1000 ? 3 : width > 600 ? 2 : 1;

                  double itemWidth =
                      (width - ((crossAxisCount - 1) * 20)) /
                          crossAxisCount;

                  return Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    children: [
                      _card(
                        itemWidth,
                        const PortfolioCard(
                          image: "assets/images/app1.png",
                          title: "Service App",
                          desc: "Booking & marketplace app",
                        ),
                      ),

                      _card(
                        itemWidth,
                        const PortfolioCard(
                          image: "assets/images/app2.jpg",
                          title: "E-commerce App",
                          desc: "Online store with payments",
                        ),
                      ),

                      _card(
                        itemWidth,
                        const PortfolioCard(
                          image: "assets/images/app3.jpg",
                          title: "Dashboard System",
                          desc: "Admin analytics platform",
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// ✅ FIXED METHOD
  Widget _card(double width, Widget child) {
    return SizedBox(
      width: width,
      child: child,
    );
  }
}

class PortfolioCard extends StatefulWidget {
  final String image;
  final String title;
  final String desc;

  const PortfolioCard({
    super.key,
    required this.image,
    required this.title,
    required this.desc,
  });

  @override
  State<PortfolioCard> createState() => _PortfolioCardState();
}

class _PortfolioCardState extends State<PortfolioCard> {
  bool hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => hovering = true),
      onExit: (_) => setState(() => hovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: 260,
        transform: Matrix4.identity()
          ..translate(0.0, hovering ? -6 : 0.0),

        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.03),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: Colors.white.withOpacity(0.08),
          ),
          boxShadow: hovering
              ? [
            BoxShadow(
              color: Colors.orange.withOpacity(0.3),
              blurRadius: 20,
            )
          ]
              : [],
        ),

        child: Column(
          children: [
            /// IMAGE
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                child: Image.asset(
                  widget.image,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),

            /// TEXT
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    widget.desc,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}