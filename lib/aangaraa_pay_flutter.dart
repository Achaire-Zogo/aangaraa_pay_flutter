import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'aangaraa_pay_flutter_platform_interface.dart';

class AangaraaPayFlutter extends AangaraaPayFlutterPlatform {
  /// Effectuer un paiement
  Future<Map<String, dynamic>> initiatePayment({
    required String operator,
    required String amount,
    required String currency,
    required String phoneNumber,
    String? description,
    required String transactionId,
    required String returnUrl,
    required String notifyUrl,
    required String apiKey,
    required String baseUrl,
  }) async {
    try {
      validatePaymentData(amount, phoneNumber);

      final payload = {
        'phone_number': phoneNumber,
        'amount': amount,
        'description': description,
        'app_key': apiKey,
        'transaction_id': transactionId,
        'return_url': returnUrl,
        'notify_url': notifyUrl,
        'operator': operator,
      };

      final response = await http.post(
        Uri.parse('$baseUrl/direct_payment'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(payload),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Payment failed: ${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to initiate payment: $e');
    }
  }

  /// Vérifier le statut d'une transaction
  Future<Map<String, dynamic>> checkTransactionStatus({
    required String payToken,
    required String appKey,
    required String baseUrl,
  }) async {
    try {
      final payload = {
        'payToken': payToken,
        'app_key': appKey,
      };

      final response = await http.post(
        Uri.parse('$baseUrl/aangaraa_check_status'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(payload),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to retrieve transaction status: ${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to check transaction status: $e');
    }
  }

  /// Retirer de l'argent
  Future<Map<String, dynamic>> withdrawMoney({
    required String phoneNumber,
    required String amount,
    required String username,
    required String notifyUrl,
    required String fees,
    required String apiKey,
    required String baseUrl,
  }) async {
    try {
      final payload = {
        'phone_number': phoneNumber,
        'amount': amount,
        'username': username,
        'notify_url': notifyUrl,
        'fees': fees,
        'app_key': apiKey,
      };

      final response = await http.post(
        Uri.parse('$baseUrl/aangaraa_withdraw_money'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(payload),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Withdrawal failed: ${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to withdraw money: $e');
    }
  }

  /// Validates payment data
  void validatePaymentData(String amount, String phoneNumber) {
    if (amount.isEmpty || double.tryParse(amount) == null || double.parse(amount) <= 0) {
      throw Exception('Invalid amount');
    }
    if (phoneNumber.isEmpty) {
      throw Exception('Phone number is required');
    }
  }

  @override
  Future<String?> getPlatformVersion() async {
    // Here you can implement the logic to get the platform version
    // For example, you can return a hardcoded value or fetch it from the platform
    return '1.0.0'; // Replace with actual version fetching logic if needed
  }
}
