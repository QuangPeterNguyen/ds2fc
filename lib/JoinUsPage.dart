import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

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

  Future<void> _sendEmail() async {
  final serviceId = 'service_e232d8q';
  final templateId = 'template_hp7xvg8';
  final publicKey = 'OZK9TzN-ypEQtxYZu';

  final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
  final response = await http.post(
    url,
    headers: {
      'origin': 'http://ds2fc.club',
      'Content-Type': 'application/json',
    },
    body: json.encode({
      'service_id': serviceId,
      'template_id': templateId,
      'user_id': publicKey,
      'template_params': {
        'name': nameController.text,
        'email': emailController.text,
        'message': messageController.text,
      }
    }),
  );

  if (response.statusCode == 200) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('join_us.success'.tr())),
    );
    nameController.clear();
    emailController.clear();
    messageController.clear();
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('join_us.error_send'.tr())),
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