import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:mobile_abz/app/themes/app_colors.dart';

class CustomDropdown extends StatefulWidget {
  final List<String> items;
  final String? selectedValue;
  final ValueChanged<String?> onChanged;

  const CustomDropdown({
    super.key,
    required this.items,
    required this.selectedValue,
    required this.onChanged,
  });

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton2<String>(
      isExpanded: true,
      buttonStyleData: ButtonStyleData(
        height: 50,
        padding: EdgeInsets.only(right: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade400),
          color: Colors.white,
        ),
      ),
      dropdownStyleData: DropdownStyleData(
        elevation: 0,
        maxHeight: 250,
        padding: EdgeInsets.zero,
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
      hint: Text(
        'Выберите день',
        style: TextStyle(
            letterSpacing: 0,
            color: Colors.grey.shade600,
            fontSize: 16,
            fontWeight: FontWeight.w400),
      ),
      value: widget.selectedValue,
      underline: SizedBox.shrink(),
      items: widget.items.map((date) {
        return DropdownMenuItem(
          value: date,
          child: Text(
            date,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColors.black,
            ),
          ),
        );
      }).toList(),
      onChanged: widget.onChanged,
    );
  }
}
