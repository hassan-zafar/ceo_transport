import 'package:animations/animations.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:ceo_transport/constants/constants.dart';
import 'package:ceo_transport/job_details.dart';
import 'package:ceo_transport/models/driver_details.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    String dateString = DateTime.now().toString();
    var dateparse = DateTime.parse(dateString);
    var formattedDate = "${dateparse.day}-${dateparse.month}-${dateparse.year}";

    Driver driverData = driverDetails!.success!.driver!;
    List<Reservation> reservations = driverDetails!.success!.reservations!;
    return SafeArea(
      child: Scaffold(
        body: ListView(
          shrinkWrap: true,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: AutoSizeText(
                  "Good Day ${driverData.name}",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Center(
                child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              margin: EdgeInsets.all(12),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Icon(Icons.bakery_dining_outlined),
                    AutoSizeText(
                      "This is the list of jobs available assigned to you today $formattedDate",
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      softWrap: true,
                    ),
                  ],
                ),
              ),
            )),
            ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: reservations.length,
              itemBuilder: (context, index) {
                return OpenContainer(
                    closedColor: Theme.of(context).canvasColor,
                    openColor: Theme.of(context).canvasColor,
                    closedBuilder: (context, action) => jobCard(
                          jobNo: "${reservations[index].reservationId}",
                          isDetail: false,
                          puTime: reservations[index].pickupTime,
                          duData: reservations[index].reservationDo,
                          pax2: "${reservations[index].passengers!}",
                          paxData: reservations[index].passengerName,
                          paxPhone: reservations[index].passengerPhone,
                          resNo: "${reservations[index].reservationNumber}",
                          puDataAddress: reservations[index].pu,
                          puData: reservations[index].pu,
                        ),
                    openBuilder: (context, action) => JobDetails(
                          jobDetails: reservations[index],
                        ));
              },
            ),
          ],
        ),
        bottomSheet: Container(
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                      )),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: AutoSizeText(
                      "Call Dispatch",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                      color: Color(0xff27AD55),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                      )),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: AutoSizeText(
                      "Log Out",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class jobCard extends StatefulWidget {
  final String? jobNo;
  final String? puTime;
  final String? resNo;
  final String? paxData;
  final String? puData;
  final String? duData;
  final String? paxPhone;
  final String? pax2;
  final bool? isDetail;
  final String? puDataAddress;
  const jobCard(
      {this.jobNo,
      this.puTime,
      this.duData,
      this.paxData,
      this.paxPhone,
      this.isDetail,
      this.puDataAddress,
      this.pax2,
      this.puData,
      this.resNo});

  @override
  State<jobCard> createState() => _jobCardState();
}

class _jobCardState extends State<jobCard> {
  bool? latePuClicked = false;

  @override
  Widget build(BuildContext context) {
    print(latePuClicked);
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AutoSizeText(widget.jobNo!),
                      Row(
                        children: [
                          AutoSizeText(
                            "Pick Up Time: ",
                          ),
                          AutoSizeText(
                            widget.puTime!,
                            style: TextStyle(color: Colors.red, fontSize: 22),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              AutoSizeText("Res #${widget.resNo}"),
              ListTile(
                leading: AutoSizeText("Pax:"),
                title: AutoSizeText(
                  widget.paxData!,
                  softWrap: true,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                trailing: AutoSizeText("# ${widget.pax2}"),
                dense: true,
              ),
              ListTile(
                leading: AutoSizeText("PU:"),
                title: AutoSizeText(
                  widget.puData!,
                  softWrap: true,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                subtitle: AutoSizeText(
                  widget.puDataAddress!,
                  softWrap: true,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                dense: true,
              ),
              ListTile(
                leading: AutoSizeText("DO:"),
                title: AutoSizeText(
                  widget.duData!,
                  softWrap: true,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                dense: true,
              ),
              ListTile(
                leading: AutoSizeText("Pax. Phone:"),
                title: AutoSizeText(
                  widget.paxPhone!,
                  softWrap: true,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                dense: true,
              ),
              widget.isDetail!
                  ? Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                                child: Container(
                                    margin: EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                        color: Colors.yellow,
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    padding: EdgeInsets.all(12),
                                    child: AutoSizeText(
                                      "En Route",
                                      textAlign: TextAlign.center,
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ))),
                            Expanded(
                                child: Container(
                                    margin: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        color: Colors.yellow,
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    padding: EdgeInsets.all(12),
                                    child: AutoSizeText(
                                      "On Local",
                                      textAlign: TextAlign.center,
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ))),
                          ],
                        ),
                        Container(
                            margin: EdgeInsets.all(8),
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                                color: Colors.yellow.shade700,
                                borderRadius: BorderRadius.circular(12)),
                            padding: EdgeInsets.all(12),
                            child: AutoSizeText(
                              "Successful Rendezvous",
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyText1,
                            )),
                        Row(
                          children: [
                            Expanded(
                              child: latePuClicked!
                                  ? Column(
                                      children: [
                                        Container(
                                            margin: EdgeInsets.all(12),
                                            decoration: BoxDecoration(
                                                color: Colors.purple,
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                            padding: EdgeInsets.only(
                                                top: 12,
                                                bottom: 12,
                                                left: 28,
                                                right: 28),
                                            child: AutoSizeText(
                                              "Late Driver",
                                              textAlign: TextAlign.center,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1,
                                            )),
                                        Container(
                                            margin: EdgeInsets.all(12),
                                            decoration: BoxDecoration(
                                                color: Colors.blue,
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                            padding: EdgeInsets.only(
                                                top: 12,
                                                bottom: 12,
                                                left: 28,
                                                right: 28),
                                            child: AutoSizeText(
                                              "Late PAX   ",
                                              textAlign: TextAlign.center,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1,
                                            )),
                                      ],
                                    )
                                  : InkWell(
                                      onTap: () {
                                        setState(() {
                                          latePuClicked = true;
                                        });
                                      },
                                      child: Container(
                                          margin: EdgeInsets.all(12),
                                          decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(12)),
                                          padding: EdgeInsets.all(12),
                                          child: AutoSizeText(
                                            "Late PU",
                                            textAlign: TextAlign.center,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1,
                                          )),
                                    ),
                            ),
                            Expanded(
                                child: Container(
                                    margin: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    padding: EdgeInsets.all(12),
                                    child: AutoSizeText(
                                      "No Show",
                                      textAlign: TextAlign.center,
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ))),
                          ],
                        ),
                        Container(
                            margin: EdgeInsets.all(8),
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(12)),
                            padding: EdgeInsets.all(12),
                            child: AutoSizeText(
                              "Additional Charges",
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyText1,
                            )),
                        Container(
                            margin: EdgeInsets.all(8),
                            width: double.maxFinite,
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(12)),
                            padding: EdgeInsets.all(12),
                            child: AutoSizeText(
                              "Drop Off Complete",
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyText1,
                            )),
                      ],
                    )
                  : Container()
            ],
          ),
        ),
      ),
    );
  }
}
