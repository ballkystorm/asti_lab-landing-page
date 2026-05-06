import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Navbar extends StatelessWidget {
  final Function(String section) onNavigate;

  const Navbar({
    super.key,
    required this.onNavigate,
  });

  void openWhatsApp() async {
    final Uri url = Uri.parse(
      "https://wa.me/2349139097783?text=Hi%20I%20want%20to%20build%20an%20app",
    );
    await launchUrl(url, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 40,
        vertical: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// 🔥 LOGO (CLICKABLE)
          GestureDetector(
            onTap: () => onNavigate("home"),
            child: const Text(
              "ASTI Labs",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          if (!isMobile)
            Row(
              children: [
                navItem("Home", "home"),
                navItem("Services", "services"),
                navItem("Process", "process"),
                navItem("Portfolio", "portfolio"),
                navItem("Pricing", "pricing"),

                const SizedBox(width: 20),

                /// 🔥 PREMIUM CTA BUTTON
                MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: GestureDetector(
                    onTap: openWhatsApp,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 22,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFFFF6A00),
                            Color(0xFFFFA040),
                          ],
                        ),
                      ),
                      child: const Text(
                        "Start Project",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
          else
            PopupMenuButton<String>(
              icon: const Icon(Icons.menu, color: Colors.white),
              onSelected: (value) {
                if (value == "whatsapp") {
                  openWhatsApp();
                } else {
                  onNavigate(value);
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(value: "home", child: Text("Home")),
                const PopupMenuItem(value: "services", child: Text("Services")),
                const PopupMenuItem(value: "process", child: Text("Process")),
                const PopupMenuItem(value: "portfolio", child: Text("Portfolio")),
                const PopupMenuItem(value: "pricing", child: Text("Pricing")),
                const PopupMenuItem(value: "whatsapp", child: Text("Start Project")),
              ],
            ),
        ],
      ),
    );
  }

  Widget navItem(String text, String section) {
    return _HoverNavItem(
      text: text,
      onTap: () => onNavigate(section),
    );
  }

}


class _HoverNavItem extends StatefulWidget {
  final String text;
  final VoidCallback onTap;

  const _HoverNavItem({
    required this.text,
    required this.onTap,
  });

  @override
  State<_HoverNavItem> createState() => _HoverNavItemState();
}

class _HoverNavItemState extends State<_HoverNavItem> {
  bool hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => hover = true),
      onExit: (_) => setState(() => hover = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          transform: Matrix4.identity()..scale(hover ? 1.08 : 1.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.text,
                style: TextStyle(
                  color: hover
                      ? const Color(0xFFFF6A00)
                      : Colors.white70,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 4),

              /// 🔥 animated underline
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 2,
                width: hover ? 20 : 0,
                color: const Color(0xFFFF6A00),
              ),
            ],
          ),
        ),
      ),
    );
  }
}