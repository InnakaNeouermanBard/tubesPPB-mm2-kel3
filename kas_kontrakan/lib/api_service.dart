import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static final String baseUrl = 'http://localhost/flutter_api/';

  static Future<void> addTransaction(
      String username, double amount, String type, String description) async {
    final url = Uri.parse(baseUrl + 'create-transaction.php');
    final response = await http.post(
      url,
      body: {
        "username": username,
        "amount": amount.toString(),
        "type": type,
        "description": description,
      },
    );

    final responseData = json.decode(response.body);
    if (responseData['success']) {
      print(responseData['message']);
    } else {
      throw Exception('Failed to add transaction');
    }
  }

  static Future<void> deleteTransaction(int id) async {
    final url = Uri.parse(baseUrl + 'delete_transaction.php');
    final response = await http.post(
      url,
      body: {
        "id": id.toString(),
      },
    );

    final responseData = json.decode(response.body);
    if (responseData['success']) {
      print(responseData['message']);
    } else {
      throw Exception('Failed to delete transaction');
    }
  }

  static Future<void> updateTransaction(
      int id, String username, double amount, String description) async {
    final url = Uri.parse(baseUrl + 'update_transaction.php');
    final response = await http.post(
      url,
      body: {
        "id": id.toString(),
        "username": username,
        "amount": amount.toString(),
        "description": description,
      },
    );

    final responseData = json.decode(response.body);
    if (responseData['success']) {
      print(responseData['message']);
    } else {
      throw Exception('Failed to update transaction');
    }
  }
  // ApiService.dart

  static Future<double> getTotalKas() async {
    final url = Uri.parse('http://localhost/flutter_api/get_total.php');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      print('API Response: $jsonResponse'); // Debug log
      return double.parse(jsonResponse['total_kas'].toString());
    } else {
      throw Exception('Failed to load total kas');
    }
  }
}
