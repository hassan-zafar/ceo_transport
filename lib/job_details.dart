import 'package:ceo_transport/home_page.dart';
import 'package:ceo_transport/models/driver_details.dart';
import 'package:flutter/material.dart';

class JobDetails extends StatefulWidget {
  final Reservation? jobDetails;
  const JobDetails({required this.jobDetails});

  @override
  _JobDetailsState createState() => _JobDetailsState();
}

class _JobDetailsState extends State<JobDetails> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Hero(
                  tag: "card",
                  child: jobCard(
                    jobNo: "${widget.jobDetails!.reservationNumber!}",
                    isDetail: true,
                    puTime: widget.jobDetails!.pickupTime!,
                    duData: widget.jobDetails!.reservationDo!,
                    paxData: widget.jobDetails!.passengerName!,
                    paxPhone: widget.jobDetails!.passengerPhone!,
                    pax2: "${widget.jobDetails!.passengers!}",
                    puDataAddress: widget.jobDetails!.hotelAddress,
                    resNo: "${widget.jobDetails!.reservationId!}",
                    puData: widget.jobDetails!.pu!,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
