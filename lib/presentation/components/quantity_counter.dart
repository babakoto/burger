import 'package:counter_slider/counter_slider.dart';
import 'package:flutter/material.dart';

class QuantityCounter extends StatefulWidget {
  final Function(int) onChanged;
  final int initValue;
  final Color? color;
  const QuantityCounter(
      {Key? key, required this.onChanged, required this.initValue, this.color})
      : super(key: key);

  @override
  State<QuantityCounter> createState() => _QuantityCounterState();
}

class _QuantityCounterState extends State<QuantityCounter> {
  int quantity = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    quantity = widget.initValue;
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
          iconTheme: IconThemeData(color: widget.color ?? Colors.black)),
      child: CounterSlider(
        value: quantity,
        maxValue: 20,
        minValue: 0,
        onChanged: (value) {
          setState(() {
            quantity = value;
            widget.onChanged(value);
          });
        },
        height: 45,
        width: 120,
      ),
    );
  }
}
