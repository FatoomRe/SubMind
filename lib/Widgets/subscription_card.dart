import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sub_mind/Models/subscription.dart';
import 'package:sub_mind/Utils/logo_picker.dart';

class SubscriptionCard extends StatelessWidget {
  final Subscription subscription;

  const SubscriptionCard({super.key, required this.subscription});

  @override
  Widget build(BuildContext context) {
    final formatter = DateFormat.yMMMd();
    return Container(
      height: 90,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.purpleAccent, Colors.deepPurple.shade400],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        leading: CircleAvatar(
          backgroundImage: AssetImage(getLogoAsset(subscription.name)),
          backgroundColor: Colors.white,
          radius: 24,
        ),
        title: Text(
          subscription.name,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        subtitle: Text(
          '${subscription.price.toStringAsFixed(2)} SAR • ${formatter.format(subscription.dueDate)}',
          style: const TextStyle(color: Colors.white70),
        ),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.white),
      ),
    );
  }
}