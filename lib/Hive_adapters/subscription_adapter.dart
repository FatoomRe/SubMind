// lib/adapters/subscription_adapter.dart
import 'package:hive/hive.dart';

part 'subscription_adapter.g.dart';

@HiveType(typeId: 0)
class Subscription extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  double price;

  @HiveField(2)
  bool isMonthly;

  @HiveField(3)
  DateTime dueDate;

  @HiveField(4)
  String logoUrl;

  Subscription({
    required this.name,
    required this.price,
    required this.isMonthly,
    required this.dueDate,
    required this.logoUrl,
  });
}
