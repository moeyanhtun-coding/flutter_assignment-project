import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class AppointmentDetailsPage extends StatefulWidget {
  const AppointmentDetailsPage({super.key});

  @override
  State<AppointmentDetailsPage> createState() => _AppointmentDetailsPageState();
}

class _AppointmentDetailsPageState extends State<AppointmentDetailsPage> {
  double consultationFee = 50.0;
  double labTestFee = 30.0;
  double followUpFee = 20.0;
  double additionalFees = 0.0;
  double discount = 0.0;
  double totalAmount = 0.0;

  void calculateCharges() {
    setState(() {
      double serviceFees = consultationFee + labTestFee + followUpFee;
      totalAmount = serviceFees + additionalFees - discount;
    });
  }

  @override
  Widget build(BuildContext context) {
    final appointment = Get.arguments as Map<String, String>? ??
        {
          'name': 'John Doe',
          'date': 'Dec 5, 2024',
          'time': '10:00 AM',
          'purpose': 'Routine Checkup',
          'notes': 'Patient reports mild fever and fatigue.',
        };

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Appointment Details",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Patient Name: ${appointment['name']}",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text("Date: ${appointment['date']}"),
            Text("Time: ${appointment['time']}"),
            Text("Purpose: ${appointment['purpose']}"),
            Text("Notes: ${appointment['notes']}"),
            const Divider(height: 30, thickness: 1),
            const Text(
              "Charges Calculation",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 10),
            Text("Consultation Fee: \$${consultationFee.toStringAsFixed(2)}"),
            Text("Lab Test Fee: \$${labTestFee.toStringAsFixed(2)}"),
            Text("Follow-up Fee: \$${followUpFee.toStringAsFixed(2)}"),
            const SizedBox(height: 10),
            TextField(
              decoration: const InputDecoration(
                labelText: "Additional Fees",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  additionalFees = double.tryParse(value) ?? 0.0;
                });
              },
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: const InputDecoration(
                labelText: "Discounts",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  discount = double.tryParse(value) ?? 0.0;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: calculateCharges,
              child: const Text("Calculate Charges"),
            ),
            const SizedBox(height: 10),
            Text(
              "Total Amount: \$${totalAmount.toStringAsFixed(2)}",
              style: const TextStyle(
                  fontWeight: FontWeight.bold, color: Colors.green),
            ),
            const Divider(height: 30, thickness: 1),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Navigate to Edit Appointment screen
                    Get.toNamed('/editAppointment', arguments: appointment);
                  },
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.orange),
                  child: const Text("Edit Appointment"),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Logic to delete the appointment
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text("Delete Appointment"),
                        content: const Text(
                            "Are you sure you want to delete this appointment?"),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text("Cancel"),
                          ),
                          TextButton(
                            onPressed: () {
                              // Logic to remove the appointment
                              Get.back(); // Close dialog
                              Get.back(); // Return to previous page
                            },
                            child: const Text("Delete"),
                          ),
                        ],
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  child: const Text("Delete Appointment"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
