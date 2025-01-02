class EmailInput extends StatefulWidget {
  const EmailInput({Key? key}) : super(key: key);

  @override
  State<EmailInput> createState() => _EmailInputState();
}

class _EmailInputState extends State<EmailInput> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  Future<void> _postEmail() async {
    if (_formKey.currentState!.validate()) {
      final url = Uri.parse('https://your-endpoint.com/email');
      final response = await http.post(url, body: {'email': _emailController.text});

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Email sent successfully')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to send email')),
        );
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
                  } else if (!value.contains('@')) {
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
            ],
          ),
        ),
      ),
    );
  }
}
