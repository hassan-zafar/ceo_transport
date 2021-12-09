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
  final int? resId;
  final String? paxData;
  final String? puData;
  final String? eadt;
  final String? duData;
  final String? paxPhone;
  final String? pax2;
  final String? hotelAddress;
  final bool? isDetail;
  final String? type;
  final String? pickupTimeIso;
  final String? puDataAddress;
  const jobCard(
      {this.jobNo,
      this.puTime,
      this.resId,
      this.duData,
      this.paxData,
      this.paxPhone,
      this.isDetail,
      this.puDataAddress,
      this.pickupTimeIso,
      this.pax2,
      this.puData,
      this.type,
      this.eadt,
      this.hotelAddress,
      this.resNo});

  @override
  State<jobCard> createState() => _jobCardState();
}

class _jobCardState extends State<jobCard> {
  bool _isLoading = false;
  String? currentStatus = 'Not Assigned';
  DateTime? pickupTIme;
  bool _containerExpanded = false;
  @override
  void initState() {
    super.initState();
    waitTimeController = TextEditingController(text: ".00");
    addStopsController = TextEditingController(text: ".00");
    tollsController = TextEditingController(text: ".00");
    msCleanUpController = TextEditingController(text: ".00");
    vehileDamageController = TextEditingController(text: ".00");
    gratitudesController = TextEditingController(text: ".00");
    othersController = TextEditingController(text: ".00");
    taxController = TextEditingController(text: ".00");
    pickupTIme =
        DateTime.parse(widget.pickupTimeIso ?? "0000-00-00 00:00:00.000");
  }

  TextEditingController waitTimeController = TextEditingController();
  TextEditingController addStopsController = TextEditingController();
  TextEditingController tollsController = TextEditingController();
  TextEditingController msCleanUpController = TextEditingController();
  TextEditingController vehileDamageController = TextEditingController();
  TextEditingController gratitudesController = TextEditingController();
  TextEditingController othersController = TextEditingController();
  TextEditingController taxController = TextEditingController();
  // final _textFormKey = GlobalKey<FormState>();
  double? totalAmount = 0;
  calculateTotal() {
    setState(() {
      totalAmount = double.parse(waitTimeController.text) +
          double.parse(addStopsController.text) +
          double.parse(tollsController.text) +
          double.parse(msCleanUpController.text) +
          double.parse(vehileDamageController.text) +
          double.parse(gratitudesController.text) +
          double.parse(taxController.text) +
          double.parse(othersController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Card(
            color: DateTime.now().difference(pickupTIme!).inMinutes < 15
                ? Colors.white10
                : Colors.black,
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
                        topRight: Radius.circular(20),
                      ),
                    ),
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
                    trailing: AutoSizeText(
                      "#PAX ${widget.pax2}",
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
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
                    isThreeLine: true,
                    // trailing: SizedBox(
                    //     // width: 50,
                    //     child: AutoSizeText('EAT/EDT:\n${widget.eadt!}')),
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
                                Text(currentStatus == buttonSelectedStatus[6]
                                    ? 'add. charges'
                                    : currentStatus!)
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
                                              reservationNo: widget.resId,
                                              token: token!,
                                              type: "en_route")
                                          .then((passed) {
                                        if (passed) {
                                          // CustomToast.successToast(
                                          //     message: "Status Set: En_Route");
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
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          AutoSizeText(
                                            "En Route",
                                            textAlign: TextAlign.center,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1,
                                          ),
                                          buttonSelectedStatus[0] ==
                                                  currentStatus
                                              ? Icon(
                                                  Icons.done,
                                                  color: Colors.black,
                                                  size: 25,
                                                )
                                              : Container(),
                                        ],
                                      ),
                                    ),
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
                                              reservationNo: widget.resId,
                                              token: token!,
                                              type: "on_location")
                                          .then((passed) {
                                        if (passed) {
                                          // CustomToast.successToast(
                                          //     message: "Status Set: On Location");
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          AutoSizeText(
                                            "On Locale",
                                            textAlign: TextAlign.center,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1,
                                          ),
                                          buttonSelectedStatus[1] ==
                                                  currentStatus
                                              ? Icon(
                                                  Icons.done,
                                                  color: Colors.black,
                                                  size: 25,
                                                )
                                              : Container(),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
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
                                              reservationNo: widget.resId,
                                              token: token!,
                                              type: "no_show")
                                          .then((passed) {
                                        if (passed) {
                                          // CustomToast.successToast(
                                          //     message: "Status Set: No Show");
                                          Navigator.pop(context);
                                        } else {
                                          CustomToast.errorToast(
                                              message: "Couldn't set");
                                        }
                                      });
                                      setState(() {
                                        _isLoading = false;
                                        allNoShows
                                            .add(int.parse(widget.jobNo!));
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
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                                  size: 25,
                                                  color: Colors.black,
                                                )
                                              : Container(),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _isLoading = true;
                                });
                                ReservationAPI()
                                    .setStatus(
                                        reservationNo: widget.resId,
                                        token: token!,
                                        type: "invehicle")
                                    .then((passed) {
                                  if (passed) {
                                    // CustomToast.successToast(
                                    //     message: "Status Set: In Vehicle");
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
                                    mainAxisAlignment: MainAxisAlignment.center,
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
                                              size: 25,
                                            )
                                          : Container(),
                                    ],
                                  )),
                            ),
                            InkWell(
                              onTap: () {
                                setState(() {
                                  _containerExpanded = !_containerExpanded;
                                });
                              },
                              child: AnimatedContainer(
                                  duration: Duration(milliseconds: 1000),
                                  curve: Curves.easeIn,
                                  margin: EdgeInsets.all(8),
                                  width: double.maxFinite,
                                  padding: EdgeInsets.all(
                                      _containerExpanded ? 0 : 12),
                                  decoration: BoxDecoration(
                                      color: _containerExpanded
                                          ? Colors.black12
                                          : Colors.blue,
                                      borderRadius: BorderRadius.circular(
                                          _containerExpanded ? 20 : 12)),
                                  child: _containerExpanded
                                      ? Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Column(
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.black,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(20),
                                                    topRight:
                                                        Radius.circular(20),
                                                  ),
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      AutoSizeText(
                                                        "Miscl. Charges",
                                                        textAlign:
                                                            TextAlign.center,
                                                        // style: Theme.of(context)
                                                        //     .textTheme
                                                        //     .headline1,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: AutoSizeText(
                                                      "Wait Time:",
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: TextField(
                                                      controller:
                                                          waitTimeController,
                                                      textAlign:
                                                          TextAlign.right,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      onChanged: (value) =>
                                                          calculateTotal(),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                      child: AutoSizeText(
                                                    "Add. Stops:",
                                                    textAlign: TextAlign.center,
                                                  )),
                                                  Expanded(
                                                    child: TextField(
                                                      controller:
                                                          addStopsController,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      textAlign:
                                                          TextAlign.right,
                                                      onChanged: (value) =>
                                                          calculateTotal(),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: AutoSizeText(
                                                      "Tolls:",
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: TextField(
                                                      controller:
                                                          tollsController,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      textAlign:
                                                          TextAlign.right,
                                                      onChanged: (value) =>
                                                          calculateTotal(),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: AutoSizeText(
                                                      "MS Clean Up:",
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: TextField(
                                                      controller:
                                                          msCleanUpController,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      textAlign:
                                                          TextAlign.right,
                                                      onChanged: (value) =>
                                                          calculateTotal(),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: AutoSizeText(
                                                      "Veh. Damage:",
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: TextField(
                                                      controller:
                                                          vehileDamageController,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      textAlign:
                                                          TextAlign.right,
                                                      onChanged: (value) =>
                                                          calculateTotal(),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Expanded(
                                                    child: AutoSizeText(
                                                      "Gratituties:",
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: TextField(
                                                      controller:
                                                          gratitudesController,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      textAlign:
                                                          TextAlign.right,
                                                      onChanged: (value) =>
                                                          calculateTotal(),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Expanded(
                                                      child: AutoSizeText(
                                                        "Tax:",
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: TextField(
                                                        controller:
                                                            taxController,
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        textAlign:
                                                            TextAlign.right,
                                                        onChanged: (value) =>
                                                            calculateTotal(),
                                                      ),
                                                    ),
                                                  ]),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Row(
                                                  children: [
                                                    Expanded(
                                                        child: AutoSizeText(
                                                      "TOTAL:",
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      textAlign:
                                                          TextAlign.center,
                                                    )),
                                                    Expanded(
                                                      child: AutoSizeText(
                                                        totalAmount!
                                                            .toStringAsFixed(2),
                                                        style: TextStyle(
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              ElevatedButton(
                                                onPressed: () async {
                                                  setState(() {
                                                    _isLoading = true;
                                                  });
                                                  await ReservationAPI().additionalChargesAPi(
                                                      reservationId:
                                                          widget.resId!,
                                                      wait_time:
                                                          waitTimeController
                                                              .text,
                                                      add_stop:
                                                          addStopsController
                                                              .text,
                                                      clean_up:
                                                          msCleanUpController
                                                              .text,
                                                      damage:
                                                          vehileDamageController
                                                              .text,
                                                      gratuity:
                                                          gratitudesController
                                                              .text,
                                                      tax: taxController.text,
                                                      tolls:
                                                          tollsController.text,
                                                      others: othersController
                                                          .text);
                                                  setState(() {
                                                    _containerExpanded =
                                                        !_containerExpanded;
                                                    _isLoading = false;
                                                    currentStatus =
                                                        buttonSelectedStatus[6];
                                                  });
                                                },
                                                child: AutoSizeText(
                                                  'Submit',
                                                  softWrap: true,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .subtitle1,
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            AutoSizeText(
                                              "Additional Charges",
                                              textAlign: TextAlign.center,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1,
                                            ),
                                            buttonSelectedStatus[6] ==
                                                    currentStatus
                                                ? Icon(
                                                    Icons.done,
                                                    size: 25,
                                                    color: Colors.black,
                                                  )
                                                : Container()
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
                                        reservationNo: widget.resId,
                                        token: token!,
                                        type: "done")
                                    .then((passed) {
                                  if (passed) {
                                    // CustomToast.successToast(
                                    //     message: "Status: Drop Off Complete");
                                    Navigator.of(context).pop();
                                  } else {
                                    CustomToast.errorToast(
                                        message: "Couldn't set");
                                  }
                                });
                                setState(() {
                                  _isLoading = false;
                                  allCompletedJobs
                                      .add(int.parse(widget.jobNo!));
                                  allNoShows.remove(int.parse(widget.jobNo!));
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
                                      buttonSelectedStatus[7] == currentStatus
                                          ? Icon(
                                              Icons.done,
                                              color: Colors.black,
                                              size: 25,
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
                                reservationNo: widget.resId,
                                token: token!,
                                type: "wait_time")
                            .then((passed) {
                          if (passed) {
                            // CustomToast.successToast(
                            //     message: "Status Set: Late Driver");
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
                                      size: 25,
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
                                reservationNo: widget.resId,
                                token: token!,
                                type: "wait_time_passenger")
                            .then((passed) {
                          if (passed) {
                            // CustomToast.successToast(
                            // message: "Status Set: Late Passenger");
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
                                      size: 25,
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
