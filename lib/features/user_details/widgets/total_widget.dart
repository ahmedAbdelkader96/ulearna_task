import 'package:flutter/material.dart';
import 'package:task/global/methods_helpers_functions/media_query.dart';

class TotalWidget extends StatelessWidget {
  const TotalWidget({super.key, required this.sum, required this.icon});

  final String sum;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MQuery.getWidth(context, 50),
      height: 55,
      color: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 32,
            color: Colors.purple,
          ),
          Text(
            sum,
            style: const TextStyle(
                fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
          )
        ],
      ),
    );
  }
}
