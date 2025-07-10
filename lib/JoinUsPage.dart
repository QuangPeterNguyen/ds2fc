import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:easy_localization/easy_localization.dart';

class JoinUsPage extends StatefulWidget {
  const JoinUsPage({super.key});

  @override
  State<JoinUsPage> createState() => _JoinUsPageState();
}

class _JoinUsPageState extends State<JoinUsPage> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final messageController = TextEditingController();

  void _sendEmail() async {
    final name = nameController.text;
    final email = emailController.text;
    final message = messageController.text;

    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'ds2fc.club@gmail.com',
      queryParameters: {
        'subject': 'Join Đ.S 2 FC / Contact Form',
        'body': 'Name: $name\nEmail: $email\n\n$message',
      },
    );

    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('join_us.error_open_email'.tr())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('join_us.title'.tr())),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text(
                'join_us.subtitle'.tr(),
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'join_us.name'.tr()),
                validator: (value) =>
                    value!.isEmpty ? 'join_us.error_name'.tr() : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(labelText: 'join_us.email'.tr()),
                validator: (value) =>
                    value!.isEmpty ? 'join_us.error_email'.tr() : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: messageController,
                decoration:
                    InputDecoration(labelText: 'join_us.message'.tr()),
                maxLines: 5,
                validator: (value) =>
                    value!.isEmpty ? 'join_us.error_message'.tr() : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _sendEmail();
                  }
                },
                icon: const Icon(Icons.send),
                label: Text('join_us.send'.tr()),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}