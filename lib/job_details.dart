import 'package:ceo_transport/models/driver_details.dart';
import 'package:ceo_transport/tools/job_card.dart';
import 'package:flutter/material.dart';

class JobDetails extends StatefulWidget {
  final List<Reservation?> allJobDetails;
  final String? index;
  const JobDetails({required this.allJobDetails, required this.index});

  @override
  _JobDetailsState createState() => _JobDetailsState();
}

class _JobDetailsState extends State<JobDetails> {
  String currentStatus = "Not Assigned";
  int? indexConst = 0;
  @override
  void initState() {
    super.initState();
    indexConst = int.parse(widget.index!) - 1;
  }

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
                    // currentStatus: currentStatus,
                    isDetail: true,
                    resId: widget.allJobDetails[indexConst!]!.reservationId!,
                    puTime: widget.allJobDetails[indexConst!]!.pickupTime!,
                    duData: widget.allJobDetails[indexConst!]!.reservationDo!,
                    paxData: widget.allJobDetails[indexConst!]!.passengerName!,
                    eadt: widget.allJobDetails[indexConst!]!.eadt!,
                    pickupTimeIso:
                        widget.allJobDetails[indexConst!]!.pickup_time_iso,
                    hotelAddress:
                        widget.allJobDetails[indexConst!]!.hotelAddress!,
                    type: widget.allJobDetails[indexConst!]!.type!,
                    paxPhone:
                        widget.allJobDetails[indexConst!]!.passengerPhone!,
                    pax2: "${widget.allJobDetails[indexConst!]!.passengers!}",
                    puDataAddress:
                        widget.allJobDetails[indexConst!]!.hotelAddress,
                    resNo:
                        "${widget.allJobDetails[indexConst!]!.reservationNumber!}",
                    puData: widget.allJobDetails[indexConst!]!.pu!,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
