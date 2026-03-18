import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import '../models/task_model.dart';
import 'add_task_screen.dart';
import 'package:intl/intl.dart';

class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  String _filter = 'all';

  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<TaskProvider>(context, listen: false).fetchTasks());
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    
    List<TaskModel> filteredTasks = taskProvider.tasks;
    if (_filter == 'completed') {
      filteredTasks = taskProvider.tasks.where((t) => t.status == 'completed').toList();
    } else if (_filter == 'pending') {
      filteredTasks = taskProvider.tasks.where((t) => t.status == 'pending').toList();
    }

    return Scaffold(
      backgroundColor: Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Color(0xFF0066FF)),
        title: Text('My Tasks', 
            style: TextStyle(fontWeight: FontWeight.black, color: Color(0xFF0F172A), letterSpacing: -0.5)),
      ),
      body: Column(
        children: [
          _buildFilterBar(),
          Expanded(
            child: taskProvider.isLoading
                ? Center(child: CircularProgressIndicator(color: Color(0xFF0066FF)))
                : filteredTasks.isEmpty
                    ? _buildEmptyState()
                    : ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                        itemCount: filteredTasks.length,
                        itemBuilder: (context, index) {
                          final task = filteredTasks[index];
                          return _TaskCard(task: task);
                        },
                      ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 4,
        backgroundColor: Color(0xFF0066FF),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => AddTaskScreen()),
        ),
        child: Icon(Icons.add_rounded, color: Colors.white, size: 28),
      ),
    );
  }

  Widget _buildFilterBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFF1F5F9))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _filterChip('All Tasks', 'all'),
          _filterChip('Pending', 'pending'),
          _filterChip('Completed', 'completed'),
        ],
      ),
    );
  }

  Widget _filterChip(String label, String value) {
    bool isSelected = _filter == value;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        if (selected) setState(() => _filter = value);
      },
      selectedColor: Color(0xFF0066FF),
      backgroundColor: Color(0xFFF1F5F9),
      showCheckmark: false,
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : Color(0xFF64748B),
        fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
        fontSize: 13,
      ),
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      shape: StadiumBorder(side: BorderSide(color: Colors.transparent)),
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
              color: Color(0xFFF0F7FF),
              shape: BoxShape.circle,
            ),
            child: Icon(Icons.assignment_rounded, size: 64, color: Color(0xFF0066FF)),
          ),
          SizedBox(height: 24),
          Text('No tasks here yet', 
              style: TextStyle(color: Color(0xFF0F172A), fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Text('Tap the + button to add your first task', 
              style: TextStyle(color: Color(0xFF64748B), fontSize: 16)),
        ],
      ),
    );
  }
}

class _TaskCard extends StatelessWidget {
  final TaskModel task;

  const _TaskCard({required this.task});

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context, listen: false);

    return Dismissible(
      key: Key(task.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 24),
        margin: EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Color(0xFFEF4444),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Icon(Icons.delete_rounded, color: Colors.white),
      ),
      onDismissed: (_) => taskProvider.deleteTask(task.id),
      child: Container(
        margin: EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Color(0xFF0066FF).withOpacity(0.04),
              blurRadius: 20,
              offset: Offset(0, 8),
            ),
          ],
          border: Border.all(color: Color(0xFFE2E8F0)),
        ),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          leading: Container(
            height: 44,
            width: 44,
            child: Checkbox(
              value: task.status == 'completed',
              activeColor: Color(0xFF0066FF),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
              onChanged: (_) => taskProvider.toggleTaskStatus(task),
            ),
          ),
          title: Text(
            task.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Color(0xFF0F172A),
              fontWeight: FontWeight.bold,
              fontSize: 17,
              decoration: task.status == 'completed' ? TextDecoration.lineThrough : null,
              decorationColor: Color(0xFF94A3B8),
            ),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 4),
              Text(
                task.description, 
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(color: Color(0xFF64748B), height: 1.4, fontSize: 14),
              ),
              SizedBox(height: 12),
              Row(
                children: [
                  Icon(Icons.calendar_today_rounded, size: 12, color: Color(0xFF94A3B8)),
                  SizedBox(width: 6),
                  Text(
                    DateFormat('MMM dd, yyyy').format(task.createdAt),
                    style: TextStyle(color: Color(0xFF94A3B8), fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ],
          ),
          trailing: IconButton(
            icon: Icon(Icons.chevron_right_rounded, color: Color(0xFFCBD5E1)),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => AddTaskScreen(task: task)),
            ),
          ),
        ),
      ),
    );
  }
}
