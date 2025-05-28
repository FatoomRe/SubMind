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
      backgroundColor: const Color(0xFFFCF8F5),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          'Add Subscription',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
            fontSize: 26,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black87),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name Field
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 8,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                    ),
                    validator: (value) => value!.isEmpty ? 'Enter a name' : null,
                  ),
                ),
                SizedBox(height: 18),
                // Price Field
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 8,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextFormField(
                    controller: _priceController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Price',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                    ),
                    validator: (value) => value!.isEmpty ? 'Enter a price' : null,
                  ),
                ),
                SizedBox(height: 18),
                // Billing Cycle Dropdown
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 8,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Text('Billing Cycle:', style: TextStyle(fontSize: 16)),
                      SizedBox(width: 12),
                      DropdownButton<bool>(
                        value: _isMonthly,
                        underline: SizedBox(),
                        items: const [
                          DropdownMenuItem(value: true, child: Text('Monthly')),
                          DropdownMenuItem(value: false, child: Text('Yearly')),
                        ],
                        onChanged: (value) => setState(() => _isMonthly = value!),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 18),
                // Due Date Picker
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 8,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Text(
                        _dueDate == null
                            ? 'Pick due date'
                            : 'Due: ${_dueDate!.toLocal().toString().split(' ')[0]}',
                        style: TextStyle(fontSize: 16),
                      ),
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
                ),
                SizedBox(height: 32),
                // Add Button with gradient
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      elevation: 4,
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.deepPurple.withOpacity(0.2),
                    ),
                    onPressed: _submit,
                    child: Ink(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Colors.purpleAccent, Colors.deepPurple.shade400],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          'Add Subscription',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
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