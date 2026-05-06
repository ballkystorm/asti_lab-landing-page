import 'dart:html' as html;
import 'package:flutter/material.dart';

class PricingSection extends StatelessWidget {
  const PricingSection({super.key});

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
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Column(
            children: const [
              Text(
                "Pricing",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),

              /// 🔥 BETTER POSITIONING
              Text(
                "Built for founders who want real results — not experiments.",
                style: TextStyle(color: Colors.white70),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 40),

              _PricingGrid(),
            ],
          ),
        ),
      ),
    );
  }
}

class _PricingGrid extends StatelessWidget {
  const _PricingGrid();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double width = constraints.maxWidth;

        int columns = width > 900 ? 3 : width > 600 ? 2 : 1;

        double itemWidth =
            (width - ((columns - 1) * 20)) / columns;

        return Wrap(
          spacing: 20,
          runSpacing: 20,
          children: [
            SizedBox(
              width: itemWidth,
              child: const PricingCard(
                title: "Starter",
                price: "\$800+",
                features: [
                  "MVP mobile app",
                  "Clean UI design",
                  "Basic backend",
                  "1 month support"
                ],
                timeline: "Delivered in 2–4 weeks",
              ),
            ),

            SizedBox(
              width: itemWidth,
              child: const PricingCard(
                title: "Pro",
                price: "\$2,000+",
                featured: true,
                features: [
                  "Advanced app features",
                  "Premium UI/UX",
                  "API integrations",
                  "Admin dashboard",
                  "3 months support"
                ],
                timeline: "Delivered in 4–8 weeks",
                badge: "Most Popular",
              ),
            ),

            SizedBox(
              width: itemWidth,
              child: const PricingCard(
                title: "Custom",
                price: "\$5,000+",
                features: [
                  "Fully custom solution",
                  "Scalable architecture",
                  "Advanced integrations",
                  "Ongoing support"
                ],
                timeline: "Tailored timeline",
              ),
            ),
          ],
        );
      },
    );
  }
}

class PricingCard extends StatefulWidget {
  final String title;
  final String price;
  final List<String> features;
  final bool featured;
  final String timeline;
  final String? badge;

  const PricingCard({
    super.key,
    required this.title,
    required this.price,
    required this.features,
    required this.timeline,
    this.featured = false,
    this.badge,
  });

  @override
  State<PricingCard> createState() => _PricingCardState();
}

class _PricingCardState extends State<PricingCard> {
  bool loading = false;
  bool hover = false;

  void openWhatsApp() {
    if (loading) return;

    setState(() => loading = true);

    final url =
        "https://wa.me/2349139097783?text=Hi%20I'm%20interested%20in%20the%20${widget.title}%20plan.%20Can%20we%20discuss?";

    html.window.open(url, "_blank");

    Future.delayed(const Duration(milliseconds: 800), () {
      if (mounted) setState(() => loading = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => hover = true),
      onExit: (_) => setState(() => hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding: const EdgeInsets.all(24),

        transform: Matrix4.identity()
          ..translate(0.0, hover ? -6 : 0.0),

        decoration: BoxDecoration(
          color: widget.featured
              ? const Color(0xFFFF6A00).withOpacity(0.12)
              : Colors.white.withOpacity(0.03),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: widget.featured
                ? const Color(0xFFFF6A00)
                : Colors.white.withOpacity(0.08),
          ),
          boxShadow: hover
              ? [
            BoxShadow(
              color: Colors.orange.withOpacity(0.3),
              blurRadius: 25,
            )
          ]
              : [],
        ),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 🔥 BADGE
            if (widget.badge != null)
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.symmetric(
                    horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  widget.badge!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

            Text(
              widget.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              widget.price,
              style: const TextStyle(
                color: Color(0xFFFF6A00),
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            ...widget.features.map(
                  (f) => Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Row(
                  children: [
                    const Icon(Icons.check,
                        color: Colors.green, size: 16),
                    const SizedBox(width: 8),
                    Text(
                      f,
                      style:
                      const TextStyle(color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            /// 🔥 CTA BUTTON
            GestureDetector(
              onTap: loading ? null : openWhatsApp,
              child: Container(
                width: double.infinity,
                padding:
                const EdgeInsets.symmetric(vertical: 18),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFFFF6A00),
                      Color(0xFFFFA040)
                    ],
                  ),
                ),
                child: loading
                    ? const CircularProgressIndicator(
                    color: Colors.white, strokeWidth: 2)
                    : const Text(
                  "Start Your Project",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 12),

            /// 🔥 TRUST LINE
            Text(
              widget.timeline,
              style: const TextStyle(
                color: Colors.white54,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}