import 'package:flutter/material.dart';

class CyberService {
  final String title;
  final String description;
  final IconData icon;

  CyberService({required this.title, required this.description, required this.icon});
}

final List<CyberService> cyberServicesList = [
  CyberService(
    title: 'Document Processing & Printing',
    description: 'High-quality color & B/W printing, scanning, laminating, and typesetting.',
    icon: Icons.print,
  ),
  CyberService(
    title: 'eCitizen & Government Portals',
    description: 'KRA PIN, filing returns, driving licenses, passport applications, and portal navigation.',
    icon: Icons.account_balance,
  ),
  CyberService(
    title: 'Design & Typesetting',
    description: 'Custom graphics, posters, business profiles, and document formatting.',
    icon: Icons.design_services,
  ),
  CyberService(
    title: 'High-Speed Internet Access',
    description: 'Reliable high-speed web browsing, research, and downloads.',
    icon: Icons.wifi,
  ),
];