// To parse this JSON data, do
//
//     final driverDetails = driverDetailsFromJson(jsonString);

import 'dart:convert';

DriverDetails driverDetailsFromJson(String str) =>
    DriverDetails.fromJson(json.decode(str));

String driverDetailsToJson(DriverDetails data) => json.encode(data.toJson());

class DriverDetails {
  DriverDetails({
    this.success,
  });

  Success? success;

  factory DriverDetails.fromJson(Map<String, dynamic> json) => DriverDetails(
        success: Success.fromJson(json["success"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success!.toJson(),
      };
}

class Success {
  Success({
    this.driver,
    this.reservations,
  });

  Driver? driver;
  List<Reservation>? reservations;

  factory Success.fromJson(Map<String, dynamic> json) => Success(
        driver: Driver.fromJson(json["driver"]),
        reservations: List<Reservation>.from(
            json["reservations"].map((x) => Reservation.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "driver": driver!.toJson(),
        "reservations":
            List<dynamic>.from(reservations!.map((x) => x.toJson())),
      };
}

class Driver {
  Driver({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? name;
  String? email;
  dynamic emailVerifiedAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "email_verified_at": emailVerifiedAt,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}

class Reservation {
  Reservation(
      {this.reservationId,
      this.reservationNumber,
      this.passengerName,
      this.passengers,
      this.passengerPhone,
      this.pickupTime,
      this.pu,
      this.type,
      this.reservationDo,
      this.hotelAddress,
      this.pickup_time_iso,
      this.eadt, this.new_reservation = false});

  int? reservationId;
  int? reservationNumber;
  String? passengerName;
  int? passengers;
  String? passengerPhone;
  String? pickupTime;
  String? eadt;
  String? pu;
  String? type;
  String? reservationDo;
  String? hotelAddress;
  String? pickup_time_iso;
  bool new_reservation;

  factory Reservation.fromJson(Map<String, dynamic> json) => Reservation(
        reservationId: json["reservation_id"],
        reservationNumber: json["reservation_number"],
        passengerName: json["passenger_name"],
        passengers: json["passengers"],
        passengerPhone: json["passenger_phone"],
        eadt: json["eadt"],
        pickupTime: json["pickup_time"],
        pu: json["pu"],
        pickup_time_iso: json["pickup_time_iso"],
        type: json["type"],
        reservationDo: json["do"],
        hotelAddress: json["hotel_address"],
      );

  Map<String, dynamic> toJson() => {
        "reservation_id": reservationId,
        "reservation_number": reservationNumber,
        "passenger_name": passengerName,
        "passengers": passengers,
        "passenger_phone": passengerPhone,
        "pickup_time": pickupTime,
        "eadt": eadt,
        "pu": pu,
        "type": type,
        "do": reservationDo,
        "hotel_address": hotelAddress,
      };
}
