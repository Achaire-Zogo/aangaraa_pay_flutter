import 'package:flutter/material.dart';
import 'package:aangaraa_pay_flutter/aangaraa_pay_flutter.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AangaraaPayFlutter _aangaraaPayPlugin = AangaraaPayFlutter();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  String _paymentStatus = '';

  @override
  void initState() {
    super.initState();
  }



  Future<void> _makePayment(String operator) async {
    try {
      setState(() {
        _paymentStatus = 'Processing $operator Payment...';
      });

      final result = await _aangaraaPayPlugin.initiatePayment(
        operator: operator,
        amount: _amountController.text,
        currency: 'XAF',
        phoneNumber: _phoneController.text,
        description: 'Test payment',
        transactionId: DateTime.now().millisecondsSinceEpoch.toString(),
        returnUrl: 'YOUR_RETURN_URL',
        notifyUrl: 'YOUR_NOTIFY_URL',
        apiKey: 'YOUR_API_KEY',
        baseUrl: 'YOUR_API_BASE_URL',
      );

      setState(() {
        _paymentStatus = '${operator} Payment Status: ${result['status']}';
      });

      // Vérifier le statut après quelques secondes
      if (result['transaction_id'] != null) {
        await Future.delayed(const Duration(seconds: 5));
        final status = await _aangaraaPayPlugin.checkTransactionStatus(
          payToken: result['transaction_id'],
          appKey: 'YOUR_API_KEY',
          baseUrl: 'YOUR_API_BASE_URL',
        );
        setState(() {
          _paymentStatus = 'Final Status: ${status['status']}';
        });
      }
    } catch (e) {
      setState(() {
        _paymentStatus = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Aangaraa Pay Example'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _phoneController,
                decoration: const InputDecoration(
                  labelText: 'Phone Number',
                  hintText: 'Enter phone number',
                ),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _amountController,
                decoration: const InputDecoration(
                  labelText: 'Amount',
                  hintText: 'Enter amount in XAF',
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () => _makePayment('MTN'),
                    child: const Text('Pay with MTN'),
                  ),
                  ElevatedButton(
                    onPressed: () => _makePayment('Orange_Cameroon'),
                    child: const Text('Pay with Orange'),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Text(
                _paymentStatus,
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _amountController.dispose();
    super.dispose();
  }
}
