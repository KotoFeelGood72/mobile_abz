import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class CustomDropdown extends StatelessWidget {
  final List<String> items;
  final String? selectedValue;
  final ValueChanged<String?> onChanged;
  final String placeholder;

  const CustomDropdown({
    super.key,
    required this.items,
    required this.selectedValue,
    required this.onChanged,
    required this.placeholder,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton2<String>(
      isExpanded: true,
      value: selectedValue,
      underline: SizedBox.shrink(),
      hint: Text(
        placeholder,
        style: TextStyle(color: Colors.grey.shade600, fontSize: 16),
      ),
      items: items
          .map((item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ))
          .toList(),
      onChanged: onChanged,
      buttonStyleData: ButtonStyleData(
        height: 50,
        padding: EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade400),
          color: Colors.white,
        ),
      ),
      dropdownStyleData: DropdownStyleData(
        elevation: 0,
        maxHeight: 250,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              spreadRadius: 2,
            ),
          ],
        ),
      ),
      iconStyleData: IconStyleData(
        icon: Icon(Icons.expand_more, color: Colors.purple),
        openMenuIcon: Icon(Icons.expand_less, color: Colors.purple),
      ),
    );
  }
}
