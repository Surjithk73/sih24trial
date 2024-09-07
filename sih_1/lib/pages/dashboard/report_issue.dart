import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sih_1/pages/dashboard/provider/report_provider.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ReportIssueWidget extends StatelessWidget {
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  ReportIssueWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final reportProvider = Provider.of<ReportIssueProvider>(context);

    return Container(
      width: double.maxFinite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Describe the Issue:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          TextField(
            controller: _descriptionController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter the issue description',
              contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
            maxLines: 3,
          ),
          SizedBox(height: 16),
          Text(
            'Location:',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              ElevatedButton(
                onPressed: () async {
                  try {
                    await reportProvider.fetchCurrentLocation(context);
                    _locationController.text = reportProvider.location ?? '';
                  } catch (e) {
                    Fluttertoast.showToast(
                      msg: e.toString(),
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                    );
                  }
                },
                child: Text('Use Current Location'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white, backgroundColor: Colors.blue,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: TextField(
                  controller: _locationController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Or enter location manually',
                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Center(
            child: ElevatedButton(
              onPressed: () async {
                String description = _descriptionController.text;
                String location = _locationController.text;

                if (description.isNotEmpty && location.isNotEmpty) {
                  try {
                    await reportProvider.saveIssue(description, location);
                    Fluttertoast.showToast(
                      msg: "Thank you for reporting the issue.",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: Colors.green,
                      textColor: Colors.white,
                    );
                    _descriptionController.clear();
                    _locationController.clear();
                    Navigator.of(context).pop(); // Close the dialog on success
                  } catch (e) {
                    Fluttertoast.showToast(
                      msg: "Failed to report the issue.",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                    );
                  }
                } else {
                  Fluttertoast.showToast(
                    msg: "Please fill in all fields.",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    backgroundColor: Colors.orange,
                    textColor: Colors.white,
                  );
                }
              },
              child: Text('Report'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                textStyle: TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
