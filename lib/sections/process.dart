import 'package:flutter/material.dart';

class ProcessSection extends StatelessWidget {
  const ProcessSection({super.key});

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
                "How We Work",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 60),

              LayoutBuilder(
                builder: (context, constraints) {
                  double width = constraints.maxWidth;

                  int crossAxisCount =
                  width > 900 ? 4 : width > 600 ? 2 : 2;

                  double itemWidth =
                      (width - ((crossAxisCount - 1) * 20)) / crossAxisCount;

                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      /// 🔥 CONNECTION LINE (desktop only)
                      if (width > 900)
                        Positioned.fill(
                          child: Align(
                            alignment: Alignment.center,
                            child: Container(
                              height: 2,
                              margin:
                              const EdgeInsets.symmetric(horizontal: 60),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.transparent,
                                    Colors.white.withOpacity(0.2),
                                    Colors.transparent,
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),

                      /// 🔥 CARDS
                      Wrap(
                        spacing: 20,
                        runSpacing: 20,
                        children: [
                          _animated(
                            0,
                            itemWidth,
                            const ProcessCard(
                              "01",
                              "Idea",
                              "We understand your vision",
                              Icons.lightbulb,
                              Colors.orange,
                            ),
                          ),
                          _animated(
                            1,
                            itemWidth,
                            const ProcessCard(
                              "02",
                              "Design",
                              "We design UI/UX",
                              Icons.design_services,
                              Colors.deepOrange,
                            ),
                          ),
                          _animated(
                            2,
                            itemWidth,
                            const ProcessCard(
                              "03",
                              "Build",
                              "We develop your app",
                              Icons.code,
                              Colors.amber,
                            ),
                          ),
                          _animated(
                            3,
                            itemWidth,
                            const ProcessCard(
                              "04",
                              "Launch",
                              "We deploy & scale",
                              Icons.rocket_launch,
                              Colors.orangeAccent,
                            ),
                          ),
                        ],
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

  Widget _animated(int index, double width, Widget child) {
    return SizedBox(
      width: width,
      child: TweenAnimationBuilder<double>(
        duration: Duration(milliseconds: 500 + (index * 150)),
        tween: Tween(begin: 40, end: 0),
        curve: Curves.easeOut,
        builder: (context, value, child) {
          return Transform.translate(
            offset: Offset(0, value),
            child: Opacity(
              opacity: (1 - (value / 40)).clamp(0, 1),
              child: child,
            ),
          );
        },
        child: child,
      ),
    );
  }
}

class ProcessCard extends StatefulWidget {
  final String number;
  final String title;
  final String desc;
  final IconData icon;
  final Color glowColor;

  const ProcessCard(
      this.number,
      this.title,
      this.desc,
      this.icon,
      this.glowColor, {
        super.key,
      });

  @override
  State<ProcessCard> createState() => _ProcessCardState();
}

class _ProcessCardState extends State<ProcessCard> {
  bool hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => hovering = true),
      onExit: (_) => setState(() => hovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
        height: 220,

        transform: Matrix4.identity()
          ..translate(0.0, hovering ? -6 : 0.0),

        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.03),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.white.withOpacity(0.08)),
          boxShadow: hovering
              ? [
            BoxShadow(
              color: widget.glowColor.withOpacity(0.35),
              blurRadius: 25,
              spreadRadius: 1,
            )
          ]
              : [],
        ),

        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.number,
                style: TextStyle(
                  color: widget.glowColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Icon(widget.icon, color: Colors.white, size: 30),
              const SizedBox(height: 12),
              Text(
                widget.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                widget.desc,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}