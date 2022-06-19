import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:guitar_corner_app/services/booking_services.dart';
import 'package:intl/intl.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;
CollectionReference histories = firestore.collection("histories");

class HistoryServices {
  static addHistory(DocumentSnapshot doc) {
    String orderDate = DateFormat("dd-MM-yyyy, HH:mm")
        .format(DateTime.now().add(Duration(hours: 8)))
        .toString();
    histories.add({
      "idUser": doc.get("idUser"),
      "status": doc.get("status"),
      "orderId": doc.get("orderId"),
      "orderDate": doc.get("orderDate"),
      "pickUpDate": orderDate,
      "totalPrice": doc.get("totalPrice"),
      "dataCart": doc.get("dataCart"),
    }).then((value) => bookings.doc(doc.id).delete());
  }
}
