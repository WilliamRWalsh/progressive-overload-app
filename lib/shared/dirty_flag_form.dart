import 'package:flutter/material.dart';

class DirtyFlagForm extends StatefulWidget {
  DirtyFlagForm({required this.child});

  Widget child;

  @override
  _DirtyFlagFormState createState() => _DirtyFlagFormState();
}

class _DirtyFlagFormState extends State<DirtyFlagForm> {
  final _formKey = GlobalKey<FormState>();
  bool _dirty = false;
  String _name = '';
  String _email = '';

  void _onChanged() {
    setState(() {
      _dirty = true;
    });
  }

  Future<bool> _onWillPop() async {
    if (_dirty) {
      final shouldPop = await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Discard Changes?'),
            content: Text('Are you sure you want to discard your changes?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text('Yes'),
              ),
            ],
          );
        },
      );
      return shouldPop ?? false;
    }
    return true;
  }

  void _onSubmit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _dirty = false;
      });
      _showDialog();
    }
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Form Submitted'),
          content: Text('Name: $_name\nEmail: $_email'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: widget.child,
    );
  }
}
