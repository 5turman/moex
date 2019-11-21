import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:com.example.moex/app_colors.dart';
import 'package:com.example.moex/features/shares/domain/model/share.dart';
import 'package:com.example.moex/features/shares/ui/change_painter.dart';

const double _lineSpace = 2;

class ShareListTile extends StatelessWidget {
  ShareListTile(this.share) : assert(share != null);

  final Share share;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  share.shortName,
                  style: const TextStyle(
                    color: AppColors.primaryText,
                    fontSize: 16,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: _lineSpace),
                Text(
                  share.id,
                  style: const TextStyle(
                    color: AppColors.secondaryText,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              if (share.last != null) ...[
                Text(
                  share.last.toString(),
                  style: const TextStyle(
                    color: AppColors.primaryText,
                    fontSize: 16,
                  ),
                ),
                if (share.lastToPrev != null)
                  Padding(
                    padding: const EdgeInsets.only(top: _lineSpace),
                    child: Row(
                      children: <Widget>[
                        CustomPaint(
                          size: const Size(12, 10),
                          painter: ChangePainter(share.lastToPrev),
                        ),
                        const SizedBox(
                          width: _lineSpace,
                        ),
                        Text(
                          share.lastToPrev.toString(),
                          style: const TextStyle(
                            color: AppColors.secondaryText,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: _lineSpace),
                Text(
                  _formatDateTime(share.timestamp),
                  style: const TextStyle(
                    color: AppColors.secondaryText,
                    fontSize: 14,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  String _formatDateTime(int timestamp) {
    final dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
    return DateFormat.MMMEd(window.locale.toString())
        .add_Hms()
        .format(dateTime);
  }
}
