import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'api_service.dart';
import 'transaction.dart';

class HomePage extends StatefulWidget {
  final String username;

  const HomePage(this.username, {Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController amountController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  double totalKas = 0.0; // Menyimpan total dari database
  List<Transaction> transactions = [];

  @override
  void initState() {
    super.initState();
    _fetchTotalKas();
    _fetchTransactions();
  }

  Future _fetchTotalKas() async {
    try {
      double total = await ApiService.getTotalKas();
      setState(() {
        totalKas = total;
      });
    } catch (e) {
      print('Failed to load total kas: $e');
    }
  }

  Future<void> _fetchTransactions() async {
    try {
      final url =
          Uri.parse('http://localhost/flutter_api/get_transactions.php');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        List jsonResponse = json.decode(response.body);
        setState(() {
          transactions = jsonResponse
              .map((transaction) => Transaction.fromJson(transaction))
              .toList();
        });
      } else {
        throw Exception('Failed to load transactions');
      }
    } catch (e) {
      print('Failed to load transactions: $e');
    }
  }

  Future<void> _saveTransaction(String type) async {
    try {
      await ApiService.addTransaction(
        widget.username,
        double.parse(amountController.text),
        type,
        descriptionController.text,
      );

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Transaction added successfully'),
          duration: Duration(seconds: 2),
        ),
      );
      amountController.clear();
      descriptionController.clear();
      _fetchTotalKas();
      _fetchTransactions();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to add transaction: $e'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> _deleteTransaction(int id) async {
    try {
      await ApiService.deleteTransaction(id);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Transaction deleted successfully'),
          duration: Duration(seconds: 2),
        ),
      );
      _fetchTotalKas();
      _fetchTransactions();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to delete transaction: $e'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> _updateTransaction(Transaction transaction) async {
    amountController.text = transaction.amount.toString();
    descriptionController.text = transaction.description;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Update Transaction'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Enter amount',
                  labelText: 'Amount',
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: descriptionController,
                decoration: InputDecoration(
                  hintText: 'Enter description',
                  labelText: 'Description',
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  await ApiService.updateTransaction(
                    transaction.id,
                    widget.username,
                    double.parse(amountController.text),
                    descriptionController.text,
                  );

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Transaction updated successfully'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                  Navigator.of(context).pop(); // Close dialog
                  amountController.clear();
                  descriptionController.clear();
                  await _fetchTotalKas(); // Fetch total kas again
                  await _fetchTransactions(); // Fetch transactions again
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Failed to update transaction: $e'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                }
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var totalKas1 = totalKas;
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            onPressed: () {}, // Logout action
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Welcome!',
                              style: TextStyle(
                                  fontSize: 12.0,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w300)),
                          Text(
                            widget.username,
                            style: const TextStyle(
                                fontSize: 16.0,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.notifications))
                    ],
                  ),
                ),
                Container(
                  constraints: BoxConstraints(
                    minHeight: 100,
                    minWidth: 100,
                    maxWidth: MediaQuery.of(context).size.width,
                  ),
                  child: Card(
                    color: const Color(0XFFFFECAA),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Rp. ${totalKas.toStringAsFixed(1)},-',
                            style: TextStyle(
                                fontSize: 28.0,
                                fontFamily: 'Poppins',
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text('Japak Bonjer',
                                  style: TextStyle(
                                      fontSize: 18.0,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.w400)),
                              Icon(Icons.add_card_rounded)
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16.0,
                ),
                const Text('Riwayat',
                    style: TextStyle(
                        fontSize: 16.0,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold)),
                const SizedBox(
                  height: 8.0,
                ),
                if (transactions.isEmpty)
                  Center(
                    child: Text('No transactions yet.'),
                  )
                else
                  Column(
                    children: transactions.map((transaction) {
                      return ListTile(
                        title: Text(transaction.description),
                        subtitle: Text(
                          '${transaction.amount} (${transaction.type})',
                        ),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                _updateTransaction(transaction);
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.delete),
                              onPressed: () {
                                _deleteTransaction(transaction.id);
                              },
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        focusColor: const Color(0XFFFFECAA),
        hoverColor: const Color(0XFFFFC500),
        backgroundColor: const Color(0XFFFED138),
        onPressed: () {
          _showAddTransactionDialog();
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: const Color.fromARGB(246, 246, 246, 246),
        shape: const CircularNotchedRectangle(),
        notchMargin: 5,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.home_rounded),
              tooltip: 'Menu',
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.add_card),
              tooltip: 'Calendar',
            ),
            const SizedBox(
              width: 10,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showAddTransactionDialog() async {
    amountController.clear();
    descriptionController.clear();
    String selectedType = 'pemasukan'; // default to pemasukan

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Transaction'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Enter amount',
                  labelText: 'Amount',
                ),
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: descriptionController,
                decoration: InputDecoration(
                  hintText: 'Enter description',
                  labelText: 'Description',
                ),
              ),
              const SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Radio<String>(
                    value: 'pemasukan',
                    groupValue: selectedType,
                    onChanged: (value) {
                      setState(() {
                        selectedType = value!;
                      });
                    },
                  ),
                  const Text('Pemasukan'),
                  Radio<String>(
                    value: 'pengeluaran',
                    groupValue: selectedType,
                    onChanged: (value) {
                      setState(() {
                        selectedType = value!;
                      });
                    },
                  ),
                  const Text('Pengeluaran'),
                ],
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (amountController.text.isNotEmpty &&
                    descriptionController.text.isNotEmpty) {
                  _saveTransaction(selectedType);
                  Navigator.of(context).pop();
                }
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
