import 'package:hive/hive.dart';
import 'package:sub_mind/Models/subscription.dart';

class SubscriptionService {
  final _box = Hive.box<Subscription>('subscriptions');

  List<Subscription> getAll() => _box.values.toList();

  void add(Subscription s) => _box.add(s);

  void delete(Subscription s) => s.delete();

  void update(Subscription s) => s.save();
}
