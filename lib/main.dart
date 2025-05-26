import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sub_mind/Models/subscription.dart';
import 'package:sub_mind/Screens/add_subscription_screen.dart';
import 'package:sub_mind/Screens/home_screen.dart';
import 'package:sub_mind/Screens/subscription_detail_screen.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(SubscriptionAdapter());
  await Hive.openBox<Subscription>('subscriptions');
  runApp(SubMindApp());
}

class SubMindApp extends StatelessWidget {
  const SubMindApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SubMind',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'SF Pro Display'),
      initialRoute: '/',
      routes: {
        '/': (_) => HomeScreen(),
        '/add': (_) => AddSubscriptionScreen(),
        '/detail': (context) {
          final subscription = ModalRoute.of(context)!.settings.arguments as Subscription;
          return SubscriptionDetailScreen(subscription: subscription);
        },
      },
    );
  }
}
