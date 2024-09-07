import 'package:flutter/material.dart';
import 'package:sih_1/pages/dashboard/report_issue.dart';

class ReportButton extends StatelessWidget {
  void _showReportIssueDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Report an Issue'),
          content: ReportIssueWidget(),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          scrollable: true,
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _showReportIssueDialog(context),
      child: Text('Report Issue'),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white, backgroundColor: Colors.blue, // Text color
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        textStyle: TextStyle(fontSize: 18),
      ),
    );
  }
}