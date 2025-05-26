import 'package:flutter/material.dart';
import 'package:sub_mind/Models/subscription.dart';
import 'package:sub_mind/services/subscription_service.dart';

class AddSubscriptionScreen extends StatefulWidget {
  const AddSubscriptionScreen({super.key});

  @override
  State<AddSubscriptionScreen> createState() => _AddSubscriptionScreenState();
}

class _AddSubscriptionScreenState extends State<AddSubscriptionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  bool _isMonthly = true;
  DateTime? _dueDate;

  void _submit() {
    if (_formKey.currentState!.validate() && _dueDate != null) {
      final newSub = Subscription(
        name: _nameController.text,
        price: double.parse(_priceController.text),
        isMonthly: _isMonthly,
        dueDate: _dueDate!,
        iconUrl: '',
      );
      SubscriptionService().add(newSub);
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Subscription')),
      resizeToAvoidBottomInset: true, // Ensures the body resizes when keyboard appears
      body: SingleChildScrollView( // Makes the content scrollable
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                  validator: (value) => value!.isEmpty ? 'Enter a name' : null,
                ),
                SizedBox(height: 12),
                TextFormField(
                  controller: _priceController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Price'),
                  validator: (value) => value!.isEmpty ? 'Enter a price' : null,
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Text('Billing Cycle:'),
                    SizedBox(width: 12),
                    DropdownButton<bool>(
                      value: _isMonthly,
                      items: const [
                        DropdownMenuItem(value: true, child: Text('Monthly')),
                        DropdownMenuItem(value: false, child: Text('Yearly')),
                      ],
                      onChanged: (value) => setState(() => _isMonthly = value!),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Text(_dueDate == null
                        ? 'Pick due date'
                        : 'Due: ${_dueDate!.toLocal().toString().split(' ')[0]}'),
                    Spacer(),
                    TextButton(
                      onPressed: () async {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(Duration(days: 365 * 5)),
                        );
                        if (picked != null) setState(() => _dueDate = picked);
                      },
                      child: Text('Select Date'),
                    ),
                  ],
                ),
                SizedBox(height: 24), // Add space before the button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _submit,
                    child: Text('Add Subscription'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}