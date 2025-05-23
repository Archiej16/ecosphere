import 'package:flutter/material.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import '../models/recycling_item.dart';

class BarcodeScanPage extends StatefulWidget {
  @override
  _BarcodeScanPageState createState() => _BarcodeScanPageState();
}

class _BarcodeScanPageState extends State<BarcodeScanPage> {
  String _scanResult = '';
  RecyclingItem? _scannedItem;
  bool _isLoading = false;
  String _errorMessage = '';

  Future<void> _scanBarcode() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      final result = await BarcodeScanner.scan();
      setState(() {
        _scanResult = result.rawContent;
        _isLoading = false;
      });
      _identifyItem(_scanResult);
    } catch (e) {
      setState(() {
        _errorMessage = 'Error scanning barcode: $e';
        _isLoading = false;
      });
    }
  }

  void _identifyItem(String barcode) {
    // In a real app, this would query a database or API
    // For demo purposes, we'll just use a sample item
    final items = RecyclingItem.getSampleItems();
    
    // Simulate finding an item based on barcode
    // In reality, you would match the barcode to a database
    setState(() {
      if (barcode.isNotEmpty) {
        // Just for demo - assign a random item from our samples
        final randomIndex = barcode.hashCode % items.length;
        _scannedItem = items[randomIndex.abs()];
      } else {
        _scannedItem = null;
        _errorMessage = 'No barcode detected';
      }
    });
  }

  void _addToRecycled() {
    if (_scannedItem != null) {
      // In a real app, this would update the user's profile
      // and add points to their account
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Added ${_scannedItem!.name} to your recycled items!\n+${_scannedItem!.pointsValue} points!'),
          backgroundColor: Colors.green,
        ),
      );
      
      // Reset the scan
      setState(() {
        _scanResult = '';
        _scannedItem = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan Recyclable Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Scan the barcode on your recyclable item to identify it and earn points!',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: _isLoading ? null : _scanBarcode,
              icon: Icon(Icons.qr_code_scanner),
              label: Text('Scan Barcode'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 12),
              ),
            ),
            SizedBox(height: 20),
            if (_isLoading)
              Center(child: CircularProgressIndicator()),
            if (_errorMessage.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  _errorMessage,
                  style: TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
              ),
            if (_scannedItem != null) ...[  
              SizedBox(height: 20),
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Item Identified:',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      SizedBox(height: 8),
                      Text('Name: ${_scannedItem!.name}'),
                      Text('Category: ${_scannedItem!.category}'),
                      Text('Recyclable: ${_scannedItem!.isRecyclable ? "Yes" : "No"}'),
                      SizedBox(height: 8),
                      Text('Points Value: ${_scannedItem!.pointsValue}'),
                      Text('Carbon Saved: ${_scannedItem!.carbonSaved} kg'),
                      SizedBox(height: 8),
                      Text(
                        'Recycling Instructions:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(_scannedItem!.recyclingInstructions),
                      SizedBox(height: 16),
                      if (_scannedItem!.isRecyclable)
                        ElevatedButton(
                          onPressed: _addToRecycled,
                          child: Text('Confirm Recycling'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}