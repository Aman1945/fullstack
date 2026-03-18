import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import '../models/task_model.dart';

class AddTaskScreen extends StatefulWidget {
  final TaskModel? task;

  const AddTaskScreen({Key? key, this.task}) : super(key: key);

  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  late TextEditingController _titleController;
  late TextEditingController _descController;
  final _formKey = GlobalKey<FormState>();
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task?.title ?? '');
    _descController = TextEditingController(text: widget.task?.description ?? '');
  }

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _loading = true);
      
      String? error;
      if (widget.task == null) {
        error = await Provider.of<TaskProvider>(context, listen: false)
            .addTask(_titleController.text, _descController.text);
      } else {
        error = await Provider.of<TaskProvider>(context, listen: false)
            .updateTask(widget.task!.id, _titleController.text, _descController.text);
      }
      
      if (error == null) {
        Navigator.of(context).pop();
      } else {
        setState(() => _loading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error), backgroundColor: Colors.red),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Color(0xFF0066FF)),
        title: Text(widget.task == null ? 'Create New Task' : 'Edit Task Details', 
            style: TextStyle(fontWeight: FontWeight.w400, color: Color(0xFF0F172A), letterSpacing: -0.5)),
        actions: [
          if (widget.task != null)
            IconButton(
              icon: Icon(Icons.delete_outline_rounded, color: Color(0xFFEF4444)),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    title: Text('Delete Task?'),
                    content: Text('Are you sure you want to remove this task?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('Cancel', style: TextStyle(color: Color(0xFF64748B))),
                      ),
                      TextButton(
                        onPressed: () async {
                          await Provider.of<TaskProvider>(context, listen: false).deleteTask(widget.task!.id);
                          Navigator.pop(context); // Close dialog
                          Navigator.pop(context); // Go back to list
                        },
                        child: Text('Delete', style: TextStyle(color: Color(0xFFEF4444), fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                );
              },
            )
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _titleController,
                style: TextStyle(color: Color(0xFF0F172A), fontWeight: FontWeight.w600),
                decoration: _inputDecoration('Task Title', Icons.edit_note_rounded),
                validator: (val) => val!.isEmpty ? 'Please enter a title' : null,
              ),
              SizedBox(height: 24),
              TextFormField(
                controller: _descController,
                style: TextStyle(color: Color(0xFF0F172A)),
                maxLines: 6,
                decoration: _inputDecoration('Task Description', Icons.description_rounded),
                validator: (val) => val!.isEmpty ? 'Please enter a description' : null,
              ),
              SizedBox(height: 48),
              ElevatedButton(
                onPressed: _loading ? null : _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF0066FF),
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 20),
                  elevation: 0,
                  shadowColor: Color(0xFF0066FF).withOpacity(0.3),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                ),
                child: _loading
                  ? SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                    )
                  : Text(widget.task == null ? 'Create Task now' : 'Save Task Changes', 
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      labelStyle: TextStyle(color: Color(0xFF64748B), fontWeight: FontWeight.w500),
      prefixIcon: Icon(icon, color: Color(0xFF0066FF), size: 24),
      filled: true,
      fillColor: Colors.white,
      contentPadding: EdgeInsets.all(24),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color: Color(0xFFE2E8F0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color: Color(0xFF0066FF), width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color: Color(0xFFEF4444)),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color: Color(0xFFEF4444), width: 2),
      ),
    );
  }
}
