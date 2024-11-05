import 'package:flutter/material.dart';
import 'package:task/global/methods_helpers_functions/media_query.dart';
import 'package:task/global/widgets/shimmer_text_widget.dart';

class LoadingCommentsViewsSharesItem extends StatelessWidget {
  const LoadingCommentsViewsSharesItem({super.key, required this.icon});

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
          const ShimmerTextWidget(width: 30)
        ],
      ),
    );
  }
}
