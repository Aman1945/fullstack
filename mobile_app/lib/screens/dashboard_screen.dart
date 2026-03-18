import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/task_provider.dart';
import 'task_list_screen.dart';
import 'enquiry_screen.dart';
import 'login_screen.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<TaskProvider>(context, listen: false).fetchTasks());
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final taskProvider = Provider.of<TaskProvider>(context);
    final user = authProvider.user;

    return Scaffold(
      backgroundColor: Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text('Dashboard', 
            style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Color(0xFF0F172A)),
            onPressed: () {
              authProvider.logout();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => LoginScreen()),
              );
            },
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => taskProvider.fetchTasks(),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello, ${user?.name ?? 'User'}!',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
              ),
              SizedBox(height: 8),
              Text(
                'Here is your task summary',
                style: TextStyle(color: Colors.slate.shade500, fontSize: 16),
              ),
              SizedBox(height: 32),
              Row(
                children: [
                  Expanded(
                    child: _StatCard(
                      title: 'Total',
                      count: taskProvider.stats['total'] ?? 0,
                      color: Color(0xFF6366F1),
                      icon: Icons.list_alt,
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: _StatCard(
                      title: 'Completed',
                      count: taskProvider.stats['completed'] ?? 0,
                      color: Colors.green.shade600,
                      icon: Icons.check_circle_outline,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              _StatCard(
                title: 'Pending Tasks',
                count: taskProvider.stats['pending'] ?? 0,
                color: Colors.orange.shade600,
                icon: Icons.pending_actions,
                fullWidth: true,
              ),
              SizedBox(height: 40),
              Text(
                'Quick Actions',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
              ),
              SizedBox(height: 16),
              _ActionButton(
                title: 'Manage Tasks',
                subtitle: 'Add, Edit or Delete your tasks',
                icon: Icons.task,
                color: Color(0xFF6366F1),
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => TaskListScreen()),
                ),
              ),
              SizedBox(height: 12),
              _ActionButton(
                title: 'Website Enquiries',
                subtitle: 'Check messages from visitors',
                icon: Icons.contact_page_outlined,
                color: Color(0xFF8B5CF6),
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => EnquiryScreen()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final int count;
  final Color color;
  final IconData icon;
  final bool fullWidth;

  const _StatCard({
    required this.title,
    required this.count,
    required this.color,
    required this.icon,
    this.fullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
        border: Border.all(color: Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 32),
          SizedBox(height: 16),
          Text(
            count.toString(),
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF0F172A)),
          ),
          SizedBox(height: 4),
          Text(title, style: TextStyle(color: Colors.slate.shade500)),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _ActionButton({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
          border: Border.all(color: Color(0xFFE2E8F0)),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, 
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF0F172A))),
                  Text(subtitle, style: TextStyle(color: Colors.slate.shade500)),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, size: 16, color: Colors.slate.shade300),
          ],
        ),
      ),
    );
  }
}
