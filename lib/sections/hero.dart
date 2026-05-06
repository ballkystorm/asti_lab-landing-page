import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/navbar.dart';

class HeroSection extends StatelessWidget {
  final Function(String section) onNavigate;

  const HeroSection({
    super.key,
    required this.onNavigate,
  });

  void openWhatsApp() async {
    final Uri url = Uri.parse(
      "https://wa.me/2349139097783?text=Hello%20I%20have%20an%20app%20idea",
    );
    await launchUrl(url);
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 40),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF0D0D0D),
            Color(0xFF1A0F0A),
            Color(0xFF000000),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        image: const DecorationImage(
          image: AssetImage("assets/images/bg.jpg"),
          fit: BoxFit.cover,
          opacity: 0.3,
        ),
      ),
      child: Column(
        children: [

          Navbar(onNavigate: onNavigate),

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 80),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1200),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: isMobile
                      ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      textSection(context),
                      const SizedBox(height: 40),
                      imageSection(),
                    ],
                  )
                      : Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(flex: 2, child: textSection(context)),
                      const SizedBox(width: 60),
                      Expanded(flex: 1, child: imageSection()),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  // 🔥 UPDATED TEXT SECTION
  Widget textSection(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 800;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            style: TextStyle(
              fontSize: isMobile ? 32 : 48,
              fontWeight: FontWeight.bold,
              height: 1.2,
            ),
            children: const [
              TextSpan(
                text: "Premium Mobile & Web Apps\nBuilt for ",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),

              TextSpan(
                text: "Startups",
                style: TextStyle(
                  color: Color(0xFFFF6A00),
                ),
              ),

              TextSpan(
                text: " and\nGrowing Businesses",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),

        const Text(
          "We help you turn your idea into a fully functional mobile app — fast, scalable, and ready for users.",
          style: TextStyle(
            color: Colors.white70,
            fontSize: 18,
          ),
        ),

        const SizedBox(height: 40),

        // 🔥 NEW PREMIUM WHATSAPP BUTTON
        WhatsAppButton(onTap: openWhatsApp),
      ],
    );
  }

  Widget imageSection() {
    return Image.asset(
      "assets/images/phone.png",
      height: 450,
    );
  }
}






// 🔥 PREMIUM BUTTON (ADD THIS IN SAME FILE OR SEPARATE FILE)
class WhatsAppButton extends StatefulWidget {
  final VoidCallback onTap;

  const WhatsAppButton({super.key, required this.onTap});

  @override
  State<WhatsAppButton> createState() => _WhatsAppButtonState();
}

class _WhatsAppButtonState extends State<WhatsAppButton> {
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
          transform: Matrix4.identity()
            ..scale(hover ? 1.05 : 1.0),
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40),
            gradient: const LinearGradient(
              colors: [Color(0xFFFF6A00), Color(0xFFFFA040)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFFF6A00)
                    .withOpacity(hover ? 0.6 : 0.3),
                blurRadius: hover ? 30 : 15,
                spreadRadius: hover ? 4 : 1,
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const [
              Icon(Icons.chat_bubble, color: Colors.white, size: 20),
              SizedBox(width: 10),
              Text(
                "Get Your App Started",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}