import 'package:flutter/material.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();

  bool _otpSent = false;

  void _sendOtp() {
    // Simulate sending OTP
    setState(() {
      _otpSent = true;
    });
  }

  void _verifyOtp() {
    // Simulate OTP verification
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('OTP verified successfully')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forgot Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Forgot Password',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.inversePrimary,
                  fontWeight: FontWeight.bold,
                )
              ),
              const SizedBox(height: 20),
              if (!_otpSent)
                Column(
                  children: [
                    _buildPhoneNumberInput(),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (_phoneController.text.isNotEmpty) {
                          _sendOtp();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Please enter your phone number')),
                          );
                        }
                      },
                      child: const Text('Send OTP'),
                    ),
                  ],
                )
              else
                Column(
                  children: [
                    _buildOtpInput(),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (_otpController.text.isNotEmpty) {
                          _verifyOtp();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Please enter the OTP')),
                          );
                        }
                      },
                      child: const Text('Verify OTP'),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPhoneNumberInput() {
    return TextField(
      controller: _phoneController,
      keyboardType: TextInputType.phone,
      decoration: const InputDecoration(
        labelText: 'Phone Number',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.phone),
      ),
    );
  }

  Widget _buildOtpInput() {
    return TextField(
      controller: _otpController,
      keyboardType: TextInputType.number,
      decoration: const InputDecoration(
        labelText: 'Enter OTP',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.lock),
      ),
    );
  }
}
