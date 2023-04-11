import 'package:flutter/material.dart';

class AutoCompleteTextField extends StatefulWidget {
  const AutoCompleteTextField({
    required this.items,
    required this.onSubmitted,
    required this.decoration,
  });

  final List<String> items;
  final Function(String) onSubmitted;
  final InputDecoration decoration;

  @override
  _AutoCompleteTextFieldState createState() => _AutoCompleteTextFieldState();
}

class _AutoCompleteTextFieldState extends State<AutoCompleteTextField> {
  final _textController = TextEditingController();
  bool _showAutocomplete = false;

  @override
  void initState() {
    super.initState();
    _textController.addListener(() {
      final currentText = _textController.text;
      setState(() {
        _showAutocomplete = currentText.isNotEmpty &&
            widget.items.any((item) =>
                item.toLowerCase().contains(currentText.toLowerCase())) &&
            !widget.items
                .any((item) => item.toLowerCase() == currentText.toLowerCase());
      });
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: _textController,
          decoration: widget.decoration,
          onFieldSubmitted: (value) => widget.onSubmitted(value),
        ),
        if (_showAutocomplete)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
                // color: Colors.grey,
              ),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ...widget.items
                      .where((item) => item
                          .toLowerCase()
                          .contains(_textController.text.toLowerCase()))
                      .map((item) => ListTile(
                            title: Text(item),
                            onTap: () {
                              setState(() {
                                _showAutocomplete = false;
                                _textController.text = item;
                                widget.onSubmitted(item);
                              });
                            },
                          ))
                ],
              ),
            ),
          ),
      ],
    );
  }
}
