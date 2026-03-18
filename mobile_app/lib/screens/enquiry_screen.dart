import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import 'package:intl/intl.dart';

class EnquiryScreen extends StatefulWidget {
  @override
  _EnquiryScreenState createState() => _EnquiryScreenState();
}

import '../models/contact_model.dart';

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
        centerTitle: true,
        iconTheme: IconThemeData(color: Color(0xFF0F172A)),
        title: Text('Website Enquiries', 
            style: TextStyle(fontWeight: FontWeight.black, color: Color(0xFF0F172A), letterSpacing: -0.5)),
      ),
      body: taskProvider.isLoading
          ? Center(child: CircularProgressIndicator(color: Color(0xFF0066FF)))
          : taskProvider.contacts.isEmpty
               ? _buildEmptyState()
               : ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
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
          Container(
            padding: EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: Color(0xFFEBF2FF),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.mark_email_unread_rounded, size: 64, color: Color(0xFF0066FF)),
          ),
          SizedBox(height: 24),
          Text('No enquiries yet', 
              style: TextStyle(color: Color(0xFF0F172A), fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text('Messages from the website will appear here', 
              style: TextStyle(color: Color(0xFF64748B), fontSize: 16)),
        ],
      ),
    );
  }
}

class _ContactCard extends StatelessWidget {
  final ContactModel contact;

  const _ContactCard({required this.contact});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF0066FF).withOpacity(0.06),
            blurRadius: 30,
            offset: Offset(0, 10),
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
                radius: 24,
                backgroundColor: Color(0xFF0066FF).withOpacity(0.1),
                child: Text(contact.name[0].toUpperCase(), 
                    style: TextStyle(color: Color(0xFF0066FF), fontWeight: FontWeight.bold, fontSize: 18)),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(contact.name, 
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Color(0xFF0F172A))),
                    Text(contact.email, 
                        style: TextStyle(color: Color(0xFF64748B), fontSize: 14)),
                  ],
                ),
              ),
            ],
          ),
          if (contact.phone != null && contact.phone!.isNotEmpty) ...[
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Color(0xFFF0F7FF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.phone_rounded, size: 16, color: Color(0xFF0066FF)),
                  SizedBox(width: 8),
                  Text(
                    contact.phone!,
                    style: TextStyle(color: Color(0xFF0066FF), fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                ],
              ),
            ),
          ],
          Divider(height: 48, color: Color(0xFFF1F5F9)),
          Text(contact.message, 
              style: TextStyle(color: Color(0xFF334155), fontSize: 15, height: 1.6)),
          SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Received',
                style: TextStyle(color: Color(0xFF94A3B8), fontSize: 12, fontWeight: FontWeight.w600),
              ),
              Text(
                DateFormat('MMM dd, hh:mm a').format(contact.createdAt),
                style: TextStyle(color: Color(0xFF0066FF), fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
