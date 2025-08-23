import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:shimmer/shimmer.dart';

class KycShimmerWidget extends StatelessWidget {
  const KycShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(width: 0.5, color: Colors.red),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(backgroundColor: Colors.white, radius: 20),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(width: 150, height: 12, color: Colors.white),
                const SizedBox(height: 8),
                Container(width: 100, height: 10, color: Colors.white),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ActionRowShimmer extends StatelessWidget {
  const ActionRowShimmer({super.key});

  Widget _buildShimmerBox() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const CircleAvatar(radius: 13, backgroundColor: Colors.white),
          const SizedBox(height: 10),
          Container(width: 50, height: 10, color: Colors.white),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(4, (index) => _buildShimmerBox()),
      ).paddingOnly(left: 15, right: 15),
    );
  }
}

class TransactionTileShimmer extends StatelessWidget {
  const TransactionTileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        margin: const EdgeInsets.all(3),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          border: Border.all(width: 0.3, color: Colors.grey.shade300),
        ),
        child: ListTile(
          leading: const CircleAvatar(
            backgroundColor: Colors.white,
            radius: 20,
          ),
          title: Container(width: 100, height: 12, color: Colors.white),
          subtitle: Container(width: 60, height: 10, color: Colors.white),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(width: 50, height: 12, color: Colors.white),
              const SizedBox(height: 6),
              Container(width: 40, height: 10, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}
