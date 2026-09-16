import 'package:flutter/material.dart';
import 'theme.dart';

class EnquiryDialog extends StatefulWidget {
  final String serviceTitle;

  const EnquiryDialog({super.key, required this.serviceTitle});

  @override
  State<EnquiryDialog> createState() => _EnquiryDialogState();
}

class _EnquiryDialogState extends State<EnquiryDialog> {
  final _formKey = GlobalKey<FormState>();
  final _contactController = TextEditingController();
  final _messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Enquire: ${widget.serviceTitle}', style: const TextStyle(color: RamonTheme.primaryText)),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _contactController,
                decoration: const InputDecoration(
                  labelText: 'Phone Number or Email *',
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value == null || value.isEmpty ? 'Please enter contact details' : null,
              ),
              const SizedBox(height: 15),
              TextFormField(
                controller: _messageController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'How can we help you?',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Enquiry sent successfully!')),
              );
              Navigator.pop(context);
            }
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }
}