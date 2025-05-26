import 'package:flutter/material.dart';
import 'package:sub_mind/services/subscription_service.dart';
import 'package:sub_mind/widgets/subscription_card.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  SubscriptionService get _service => SubscriptionService();

  @override
  Widget build(BuildContext context) {
    final subscriptions = _service.getAll();
    final monthlyTotal = subscriptions
        .where((s) => s.isMonthly)
        .fold<double>(0.0, (sum, item) => sum + item.price);
    final yearlyTotal = subscriptions
        .where((s) => !s.isMonthly)
        .fold<double>(0.0, (sum, item) => sum + item.price);

    return Scaffold(
      backgroundColor: Color(0xFFFCF8F5),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'SubMind',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4),
              Text(
                'Monthly: ${monthlyTotal.toStringAsFixed(0)} SAR   Yearly: ${yearlyTotal.toStringAsFixed(0)} SAR',
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
              SizedBox(height: 16),
              Expanded(
                child:
                    subscriptions.isEmpty
                        ? Center(child: Text('No subscriptions yet.'))
                        : ListView.builder(
                          itemCount: subscriptions.length,
                          itemBuilder: (context, index) {
                            final sub = subscriptions[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 12.0),
                              child: SubscriptionCard(subscription: sub),
                            );
                          },
                        ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        onPressed: () async {
          await Navigator.pushNamed(context, '/add');
          setState(() {});
        },
        shape: const CircleBorder(),
        elevation: 6,
        child: Icon(Icons.add, color: Colors.white, size: 32),
      ),
    );
  }
}
