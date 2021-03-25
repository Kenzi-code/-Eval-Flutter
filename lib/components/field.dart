import 'package:flutter/material.dart';

class FieldText extends StatelessWidget {
  const FieldText(
      {Key key, this.onSaved, this.validator, this.label, this.placeholder})
      : super(key: key);

  final String label, placeholder;
  final Function onSaved, validator;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onSaved: onSaved,
      validator: validator,
      decoration: InputDecoration(labelText: label, hintText: placeholder),
    );
  }
}
