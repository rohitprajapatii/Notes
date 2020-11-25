import 'package:flutter/material.dart';

Padding newNoteBody(TextEditingController _textController) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
    child: Column(
      children: <Widget>[
        Expanded(
          child: TextField(
            style:
                TextStyle(fontSize: 14, color: Colors.white.withOpacity(0.8)),
            decoration: InputDecoration(border: InputBorder.none),
            cursorColor: Colors.grey,
            cursorWidth: 0.5,
            enableSuggestions: true,
            autofocus: true,
            keyboardType: TextInputType.multiline,
            controller: _textController,
            maxLines: 1000,
          ),
        )
      ],
    ),
  );
}
