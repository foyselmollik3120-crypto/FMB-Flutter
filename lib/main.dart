import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'app_config.dart';

void main() {
  runApp(const FmbApp());
}

class FmbApp extends StatelessWidget {
  const FmbApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FMB App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MainHomeScreen(),
    );
  }
}

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({super.key});

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen> {
  String _apiResponse = "Testing backend connection...";
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _checkBackendStatus();
  }

  Future<void> _checkBackendStatus() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.get(Uri.parse(AppConfig.baseUrl));
      if (response.statusCode == 200) {
        setState(() {
          _apiResponse = "Success! Server Response: ${response.body}";
        });
      } else {
        setState(() {
          _apiResponse = "Server connected with status code: ${response.statusCode}";
        });
      }
    } catch (e) {
      setState(() {
        _apiResponse = "Connection failed: $e";
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FMB Dashboard', style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              color: Colors.deepPurple.shade50,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Backend Server Status',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.deepPurple),
                    ),
                    const SizedBox(height: 10),
                    _isLoading
                        ? const CircularProgressIndicator()
                        : Text(
                            _apiResponse,
                            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                          ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _checkBackendStatus,
              icon: const Icon(Icons.refresh),
              label: const Text('Test Connection Again'),
            ),
          ],
        ),
      ),
    );
  }
}
