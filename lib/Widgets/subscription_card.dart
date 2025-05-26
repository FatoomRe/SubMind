import 'package:flutter/material.dart';
import 'package:sub_mind/Models/subscription.dart';
import 'package:intl/intl.dart';

class SubscriptionCard extends StatelessWidget {
  final Subscription subscription;

  const SubscriptionCard({super.key, required this.subscription});

  @override
  Widget build(BuildContext context) {
    final daysLeft = subscription.dueDate.difference(DateTime.now()).inDays;
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (ctx) => SafeArea(
            child: Wrap(
              children: [
                ListTile(
                  leading: Icon(Icons.info),
                  title: Text('View Details'),
                  onTap: () {
                    Navigator.pop(ctx);
                    // Implement navigation to details screen if available
                    // Navigator.pushNamed(context, '/detail', arguments: subscription);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.edit),
                  title: Text('Edit'),
                  onTap: () {
                    Navigator.pop(ctx);
                    // Implement navigation to edit screen if available
                    // Navigator.pushNamed(context, '/edit', arguments: subscription);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.delete, color: Colors.red),
                  title: Text('Delete', style: TextStyle(color: Colors.red)),
                  onTap: () {
                    Navigator.pop(ctx);
                    showDialog(
                      context: context,
                      builder: (dialogCtx) => AlertDialog(
                        title: Text('Delete Subscription'),
                        content: Text('Are you sure you want to delete this subscription?'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(dialogCtx),
                            child: Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              // Add your delete logic here
                              Navigator.pop(dialogCtx);
                            },
                            child: Text('Delete', style: TextStyle(color: Colors.red)),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
      child: Container(
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
      ),
    );
  }
}