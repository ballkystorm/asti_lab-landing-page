import 'package:asti_labs/sections/cta.dart';
import 'package:asti_labs/sections/footer.dart';
import 'package:asti_labs/sections/portfolio.dart';
import 'package:asti_labs/sections/pricing.dart';
import 'package:asti_labs/sections/process.dart';
import 'package:asti_labs/sections/testimonials.dart';
import 'package:flutter/material.dart';
import 'sections/hero.dart';
import 'sections/services.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final scrollController = ScrollController();

  final homeKey = GlobalKey();
  final servicesKey = GlobalKey();
  final processKey = GlobalKey();
  final portfolioKey = GlobalKey();
  final testimonialsKey = GlobalKey();
  final pricingKey = GlobalKey();
  final contactKey = GlobalKey();

  final ValueNotifier<String> activeSection = ValueNotifier("home");

  double scrollOffset = 0;

  @override
  void initState() {
    super.initState();

    scrollController.addListener(() {
      setState(() {
        scrollOffset = scrollController.offset;
      });

      _detectSection();
    });
  }

  void _detectSection() {
    final sections = {
      "home": homeKey,
      "services": servicesKey,
      "process": processKey,
      "portfolio": portfolioKey,
      "testimonials": testimonialsKey,
      "pricing": pricingKey,
      "contact": contactKey,
    };

    for (var entry in sections.entries) {
      final context = entry.value.currentContext;
      if (context != null) {
        final box = context.findRenderObject() as RenderBox;
        final position = box.localToGlobal(Offset.zero).dy;

        if (position <= 150 && position >= -200) {
          activeSection.value = entry.key;
          break;
        }
      }
    }
  }

  void scrollTo(GlobalKey key, String section) {
    activeSection.value = section;

    Scrollable.ensureVisible(
      key.currentContext!,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
    );
  }

  void handleNav(String section) {
    if (section == "home") scrollTo(homeKey, "home");
    if (section == "services") scrollTo(servicesKey, "services");
    if (section == "process") scrollTo(processKey, "process");
    if (section == "portfolio") scrollTo(portfolioKey, "portfolio");
    if (section == "testimonials") scrollTo(testimonialsKey, "testimonials");
    if (section == "pricing") scrollTo(pricingKey, "pricing");
    if (section == "contact") scrollTo(contactKey, "contact");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: scrollController,
            child: Column(
              children: [
                HeroSection(
                  key: homeKey,
                  onNavigate: handleNav,
                ),

                ServicesSection(key: servicesKey),
                ProcessSection(key: processKey),
                PortfolioSection(key: portfolioKey),
                TestimonialsSection(key: testimonialsKey),
                PricingSection(key: pricingKey),
                CTASection(),
                FooterSection(
                  key: contactKey,
                  onNavigate: handleNav,
                ),
              ],
            ),
          ),

          const FloatingWhatsApp(),
        ],
      ),
    );
  }
}