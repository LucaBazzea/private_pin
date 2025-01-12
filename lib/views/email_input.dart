import "dart:convert";

import "package:flutter/material.dart";

import "package:http/http.dart" as http;

class EmailInput extends StatefulWidget {
  const EmailInput({Key? key}) : super(key: key);

  @override
  State<EmailInput> createState() => _EmailInputState();
}

class _EmailInputState extends State<EmailInput> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isEmailSent = false;
  bool _isError = false;

  Future<void> _postEmail() async {
    if (_formKey.currentState!.validate()) {
      print(_emailController.text);

      final url = Uri.parse("http://192.168.110.37:8000/app/login/otp/send/");
      final body = {"email": _emailController.text};
      final response = await http.post(url,
          headers: {
            "accept": "*/*",
            "Content-Type": "application/json",
          },
          body: jsonEncode(body));

      if (response.statusCode == 200) {
        setState(() {
          _isEmailSent = true;
          _isError = false;
        });
      } else {
        setState(() {
          _isEmailSent = false;
          _isError = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Email Input"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an email';
                  } else if (!value.contains("@") && !value.contains(".")) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _postEmail,
                child: const Text('Send Email'),
              ),
              if (_isEmailSent)
                const Text("Email sent successfully")
              else if (_isError)
                const Text("Failed to send email")
            ],
          ),
        ),
      ),
    );
  }
}
