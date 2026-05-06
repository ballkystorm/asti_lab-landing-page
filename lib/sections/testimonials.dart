import 'package:flutter/material.dart';

class TestimonialsSection extends StatelessWidget {
  const TestimonialsSection({super.key});

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
            children: [
              const Text(
                "What Clients Say",
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

                  int columns =
                  width > 1000 ? 3 : width > 600 ? 2 : 1;

                  double itemWidth =
                      (width - ((columns - 1) * 20)) / columns;

                  return Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    children: [
                      _item(itemWidth, const TestimonialCard(
                        name: "Frank Michele",
                        role: "Startup Founder",
                        text:
                        "They delivered my app faster than expected. The quality was excellent and communication was smooth.",
                      )),
                      _item(itemWidth, const TestimonialCard(
                        name: "Mubarak Yeqeen",
                        role: "Product Manager",
                        text:
                        "Professional team. They understood my idea quickly and turned it into a real product.",
                      )),
                      _item(itemWidth, const TestimonialCard(
                        name: "David Rebeca",
                        role: "Entrepreneur",
                        text:
                        "Highly recommended. The UI/UX and performance of my app exceeded expectations.",
                      )),
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

  Widget _item(double width, Widget child) {
    return SizedBox(width: width, child: child);
  }
}

class TestimonialCard extends StatefulWidget {
  final String name;
  final String role;
  final String text;

  const TestimonialCard({
    super.key,
    required this.name,
    required this.role,
    required this.text,
  });

  @override
  State<TestimonialCard> createState() => _TestimonialCardState();
}

class _TestimonialCardState extends State<TestimonialCard> {
  bool hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => hover = true),
      onExit: (_) => setState(() => hover = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        height: 200,
        padding: const EdgeInsets.all(20),

        transform: Matrix4.identity()
          ..translate(0.0, hover ? -5 : 0.0),

        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.03),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withOpacity(0.08)),
          boxShadow: hover
              ? [
            BoxShadow(
              color: Colors.orange.withOpacity(0.25),
              blurRadius: 20,
            )
          ]
              : [],
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            /// Quote
            Text(
              '"${widget.text}"',
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 14,
                height: 1.5,
              ),
            ),

            /// Profile
            Row(
              children: [
                const CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.person, color: Colors.white),
                ),
                const SizedBox(width: 10),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      widget.role,
                      style: const TextStyle(
                        color: Colors.white60,
                        fontSize: 12,
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}