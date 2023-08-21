import 'package:dw_babershop/src/core/ui/constants.dart';
import 'package:flutter/material.dart';

class WeekdaysPanel extends StatelessWidget {
  final ValueChanged<String> onDaySelected;

  const WeekdaysPanel({
    super.key,
    required this.onDaySelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Selecione os dias da semana',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ButtonDay(label: 'Seg', onDaySelected: onDaySelected),
                ButtonDay(label: 'Ter', onDaySelected: onDaySelected),
                ButtonDay(label: 'Qua', onDaySelected: onDaySelected),
                ButtonDay(label: 'Qui', onDaySelected: onDaySelected),
                ButtonDay(label: 'Sex', onDaySelected: onDaySelected),
                ButtonDay(label: 'Sáb', onDaySelected: onDaySelected),
                ButtonDay(label: 'Dom', onDaySelected: onDaySelected),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ButtonDay extends StatefulWidget {
  final String label;
  final ValueChanged<String> onDaySelected;

  const ButtonDay({
    super.key,
    required this.label,
    required this.onDaySelected,
  });

  @override
  State<ButtonDay> createState() => _ButtonDayState();
}

class _ButtonDayState extends State<ButtonDay> {
  var selected = false;

  @override
  Widget build(BuildContext context) {
    final textColor = selected ? Colors.white : ColorsConstants.grey;
    final buttonBorderColor =
        selected ? ColorsConstants.brown : ColorsConstants.grey;
    var buttonColor = selected ? ColorsConstants.brown : Colors.white;

    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: InkWell(
        onTap: () {
          widget.onDaySelected(widget.label);
          setState(() {
            selected = !selected;
          });
        },
        borderRadius: BorderRadius.circular(8),
        child: Container(
          width: 40,
          height: 56,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: buttonColor,
            border: Border.all(
              color: buttonBorderColor,
            ),
          ),
          child: Center(
            child: Text(
              widget.label,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
