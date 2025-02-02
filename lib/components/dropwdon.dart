import 'package:flutter/material.dart';
import 'package:google_maps/colors.dart';

class Dropdown<T> extends StatelessWidget {
  final T? selectedValue;
  final List<T> items;
  final String hintText;
  final ValueChanged<T?> onChanged;
  final String Function(T) itemLabelBuilder;

  const Dropdown({
    super.key,
    this.selectedValue,
    required this.items,
    required this.hintText,
    required this.onChanged,
    required this.itemLabelBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return FormField<T>(
      initialValue: selectedValue,
      validator: (value) {
        if (value == null) {
          return 'Campo obrigatório';
        }
        return null;
      },
      builder: (FormFieldState<T> state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField<T>(
              value: state.value,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(color: AppColors.textPrimary)),
              ),
              hint: Text(
                hintText,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              onChanged: (T? newValue) {
                onChanged(newValue); 
                state.didChange(newValue); 
              },
              items: items.map<DropdownMenuItem<T>>((T value) {
                return DropdownMenuItem<T>(
                  value: value,
                  child: Text(
                    itemLabelBuilder(value),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                );
              }).toList(),
            ),
            if (state.hasError)
              Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  state.errorText!,
                  style: const TextStyle(color: Colors.red, fontSize: 12),
                ),
              ),
          ],
        );
      },
    );
  }
}
