import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import 'package:intl/intl.dart';

class EnquiryScreen extends StatefulWidget {
  @override
  _EnquiryScreenState createState() => _EnquiryScreenState();
}

class _EnquiryScreenState extends State<EnquiryScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<TaskProvider>(context, listen: false).fetchContacts());
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);

    return Scaffold(
      backgroundColor: Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Color(0xFF0F172A)),
        title: Text('Website Enquiries', 
            style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
      ),
      body: taskProvider.isLoading
          ? Center(child: CircularProgressIndicator(color: Color(0xFF6366F1)))
          : taskProvider.contacts.isEmpty
              ? _buildEmptyState()
              : ListView.builder(
                  padding: EdgeInsets.all(16),
                  itemCount: taskProvider.contacts.length,
                  itemBuilder: (context, index) {
                    final contact = taskProvider.contacts[index];
                    return _ContactCard(contact: contact);
                  },
                ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.mail_outline, size: 80, color: Colors.slate.shade200),
          SizedBox(height: 16),
          Text('No enquiries yet', 
              style: TextStyle(color: Colors.slate.shade400, fontSize: 18)),
        ],
      ),
    );
  }
}

class _ContactCard extends StatelessWidget {
  final dynamic contact;

  const _ContactCard({required this.contact});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: Offset(0, 5),
          ),
        ],
        border: Border.all(color: Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                backgroundColor: Color(0xFF6366F1).withOpacity(0.1),
                child: Text(contact.name[0].toUpperCase(), 
                    style: TextStyle(color: Color(0xFF6366F1), fontWeight: FontWeight.bold)),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(contact.name, 
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF0F172A))),
                    Text(contact.email, 
                        style: TextStyle(color: Colors.slate.shade500, fontSize: 14)),
                  ],
                ),
              ),
            ],
          ),
          Divider(height: 32, color: Color(0xFFF1F5F9)),
          Text(contact.message, 
              style: TextStyle(color: Color(0xFF334155), height: 1.5)),
          SizedBox(height: 16),
          Align(
            alignment: Alignment.bottomRight,
            child: Text(
              DateFormat('MMM dd, hh:mm a').format(contact.createdAt),
              style: TextStyle(color: Colors.slate.shade300, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
