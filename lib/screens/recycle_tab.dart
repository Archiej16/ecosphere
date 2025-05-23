import 'package:flutter/material.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import '../models/recycling_item.dart';

class RecycleTab extends StatefulWidget {
  @override
  _RecycleTabState createState() => _RecycleTabState();
}

class _RecycleTabState extends State<RecycleTab> {
  RecyclingItem? _scannedItem;
  bool _isScanning = false;
  String _errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _scannedItem == null ? _buildScanView() : _buildResultView(),
    );
  }

  Widget _buildScanView() {
    return Column(
      children: [
        Expanded(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Scan frame
                Container(
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.green, width: 2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.camera_alt,
                        size: 80,
                        color: Colors.green.withOpacity(0.5),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Position the barcode in the frame',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40),
                // Scan button
                ElevatedButton.icon(
                  onPressed: _isScanning ? null : _scanBarcode,
                  icon: Icon(Icons.qr_code_scanner),
                  label: Text('Scan Item'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                if (_errorMessage.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      _errorMessage,
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildResultView() {
    final item = _scannedItem!;
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Item image with recyclable badge
                Stack(
                  alignment: Alignment.center,
                  children: [
                    // Image container
                    Container(
                      height: 300,
                      width: double.infinity,
                      color: Colors.grey.shade200,
                      child: item.imageUrl.isNotEmpty
                          ? Image.network(
                              item.imageUrl,
                              fit: BoxFit.contain,
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(
                                  Icons.local_drink,
                                  size: 100,
                                  color: Colors.grey,
                                );
                              },
                            )
                          : Icon(
                              Icons.local_drink,
                              size: 100,
                              color: Colors.grey,
                            ),
                    ),
                    // Recyclable badge
                    Positioned(
                      top: 20,
                      right: 20,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 4,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              item.isRecyclable ? Icons.check_circle : Icons.cancel,
                              color: item.isRecyclable ? Colors.green : Colors.red,
                              size: 18,
                            ),
                            SizedBox(width: 4),
                            Text(
                              item.isRecyclable ? 'Recyclable' : 'Not Recyclable',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: item.isRecyclable ? Colors.green : Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                // Item details
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Item name and category
                      Row(
                        children: [
                          Icon(Icons.local_drink, color: Colors.green),
                          SizedBox(width: 8),
                          Text(
                            item.name,
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      // Recycling instructions
                      Text(
                        'Recycling Instructions:',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text(item.recyclingInstructions),
                      SizedBox(height: 16),
                      // Points value
                      Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.green.shade100,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'My Points',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '${item.pointsValue}',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 24),
                      // Recycle button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _addToRecycled,
                          child: Text('Recycle This Item'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.symmetric(vertical: 16),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      // Scan another button
                      SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () {
                            setState(() {
                              _scannedItem = null;
                            });
                          },
                          child: Text('Scan Another Item'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.green,
                            side: BorderSide(color: Colors.green),
                            padding: EdgeInsets.symmetric(vertical: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _scanBarcode() async {
    setState(() {
      _isScanning = true;
      _errorMessage = '';
    });

    try {
      final result = await BarcodeScanner.scan();
      _identifyItem(result.rawContent);
    } catch (e) {
      setState(() {
        _errorMessage = 'Error scanning barcode: $e';
        _isScanning = false;
      });
    }
  }

  void _identifyItem(String barcode) {
    // In a real app, this would query a database or API
    // For demo purposes, we'll just use a sample item
    final items = RecyclingItem.getSampleItems();
    
    // Simulate finding an item based on barcode
    setState(() {
      _isScanning = false;
      if (barcode.isNotEmpty) {
        // Just for demo - assign a random item from our samples
        final randomIndex = barcode.hashCode % items.length;
        _scannedItem = items[randomIndex.abs()];
      } else {
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
        _scannedItem = null;
      });
    }
  }
}