import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:uuid/uuid.dart';

void main() {
  test('Save appointment successfully', () async {
    SharedPreferences.setMockInitialValues({});

    final prefs = await SharedPreferences.getInstance();
    final success = await saveAppointmentToStorage(
      prefs: prefs,
      patientName: 'John Doe',
      selectedDate: '2024-12-19',
      selectedTime: '10:00 AM',
      purpose: 'Checkup',
      note: 'Follow-up visit',
    );

    expect(success, isTrue);
    expect(prefs.getStringList('appointments'), isNotEmpty);
  });
}

Future<bool> saveAppointmentToStorage({
  required SharedPreferences prefs,
  required String patientName,
  required String? selectedDate,
  required String? selectedTime,
  required String purpose,
  required String note,
}) async {
  if (patientName.isNotEmpty &&
      purpose.isNotEmpty &&
      selectedDate != null &&
      selectedTime != null) {
    final newAppointment = {
      'id': const Uuid().v1(),
      'name': patientName,
      'date': selectedDate,
      'time': selectedTime,
      'purpose': purpose,
      'note': note
    };

    List<String> existingAppointments =
        prefs.getStringList('appointments') ?? [];
    existingAppointments.add(jsonEncode(newAppointment));

    await prefs.setStringList('appointments', existingAppointments);
    return true;
  }
  return false;
}
