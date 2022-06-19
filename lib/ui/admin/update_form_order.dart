import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:guitar_corner_app/controller/cart_controller.dart';
import 'package:guitar_corner_app/controller/date_controller.dart';
import 'package:guitar_corner_app/services/booking_services.dart';
import 'package:intl/intl.dart';

class UpdateOrderForm extends StatelessWidget {
  DocumentSnapshot doc;

  UpdateOrderForm(this.doc);

  final DateController dateController = Get.put(DateController());
  final TextEditingController statusController = TextEditingController();

  DateTime selectedDate = DateTime.now().add(new Duration(hours: 8));
  TimeOfDay selectedTime = TimeOfDay.now();

  _selectDateAndTime(BuildContext context) async {
    DateTime now = DateTime.now().add(new Duration(hours: 8));
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate:
          DateTime(now.year, now.month, now.day).add(new Duration(hours: 8)),
      lastDate: DateTime(now.year + 1),
      helpText: 'Choose a date', // Can be used as title
      cancelText: 'Back',
      confirmText: 'Save',
    );

    if (pickedDate != null && pickedDate != selectedDate) {
      String pickedDateString = DateFormat("dd-MM-yyyy").format(pickedDate);
      print(pickedDateString);
      dateController.setStateDate(pickedDateString);
    }

    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      helpText: 'Choose a time', // Can be used as title
      cancelText: 'Back',
      confirmText: 'Save',
    );

    if (pickedTime != null) {
      String pickedTimeString = pickedTime.format(context);
      print(pickedTimeString);
      dateController.setStateTime(pickedTimeString);
    }
  }

  Widget dateChooser(context) => Row(
        children: [
          Icon(
            Icons.date_range,
            color: Color.fromARGB(255, 54, 60, 79),
          ),
          SizedBox(
            width: 16,
          ),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Obx(
              () => Text(
                "${dateController.selectedDate.value}, ${dateController.selectedTime.value}",
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontFamily: "Jakarta", fontSize: 13),
              ),
            ),
          ]),
          Spacer(),
          ElevatedButton(
            onPressed: () => _selectDateAndTime(context), // Refer step 3
            child: Text(
              'Set',
              style:
                  TextStyle(fontFamily: "Jakarta", fontWeight: FontWeight.w600),
            ),
            style: ElevatedButton.styleFrom(
              onPrimary: Colors.white,
              primary: Color.fromARGB(255, 1, 74, 170),
              elevation: 2,
              side:
                  BorderSide(color: Color.fromARGB(100, 1, 74, 170), width: 1),
              padding: EdgeInsets.all(5),
            ),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    statusController.text = doc.get("status");
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Update Order",
          style: TextStyle(
              fontFamily: "Jakarta",
              fontWeight: FontWeight.w600,
              color: Colors.black,
              fontSize: 16),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Color.fromARGB(150, 0, 0, 0)),
      ),
      body: SafeArea(
          child: ListView(
        padding: EdgeInsets.fromLTRB(15, 0, 15, 0),
        children: [
          Text(
            "Order Status :",
            style: TextStyle(fontFamily: "Jakarta"),
          ),
          SizedBox(
            height: 8,
          ),
          TextFormField(
            controller: statusController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                isDense: true,
                errorStyle: TextStyle(fontFamily: "Jakarta"),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        width: 0.5, color: Color.fromARGB(150, 0, 0, 0))),
                focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(255, 1, 74, 170))),
                focusColor: Colors.white,
                hintText: "e.g. Yamaha 2012",
                hintStyle: TextStyle(
                  fontFamily: "Jakarta",
                  fontSize: 15,
                )),
            style: TextStyle(
              fontSize: 15,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "Pickup Date",
            style: TextStyle(fontFamily: "Jakarta"),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Color.fromARGB(50, 54, 60, 79),
                borderRadius: BorderRadius.circular(10),
              ),
              child: dateChooser(context)),
        ],
      )),
      floatingActionButton: Container(
        margin: EdgeInsets.only(left: 30),
        padding: EdgeInsets.only(top: 15),
        color: Colors.white,
        height: 50,
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: ElevatedButton(
            onPressed: () {
              String newPickUpDate = dateController.selectedDate.value +
                  ", " +
                  dateController.selectedTime.value;
              BookingServices.updateBooking(
                  doc.id, statusController.text, newPickUpDate);
              Get.back();
            },
            child: Text(
              "Update Order",
              style: TextStyle(fontFamily: "Jakarta", fontSize: 12),
            ),
            style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 1, 74, 170),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                )),
          ),
        ),
      ),
    );
  }
}
