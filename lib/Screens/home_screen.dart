import 'package:flutter/material.dart';
import 'package:sub_mind/services/subscription_service.dart';
import 'package:sub_mind/widgets/subscription_card.dart';

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
                            return Dismissible(
                              key: ValueKey(sub.key),
                              // Use Hive key for uniqueness
                              direction: DismissDirection.endToStart,
                              background: Container(
  margin: const EdgeInsets.only(
    bottom: 12.0,
  ), // Match the card's bottom padding
  decoration: BoxDecoration(
    color: Colors.redAccent,
    // Only round the right side (so the left is flush under the card)
    borderRadius: BorderRadius.only(
      topRight: Radius.circular(18),
      bottomRight: Radius.circular(18),
      // No left radius!
    ),
  ),
  alignment: Alignment.centerRight,
  padding: EdgeInsets.symmetric(horizontal: 20),
  child: Icon(
    Icons.delete,
    color: Colors.white,
    size: 32,
  ),
),
                              confirmDismiss: (direction) async {
                                return await showDialog(
                                  context: context,
                                  builder:
                                      (ctx) => AlertDialog(
                                        title: Text('Delete Subscription'),
                                        content: Text(
                                          'Are you sure you want to delete "${sub.name}"?',
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed:
                                                () => Navigator.of(
                                                  ctx,
                                                ).pop(false),
                                            child: Text('Cancel'),
                                          ),
                                          TextButton(
                                            onPressed:
                                                () =>
                                                    Navigator.of(ctx).pop(true),
                                            child: Text(
                                              'Delete',
                                              style: TextStyle(
                                                color: Colors.red,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                );
                              },
                              onDismissed: (direction) {
                                setState(() {
                                  _service.delete(sub);
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('${sub.name} deleted'),
                                  ),
                                );
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 12.0),
                                child: SubscriptionCard(subscription: sub),
                              ),
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
