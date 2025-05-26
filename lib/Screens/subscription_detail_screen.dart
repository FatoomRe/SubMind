import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sub_mind/Models/subscription.dart';

class SubscriptionDetailScreen extends StatelessWidget {
  final Subscription subscription;

  const SubscriptionDetailScreen({super.key, required this.subscription});

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat.yMMMMd();
    return Scaffold(
      appBar: AppBar(
        title: Text(subscription.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Icon(
                Icons.subscriptions,
                size: 100,
                color: Colors.blueAccent,
              ),
            ),
            SizedBox(height: 24),
            Text(
              'Name:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(subscription.name, style: TextStyle(fontSize: 18)),
            SizedBox(height: 12),
            Text(
              'Price:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text('₹${subscription.price.toStringAsFixed(2)}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 12),
            Text(
              'Billing Cycle:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(subscription.isMonthly ? 'Monthly' : 'Yearly', style: TextStyle(fontSize: 18)),
            SizedBox(height: 12),
            Text(
              'Next Due Date:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(formatter.format(subscription.dueDate), style: TextStyle(fontSize: 18)),
            Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back),
                label: Text('Back'),
              ),
            )
          ],
        ),
      ),
    );
  }
}