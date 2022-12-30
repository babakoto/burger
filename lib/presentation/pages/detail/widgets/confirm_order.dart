part of "../detail_page.dart";

class ConfirmOrder extends StatefulWidget {
  final VoidCallback onPressed;
  final double total;
  const ConfirmOrder({
    Key? key,
    required this.onPressed,
    required this.total,
  }) : super(key: key);

  @override
  State<ConfirmOrder> createState() => _ConfirmOrderState();
}

class _ConfirmOrderState extends State<ConfirmOrder> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return ElevatedButton(
        onPressed: widget.total > 0.0 ? widget.onPressed : null,
        style: ElevatedButton.styleFrom(
          foregroundColor: AppThemes.red,
          backgroundColor: AppThemes.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            "Confirm order",
            style: textTheme.headline6,
          ),
        ));
  }
}
