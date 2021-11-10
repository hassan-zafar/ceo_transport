import 'package:ceo_transport/models/driver_details.dart';
import 'package:ceo_transport/tools/job_card.dart';
import 'package:flutter/material.dart';

class JobDetails extends StatefulWidget {
  final Reservation? jobDetails;
  final String? index;
  const JobDetails({required this.jobDetails, required this.index});

  @override
  _JobDetailsState createState() => _JobDetailsState();
}

class _JobDetailsState extends State<JobDetails> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Hero(
                  tag: widget.index!,
                  child: jobCard(
                    jobNo: widget.index!,
                    isDetail: true,
                    puTime: widget.jobDetails!.pickupTime!,
                    duData: widget.jobDetails!.reservationDo!,
                    paxData: widget.jobDetails!.passengerName!,
                    hotelAddress: widget.jobDetails!.hotelAddress!,
                    type: widget.jobDetails!.type!,
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
