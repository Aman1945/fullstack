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
            style: TextStyle(fontWeight: FontWeight.black, color: Color(0xFF0F172A), letterSpacing: -0.5)),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(color: Color(0xFFE2E8F0)),
            ),
            child: IconButton(
              icon: Icon(Icons.logout_rounded, color: Color(0xFFEF4444), size: 20),
              onPressed: () {
                authProvider.logout();
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (_) => LoginScreen()),
                );
              },
            ),
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => taskProvider.fetchTasks(),
        displacement: 20,
        color: Color(0xFF0066FF),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello, ${user?.name ?? 'User'}',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.black, color: Color(0xFF0F172A), letterSpacing: -1),
              ),
              SizedBox(height: 4),
              Text(
                'Let\'s see your productivity today',
                style: TextStyle(color: Color(0xFF64748B), fontSize: 16),
              ),
              SizedBox(height: 32),
              Row(
                children: [
                  Expanded(
                    child: _StatCard(
                      title: 'Total Tasks',
                      count: taskProvider.stats['total'] ?? 0,
                      color: Color(0xFF0066FF),
                      icon: Icons.grid_view_rounded,
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: _StatCard(
                      title: 'Completed',
                      count: taskProvider.stats['completed'] ?? 0,
                      color: Color(0xFF10B981),
                      icon: Icons.check_circle_rounded,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              _StatCard(
                title: 'Pending Tasks',
                count: taskProvider.stats['pending'] ?? 0,
                color: Color(0xFFF59E0B),
                icon: Icons.timer_rounded,
                fullWidth: true,
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Quick Actions',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.black, color: Color(0xFF0F172A), letterSpacing: -0.5),
                  ),
                ],
              ),
              SizedBox(height: 20),
              _ActionButton(
                title: 'Task Manager',
                subtitle: 'Add, edit or organize your workflow',
                icon: Icons.checklist_rounded,
                color: Color(0xFF0066FF),
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => TaskListScreen()),
                ),
              ),
              SizedBox(height: 16),
              _ActionButton(
                title: 'Website Enquiries',
                subtitle: 'New leads and contact requests',
                icon: Icons.chat_bubble_outline_rounded,
                color: Color(0xFF6366F1),
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => EnquiryScreen()),
                ),
              ),
              SizedBox(height: 24),
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
      padding: EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF0066FF).withOpacity(0.04),
            blurRadius: 20,
            offset: Offset(0, 8),
          ),
        ],
        border: Border.all(color: Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          SizedBox(height: 20),
          Text(
            count.toString(),
            style: TextStyle(fontSize: 36, fontWeight: FontWeight.black, color: Color(0xFF0F172A), letterSpacing: -1),
          ),
          SizedBox(height: 2),
          Text(title, style: TextStyle(color: Color(0xFF64748B), fontWeight: FontWeight.w600, fontSize: 13)),
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
      borderRadius: BorderRadius.circular(30),
      child: Container(
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Color(0xFF0066FF).withOpacity(0.04),
              blurRadius: 20,
              offset: Offset(0, 8),
            ),
          ],
          border: Border.all(color: Color(0xFFE2E8F0)),
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, 
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.black, color: Color(0xFF0F172A))),
                  SizedBox(height: 2),
                  Text(subtitle, style: TextStyle(color: Color(0xFF64748B), fontSize: 13, fontWeight: FontWeight.w500)),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Color(0xFFCBD5E1)),
          ],
        ),
      ),
    );
  }
}
