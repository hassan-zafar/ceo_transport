import 'package:auto_size_text/auto_size_text.dart';
import 'package:ceo_transport/APIs/reservationAPI.dart';
import 'package:ceo_transport/constants/constants.dart';
import 'package:ceo_transport/tools/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class jobCard extends StatefulWidget {
  final String? jobNo;

  final String? puTime;
  final String? resNo;
  final String? paxData;
  final String? puData;
  final String? duData;
  final String? paxPhone;
  final String? pax2;
  final String? hotelAddress;
  final bool? isDetail;
  final String? type;
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
      this.type,
      this.hotelAddress,
      this.resNo});

  @override
  State<jobCard> createState() => _jobCardState();
}

class _jobCardState extends State<jobCard> {
  bool _isLoading = false;
  String? currentStatus = 'Not Assigned';

  List buttonSelectedStatus = [
    'en_route',
    'on_location',
    'invehicle',
    'wait_time',
    'wait_time_passenger',
    'no_show',
    'done'
  ];
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
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
                          AutoSizeText("Job# ${widget.jobNo!}"),
                          Row(
                            children: [
                              AutoSizeText(
                                "PU Time: ",
                              ),
                              AutoSizeText(
                                widget.puTime!,
                                style:
                                    TextStyle(color: Colors.red, fontSize: 22),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  AutoSizeText("Res. # ${widget.resNo}"),
                  ListTile(
                    leading: AutoSizeText("Pax : "),
                    title: AutoSizeText(
                      widget.paxData!.toUpperCase(),
                      softWrap: true,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    trailing: AutoSizeText("#PAX ${widget.pax2}"),
                    dense: true,
                  ),
                  ListTile(
                    leading: AutoSizeText("PU:"),
                    title: AutoSizeText(
                      widget.type == "Airport Arrival"
                          ? widget.type!
                          : widget.puData!,
                      softWrap: true,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    subtitle: AutoSizeText(
                      widget.type == "Airport Arrival"
                          ? widget.puData!
                          : widget.hotelAddress!,
                      softWrap: true,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    dense: true,
                  ),
                  ListTile(
                    leading: AutoSizeText("DO:"),
                    title: AutoSizeText(
                      widget.type == "Airport Arrival"
                          ? widget.duData!
                          : widget.type!,
                      softWrap: true,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    subtitle: AutoSizeText(
                      widget.type == "Airport Arrival"
                          ? widget.hotelAddress!
                          : widget.duData!,
                      softWrap: true,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    dense: true,
                  ),
                  GestureDetector(
                    onTap: () => launch("tel://${widget.paxPhone}"),
                    child: ListTile(
                      leading: AutoSizeText("Pax. Phone:"),
                      title: AutoSizeText(
                        widget.paxPhone!,
                        softWrap: true,
                        style: Theme.of(context).textTheme.overline,
                      ),
                      dense: true,
                    ),
                  ),
                  widget.isDetail!
                      ? Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Current Status: "),
                                Text(currentStatus!)
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _isLoading = true;
                                    });

                                    ReservationAPI()
                                        .setStatus(
                                            reservationNo: widget.resNo,
                                            token: token!,
                                            type: "en_route")
                                        .then((passed) {
                                      if (passed) {
                                        CustomToast.successToast(
                                            message: "Status Set: En_Route");
                                      } else {
                                        CustomToast.errorToast(
                                            message: "Couldn't set");
                                      }
                                    });
                                    setState(() {
                                      _isLoading = false;
                                      currentStatus = 'en_route';
                                    });
                                  },
                                  child: Container(
                                      margin: EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                          color: Colors.yellow,
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      padding: EdgeInsets.all(12),
                                      child: Row(children: [
                                        AutoSizeText(
                                          "En Route",
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1,
                                        ),
                                        buttonSelectedStatus[0] == currentStatus
                                            ? Icon(
                                                Icons.done,
                                                color: Colors.black,
                                                size: 14,
                                              )
                                            : Container(),
                                      ])),
                                )),
                                Expanded(
                                    child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _isLoading = true;
                                    });
                                    ReservationAPI()
                                        .setStatus(
                                            reservationNo: widget.resNo,
                                            token: token!,
                                            type: "on_location")
                                        .then((passed) {
                                      if (passed) {
                                        CustomToast.successToast(
                                            message: "Status Set: On Location");
                                      } else {
                                        CustomToast.errorToast(
                                            message: "Couldn't set");
                                      }
                                    });
                                    setState(() {
                                      _isLoading = false;
                                      currentStatus = 'on_location';
                                    });
                                  },
                                  child: Container(
                                    margin: EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        color: Colors.yellow,
                                        borderRadius:
                                            BorderRadius.circular(12)),
                                    padding: EdgeInsets.all(12),
                                    child: Row(
                                      children: [
                                        AutoSizeText(
                                          "On Local",
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1,
                                        ),
                                        buttonSelectedStatus[1] == currentStatus
                                            ? Icon(
                                                Icons.done,
                                                color: Colors.black,
                                                size: 14,
                                              )
                                            : Container(),
                                      ],
                                    ),
                                  ),
                                )),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _isLoading = true;
                                });
                                ReservationAPI()
                                    .setStatus(
                                        reservationNo: widget.resNo,
                                        token: token!,
                                        type: "invehicle")
                                    .then((passed) {
                                  if (passed) {
                                    CustomToast.successToast(
                                        message: "Status Set: In Vehicle");
                                  } else {
                                    CustomToast.errorToast(
                                        message: "Couldn't set");
                                  }
                                });
                                setState(() {
                                  _isLoading = false;
                                  currentStatus = 'invehicle';
                                });
                                ;
                              },
                              child: Container(
                                  margin: EdgeInsets.all(8),
                                  width: double.maxFinite,
                                  decoration: BoxDecoration(
                                      color: Colors.yellow.shade700,
                                      borderRadius: BorderRadius.circular(12)),
                                  padding: EdgeInsets.all(12),
                                  child: Row(
                                    children: [
                                      AutoSizeText(
                                        "Successful Rendezvous",
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
                                      ),
                                      buttonSelectedStatus[2] == currentStatus
                                          ? Icon(
                                              Icons.done,
                                              color: Colors.black,
                                              size: 14,
                                            )
                                          : Container(),
                                    ],
                                  )),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: InkWell(
                                    onTap: () {
                                      showButtons(context);
                                    },
                                    child: Container(
                                        margin: EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        padding: EdgeInsets.all(12),
                                        child: Row(
                                          children: [
                                            AutoSizeText(
                                              "Late PU",
                                              textAlign: TextAlign.center,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1,
                                            ),
                                          ],
                                        )),
                                  ),
                                ),
                                Expanded(
                                    child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _isLoading = true;
                                    });
                                    ReservationAPI()
                                        .setStatus(
                                            reservationNo: widget.resNo,
                                            token: token!,
                                            type: "no_show")
                                        .then((passed) {
                                      if (passed) {
                                        CustomToast.successToast(
                                            message: "Status Set: No Show");
                                      } else {
                                        CustomToast.errorToast(
                                            message: "Couldn't set");
                                      }
                                    });
                                    setState(() {
                                      _isLoading = false;
                                      currentStatus = 'no_show';
                                    });
                                  },
                                  child: Container(
                                      margin: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      padding: EdgeInsets.all(12),
                                      child: Row(
                                        children: [
                                          AutoSizeText(
                                            "No Show",
                                            textAlign: TextAlign.center,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1,
                                          ),
                                          buttonSelectedStatus[5] ==
                                                  currentStatus
                                              ? Icon(
                                                  Icons.done,
                                                  size: 14,
                                                  color: Colors.black,
                                                )
                                              : Container(),
                                        ],
                                      )),
                                )),
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
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _isLoading = true;
                                });
                                ReservationAPI()
                                    .setStatus(
                                        reservationNo: widget.resNo,
                                        token: token!,
                                        type: "done")
                                    .then((passed) {
                                  if (passed) {
                                    CustomToast.successToast(
                                        message: "Status: Drop Off Complete");
                                  } else {
                                    CustomToast.errorToast(
                                        message: "Couldn't set");
                                  }
                                });
                                setState(() {
                                  _isLoading = false;
                                  currentStatus = 'done';
                                });
                              },
                              child: Container(
                                  margin: EdgeInsets.all(8),
                                  width: double.maxFinite,
                                  decoration: BoxDecoration(
                                      color: Colors.green,
                                      borderRadius: BorderRadius.circular(12)),
                                  padding: EdgeInsets.all(12),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      AutoSizeText(
                                        "Drop Off Complete",
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
                                      ),
                                      buttonSelectedStatus[6] == currentStatus
                                          ? Icon(
                                              Icons.done,
                                              color: Colors.black,
                                              size: 14,
                                            )
                                          : Container(),
                                    ],
                                  )),
                            ),
                          ],
                        )
                      : Container()
                ],
              ),
            ),
          ),
        ),
        _isLoading ? Center(child: CircularProgressIndicator()) : Container(),
      ],
    );
  }

  showButtons(
    BuildContext constext,
  ) {
    showDialog(
      context: constext,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              child: SizedBox(
                height: 70,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _isLoading = true;
                        });
                        ReservationAPI()
                            .setStatus(
                                reservationNo: widget.resNo,
                                token: token!,
                                type: "wait_time")
                            .then((passed) {
                          if (passed) {
                            CustomToast.successToast(
                                message: "Status Set: Late Driver");
                          } else {
                            CustomToast.errorToast(message: "Couldn't set");
                          }
                        });
                        setState(() {
                          _isLoading = false;
                          currentStatus = 'wait_time';
                        });
                      },
                      child: Container(
                          margin: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              color: Colors.purple,
                              borderRadius: BorderRadius.circular(12)),
                          padding: EdgeInsets.only(
                              top: 12, bottom: 12, left: 12, right: 12),
                          child: Row(
                            children: [
                              AutoSizeText(
                                "Late Driver",
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              buttonSelectedStatus[3] == currentStatus
                                  ? Icon(
                                      Icons.done,
                                      color: Colors.black,
                                      size: 14,
                                    )
                                  : Container(),
                            ],
                          )),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _isLoading = true;
                        });
                        ReservationAPI()
                            .setStatus(
                                reservationNo: widget.resNo,
                                token: token!,
                                type: "wait_time_passenger")
                            .then((passed) {
                          if (passed) {
                            CustomToast.successToast(
                                message: "Status Set: Late Passenger");
                          } else {
                            CustomToast.errorToast(message: "Couldn't set");
                          }
                        });
                        setState(() {
                          _isLoading = false;
                          currentStatus = 'wait_time_passenger';
                        });
                      },
                      child: Container(
                          margin: EdgeInsets.all(12),
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(12)),
                          padding: EdgeInsets.only(
                              top: 12, bottom: 12, left: 12, right: 12),
                          child: Row(
                            children: [
                              AutoSizeText(
                                "Late PAX   ",
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                              buttonSelectedStatus[4] == currentStatus
                                  ? Icon(
                                      Icons.done,
                                      color: Colors.black,
                                      size: 14,
                                    )
                                  : Container(),
                            ],
                          )),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
