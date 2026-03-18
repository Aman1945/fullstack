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
      backgroundColor: Color(0xFF0F172A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(widget.task == null ? 'Add New Task' : 'Edit Task', 
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _titleController,
                style: TextStyle(color: Colors.white),
                decoration: _inputDecoration('Task Title', Icons.title),
                validator: (val) => val!.isEmpty ? 'Enter title' : null,
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _descController,
                style: TextStyle(color: Colors.white),
                maxLines: 4,
                decoration: _inputDecoration('Description', Icons.description_outlined),
                validator: (val) => val!.isEmpty ? 'Enter description' : null,
              ),
              SizedBox(height: 32),
              ElevatedButton(
                onPressed: _loading ? null : _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF6366F1),
                  padding: EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: _loading
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text(widget.task == null ? 'Create Task' : 'Update Task', 
                      style: TextStyle(fontSize: 18, color: Colors.white)),
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
      labelStyle: TextStyle(color: Colors.white60),
      prefixIcon: Icon(icon, color: Colors.white60),
      filled: true,
      fillColor: Colors.white.withOpacity(0.05),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Color(0xFF6366F1)),
      ),
    );
  }
}
