import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class DatetimePickerWidget extends StatefulWidget {
  DatetimePickerWidget(this.onTimeSelected, {this.selectedTime, Key? key})
      : super(key: key);

  Function(Timestamp) onTimeSelected;
  Timestamp? selectedTime;

  @override
  State<DatetimePickerWidget> createState() => _DatetimePickerWidgetState();
}

class _DatetimePickerWidgetState extends State<DatetimePickerWidget> {
  DateTime? dateTime;

  @override
  void initState() {
    super.initState();
    if (widget.selectedTime != null) {
      dateTime = widget.selectedTime!.toDate();
    }
  }

  String getText() {
    if (dateTime == null) {
      return "Fecha y Hora";
    } else {
      return DateFormat('dd-MM-yyyy HH:mm').format(dateTime!);
    }
  }

  @override
  Widget build(BuildContext context) => ElevatedButton(
        onPressed: () => pickeDateTime(context),
        style: ElevatedButton.styleFrom(
          primary: Colors.indigo,
        ),
        child: Text(getText()),
      );

  Future pickeDateTime(BuildContext context) async {
    final date = await pickDate(context);
    if (date == null) return;

    final time = await pickTime(context);
    if (time == null) return;

    debugPrint("date: $date time: $time");

    setState(() {
      dateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
      if (dateTime != null) {
        widget.onTimeSelected.call(Timestamp.fromDate(dateTime!));
      }
    });
  }

  Future<DateTime?> pickDate(BuildContext context) async {
    final initialDate = DateTime.now();

    return showDatePicker(
      context: context,
      initialDate: dateTime ?? initialDate,
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime(DateTime.now().year + 5),
      cancelText: 'Cancelar',
      confirmText: 'Aceptar',
      fieldLabelText: 'Fecha',
      helpText: 'Selecciona la fecha',
      errorInvalidText: 'La fecha no es válida',
    );
  }

  Future<TimeOfDay?> pickTime(BuildContext context) async {
    final initialDate = TimeOfDay.now();

    return showTimePicker(
      context: context,
      initialTime: dateTime != null
          ? TimeOfDay(hour: dateTime!.hour, minute: dateTime!.minute)
          : initialDate,
      cancelText: 'Cancelar',
      confirmText: 'Aceptar',
      helpText: 'Selecciona la hora',
      hourLabelText: 'Hora',
      minuteLabelText: 'Minuto',
      errorInvalidText: 'La hora no es válida',
    );
  }
}
