import 'package:flutter/material.dart';
import 'package:sub_mind/Models/subscription.dart';
import 'package:intl/intl.dart';

class SubscriptionCard extends StatelessWidget {
  final Subscription subscription;

  SubscriptionCard({required this.subscription});

  @override
  Widget build(BuildContext context) {
    final daysLeft = subscription.dueDate.difference(DateTime.now()).inDays;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(subscription.iconUrl),
            radius: 24,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(subscription.name, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                Text(
                  '${subscription.price.toInt()} SAR / ${subscription.isMonthly ? 'month' : 'year'}',
                  style: TextStyle(color: Colors.grey[700]),
                ),
                if (daysLeft > 0)
                  Text('Due in $daysLeft days', style: TextStyle(fontSize: 12, color: Colors.red)),
              ],
            ),
          ),
          const Icon(Icons.chevron_right),
        ],
      ),
    );
  }
}
