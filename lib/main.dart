
import 'dart:async';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

void main() {
  runApp(const RamonCyberApp());
}

class RamonCyberApp extends StatelessWidget {
  const RamonCyberApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ramon Cyber Services',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFF0F172A), // Deep dark background for glass effect
        primaryColor: const Color(0xFF0059B3),
        textTheme: const TextTheme(
          headlineMedium: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          bodyMedium: TextStyle(color: Colors.white70, fontSize: 14),
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E293B),
        title: const Text('RAMON CYBER', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 1.2)),
        elevation: 0,
      ),
      body: Stack(
        children: [
          // Background Gradient Blobs to enhance the Frosted Glass effect
          Positioned(
            top: -50,
            left: -50,
            child: Container(
              width: 250,
              height: 250,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF00AEEF),
              ),
            ),
          ),
          Positioned(
            bottom: 100,
            right: -50,
            child: Container(
              width: 300,
              height: 300,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF0059B3),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 1. Slow Continuous Right-to-Left Running Banner (HCI Marquee)
                const RunningMarqueeBanner(
                  text: "Ramon Cyber and Digital Services — Fast, Reliable & Professional Digital Solutions — ",
                ),
                const SizedBox(height: 20),

                // 2. Service Cards Grid with Glassmorphism
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 420,
                      mainAxisExtent: 520, // Increased height to comfortably fit all detailed items
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                    ),
                    itemCount: detailedServices.length,
                    itemBuilder: (context, index) {
                      final service = detailedServices[index];
                      return GlassmorphicServiceCard(service: service);
                    },
                  ),
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ----------------------------------------------------
// CONTINUOUS MARQUEE BANNER (RIGHT TO LEFT)
// ----------------------------------------------------
class RunningMarqueeBanner extends StatefulWidget {
  final String text;
  const RunningMarqueeBanner({super.key, required this.text});

  @override
  State<RunningMarqueeBanner> createState() => _RunningMarqueeBannerState();
}

class _RunningMarqueeBannerState extends State<RunningMarqueeBanner> {
  late ScrollController _scrollController;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startScrolling();
    });
  }

  void _startScrolling() {
    _timer = Timer.periodic(const Duration(milliseconds: 30), (timer) {
      if (_scrollController.hasClients) {
        double maxExtent = _scrollController.position.maxScrollExtent;
        double currentOffset = _scrollController.offset;
        if (currentOffset >= maxExtent) {
          _scrollController.jumpTo(0);
        } else {
          _scrollController.jumpTo(currentOffset + 1.0); // Slow readable pace
        }
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF0A1931), Color(0xFF00AEEF)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                widget.text,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  letterSpacing: 1.1,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// ----------------------------------------------------
// GLASSMORPHIC CARD COMPONENT (FOGGY GLASS)
// ----------------------------------------------------
class GlassmorphicServiceCard extends StatelessWidget {
  final ServiceData service;

  const GlassmorphicServiceCard({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ui.ImageFilter.blur(sigmaX: 12.0, sigmaY: 12.0), // Foggy Blur Effect
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.12), // Semi-transparent overlay
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.white.withOpacity(0.25), // Frosting highlights
              width: 1.5,
            ),
          ),
          child: Column(
            children: [
              // Central Icon Header
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0xFF00AEEF).withOpacity(0.2),
                ),
                child: Icon(service.mainIcon, size: 36, color: const Color(0xFF00AEEF)),
              ),
              const SizedBox(height: 12),
              // Centered Service Title
              Text(
                service.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 12),
              const Divider(color: Colors.white24, height: 1),
              const SizedBox(height: 12),
              // Scrollable list of detailed items
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: service.items.length,
                  itemBuilder: (context, idx) {
                    final item = service.items[idx];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(item.icon, size: 18, color: const Color(0xFF38BDF8)),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              item.text,
                              style: TextStyle(color: Colors.white.withOpacity(0.9), fontSize: 13),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 8),
              // Action Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0059B3),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  onPressed: () {},
                  child: const Text('Enquire Now', style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ----------------------------------------------------
// DATA STRUCTURES
// ----------------------------------------------------
class ServiceItem {
  final IconData icon;
  final String text;
  ServiceItem({required this.icon, required this.text});
}

class ServiceData {
  final String title;
  final IconData mainIcon;
  final List<ServiceItem> items;

  ServiceData({required this.title, required this.mainIcon, required this.items});
}

final List<ServiceData> detailedServices = [
  ServiceData(
    title: 'Kenya Revenue Authority (KRA & eTIMS)',
    mainIcon: Icons.receipt_long_rounded,
    items: [
      ServiceItem(icon: Icons.person_add_alt_1_outlined, text: 'PIN Registration, Retrieval & Details Update'),
      ServiceItem(icon: Icons.upload_file_outlined, text: 'Filing NIL, PAYE, TOT & Rental Income Returns'),
      ServiceItem(icon: Icons.point_of_sale_outlined, text: 'eTIMS Onboarding, Catalog Setup & Credit Notes'),
      ServiceItem(icon: Icons.verified_user_outlined, text: 'Tax Compliance Certificates (TCC) & PRN Slips'),
    ],
  ),
  ServiceData(
    title: 'NTSA & TIMS Services',
    mainIcon: Icons.directions_car_filled_rounded,
    items: [
      ServiceItem(icon: Icons.badge_outlined, text: 'Smart DL Application, Renewal & PDL Booking'),
      ServiceItem(icon: Icons.swap_horiz_outlined, text: 'Vehicle Ownership Transfer & Logbook Applications'),
      ServiceItem(icon: Icons.build_circle_outlined, text: 'Inspection Slot Booking & Digital Certificates'),
      ServiceItem(icon: Icons.minor_crash_outlined, text: 'Commercial PSV/TSV Badges & Copy of Records'),
    ],
  ),
  ServiceData(
    title: 'Immigration & Civil Registration',
    mainIcon: Icons.fingerprint_rounded,
    items: [
      ServiceItem(icon: Icons.flight_takeoff_outlined, text: 'New Passports, Renewals & East African Permits'),
      ServiceItem(icon: Icons.security_outlined, text: 'Police Clearance (Good Conduct / DCI) Applications'),
      ServiceItem(icon: Icons.child_care_outlined, text: 'Birth & Death Certificate Applications/Searches'),
      ServiceItem(icon: Icons.favorite_border_outlined, text: 'Marriage Certificates & Notice Filings'),
    ],
  ),
  ServiceData(
    title: 'Social Health, Security & Welfare',
    mainIcon: Icons.health_and_safety_rounded,
    items: [
      ServiceItem(icon: Icons.medical_information_outlined, text: 'SHA (Afya Yangu) Profile & Dependents Registration'),
      ServiceItem(icon: Icons.account_balance_wallet_outlined, text: 'NSSF Member Registration & E-Statements'),
      ServiceItem(icon: Icons.wheelchair_pickup_outlined, text: 'NCPWD Disability Assessment & Registration'),
    ],
  ),
  ServiceData(
    title: 'Business, Land & Legal Portals',
    mainIcon: Icons.account_balance_rounded,
    items: [
      ServiceItem(icon: Icons.business_outlined, text: 'BRS Business Name Reservation, CR12 & CBO Registrations'),
      ServiceItem(icon: Icons.landscape_outlined, text: 'ArdhiSasa Land Searches, Title Verification & Rent'),
      ServiceItem(icon: Icons.school_outlined, text: 'HELB Loans, HEF Scholarships & KUCCPS Placement'),
      ServiceItem(icon: Icons.gavel_outlined, text: 'Judiciary Court e-Filing & County Business Permits'),
    ],
  ),
  ServiceData(
    title: 'Document Processing & Printing',
    mainIcon: Icons.print_rounded,
    items: [
      ServiceItem(icon: Icons.color_lens_outlined, text: 'High-Speed B/W, Vibrant Color & Photo Printing'),
      ServiceItem(icon: Icons.edit_note_outlined, text: 'Typesetting, CV Drafting & Company Profiles'),
      ServiceItem(icon: Icons.layers_outlined, text: 'Heat Lamination, Spiral & Hard-Cover Binding'),
      ServiceItem(icon: Icons.scanner_outlined, text: 'High-Res Scanning, OCR & PDF Conversion'),
    ],
  ),
  ServiceData(
    title: 'Digital Media, Transfers & Storage',
    mainIcon: Icons.folder_zip_rounded,
    items: [
      ServiceItem(icon: Icons.movie_outlined, text: 'Movies, Series & Single/Album Music Loading'),
      ServiceItem(icon: Icons.usb_outlined, text: 'Flash Drive, OTG Phone & External Drive Transfers'),
      ServiceItem(icon: Icons.cloud_sync_outlined, text: 'Google Drive/iCloud Backups & Large File Transfer'),
      ServiceItem(icon: Icons.developer_board_outlined, text: 'Bootable OS USB Flashing & Driver Installation'),
    ],
  ),
  ServiceData(
    title: 'Design & Graphic Services',
    mainIcon: Icons.palette_rounded,
    items: [
      ServiceItem(icon: Icons.design_services_outlined, text: 'Flyers, Posters, Banners & Logo Layouts'),
      ServiceItem(icon: Icons.menu_book_outlined, text: 'CBC Educational Charts & Study Diagrams'),
      ServiceItem(icon: Icons.celebration_outlined, text: 'Funeral Programs, Wedding Cards & Event Banners'),
      ServiceItem(icon: Icons.auto_fix_high_outlined, text: 'Photo Background Removal & Image Upscaling'),
    ],
  ),
];

