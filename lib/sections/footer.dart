import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FooterSection extends StatelessWidget {
  final Function(String section) onNavigate;

  const FooterSection({
    super.key,
    required this.onNavigate,
  });

  void openWhatsApp() async {
    final Uri url = Uri.parse(
      "https://wa.me/2349139097783?text=Hi%20I%20want%20to%20build%20an%20app.%20Can%20you%20help%20me?",
    );
    await launchUrl(url);
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile ? 20 : 40,
        vertical: 60,
      ),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.6),
        border: Border(
          top: BorderSide(color: Colors.white.withOpacity(0.1)),
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Column(
            children: [
              isMobile
                  ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _footerContent(),
              )
                  : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _footerContent(),
              ),

              const SizedBox(height: 40),

              Container(
                height: 1,
                color: Colors.white.withOpacity(0.1),
              ),

              const SizedBox(height: 20),

              const Text(
                "© 2026 ASTI Labs. All rights reserved.",
                style: TextStyle(color: Colors.white54, fontSize: 12),
              )
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _footerContent() {
    return [
      /// BRAND
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "ASTI Labs",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "We help you turn your idea into a fully functional mobile app — fast and scalable.",
              style: TextStyle(color: Colors.white70),
            ),
          ],
        ),
      ),

      const SizedBox(width: 40, height: 20),

      /// LINKS (🔥 HOVER ENABLED)
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Links",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),

            _HoverFooterLink("Home", () => onNavigate("home")),
            _HoverFooterLink("Services", () => onNavigate("services")),
            _HoverFooterLink("Portfolio", () => onNavigate("portfolio")),
            _HoverFooterLink("Contact", () => onNavigate("contact")),
          ],
        ),
      ),

      const SizedBox(width: 40, height: 20),

      /// CONTACT
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Contact",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),

            GestureDetector(
              onTap: openWhatsApp,
              child: const Text(
                "Chat on WhatsApp",
                style: TextStyle(
                  color: Color(0xFFFF6A00),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 6),

            const Text(
              "Usually replies within 5 minutes",
              style: TextStyle(color: Colors.green, fontSize: 12),
            ),

            const SizedBox(height: 10),

            const Text(
              "astilabsupport@gmail.com",
              style: TextStyle(color: Colors.white70),
            ),
          ],
        ),
      ),
    ];
  }
}

/// 🔥 HOVER FOOTER LINK
class _HoverFooterLink extends StatefulWidget {
  final String text;
  final VoidCallback onTap;

  const _HoverFooterLink(this.text, this.onTap);

  @override
  State<_HoverFooterLink> createState() => _HoverFooterLinkState();
}

class _HoverFooterLinkState extends State<_HoverFooterLink> {
  bool hover = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => hover = true),
      onExit: (_) => setState(() => hover = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 200),
          style: TextStyle(
            color: hover
                ? const Color(0xFFFF6A00)
                : Colors.white70,
            fontWeight: hover ? FontWeight.bold : FontWeight.normal,
          ),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 6),
            child: Text(widget.text),
          ),
        ),
      ),
    );
  }
}