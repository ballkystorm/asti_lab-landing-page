import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FloatingWhatsApp extends StatefulWidget {
  const FloatingWhatsApp({super.key});

  @override
  State<FloatingWhatsApp> createState() => _FloatingWhatsAppState();
}

class _FloatingWhatsAppState extends State<FloatingWhatsApp>
    with SingleTickerProviderStateMixin {
  bool isHovered = false;
  bool isVisible = false;

  late AnimationController _controller;
  late Animation<double> _pulse;

  void openWhatsApp() async {
    final Uri url = Uri.parse(
      "https://wa.me/2349139097783?text=Hello%20I%20have%20an%20app%20idea",
    );
    await launchUrl(url, mode: LaunchMode.externalApplication);
  }

  @override
  void initState() {
    super.initState();

    /// 🔥 Pulse animation
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _pulse = Tween<double>(begin: 1, end: 1.08).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    /// 🔥 DELAY APPEAR (better UX)
    Future.delayed(const Duration(milliseconds: 1200), () {
      if (mounted) setState(() => isVisible = true);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;

    return AnimatedPositioned(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,

      /// 🔥 SLIDE IN EFFECT
      bottom: isVisible ? 30 : -100,
      right: 30,

      child: MouseRegion(
        onEnter: (_) => setState(() => isHovered = true),
        onExit: (_) => setState(() => isHovered = false),
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: openWhatsApp,
          child: ScaleTransition(
            scale: _pulse,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOut,

              /// 🔥 WIDTH LOGIC
              width: isMobile
                  ? 170
                  : (isHovered ? 170 : 60),

              height: 60,
              padding: const EdgeInsets.symmetric(horizontal: 12),

              decoration: BoxDecoration(
                color: const Color(0xFF25D366),
                borderRadius: BorderRadius.circular(40),
                boxShadow: [
                  BoxShadow(
                    color: Colors.green.withOpacity(0.6),
                    blurRadius: isHovered ? 30 : 18,
                    spreadRadius: isHovered ? 6 : 2,
                  ),
                ],
              ),

              child: Row(
                children: [
                  const Icon(
                    Icons.chat,
                    color: Colors.white,
                    size: 26,
                  ),

                  /// 🔥 TEXT CONTROL
                  Expanded(
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 200),
                      opacity: (isMobile || isHovered) ? 1 : 0,
                      child: const Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Text(
                          "Start your app",
                          overflow: TextOverflow.fade,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}