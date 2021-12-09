import 'dart:async';

import 'package:animations/animations.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:ceo_transport/constants/constants.dart';
import 'package:ceo_transport/job_details.dart';
import 'package:ceo_transport/models/driver_details.dart';
import 'package:ceo_transport/screens/auth_screens/login.dart';
import 'package:ceo_transport/services/location_service.dart';
import 'package:ceo_transport/tools/job_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:location/location.dart' as loc;
import 'APIs/driver_api.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class HomePage extends StatefulWidget {
  final bool? alreadyLoggedIn;
  HomePage({required this.alreadyLoggedIn});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final loc.Location location = loc.Location();
  Timer? refresh_timer;
  bool _isLoading = false;
  Driver? driverData;
  List<Reservation> reservations = [];
  @override
  initState() {
    LocationService().listenLocation(location, 30, 30);
    refresh_timer =
        Timer.periodic(Duration(seconds: 120), (Timer t) => refresh_alert());
    super.initState();
    widget.alreadyLoggedIn!
        ? getDriverDetailsALreadyLoggedIn(token!)
        : getDriverDetails();
  }

  getDriverDetails() {
    driverData = driverDetails!.success!.driver!;

    reservations = driverDetails!.success!.reservations!;
  }

  getDriverDetailsALreadyLoggedIn(String token) async {
    setState(() {
      _isLoading = true;
    });
    driverDetails = await DriverApi().getUser(token);

    setState(() {
      _isLoading = false;

      driverData = driverDetails!.success!.driver!;

      reservations = driverDetails!.success!.reservations!;
    });

    print('driverDetails $driverData');
  }

  @override
  void dispose() {
    refresh_timer?.cancel();
    super.dispose();
  }

  List monthsNames = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'June',
    'July',
    'Aug',
    'Sept',
    'Oct',
    'Nov',
    'Dec'
  ];

  refresh_alert() async {
    int previous_reservation = 0;
    try {
      List<Reservation> reservations = driverDetails!.success!.reservations!;
      Map<int, Reservation> previous_reservations = Map.fromEntries(
          reservations.map((value) => MapEntry(value.reservationId!, value)));
      previous_reservation = reservations.length;
      await refresh();
      int new_reservations_len = driverDetails!.success!.reservations!.length;
      // print("refresh - > ${new_reservations}");
      bool new_found = false;
      for (Reservation new_reservation
          in driverDetails!.success!.reservations!) {
        if (previous_reservations.containsKey(new_reservation.reservationId!)) {
          new_reservation.new_reservation =
              previous_reservations[new_reservation.reservationId!]!
                  .new_reservation;
        } else {
          new_reservation.new_reservation = true;
          if (!new_found) {
            new_found = true;
          }
        }
      }
      // new_reservations != previous_reservation
      if (new_found || new_reservations_len != previous_reservation) {
        if (new_found) {
          driverDetails!.success!.reservations!.sort((a, b) {
            if (b.new_reservation) {
              return 1;
            } else {
              return -1;
            }
          });
        }
        setState(() {});
        FlutterRingtonePlayer.playNotification();
      }
    } catch (e) {
      print("Error in home_page -> refresh_alert : $e");
    }
  }

  refresh() async {
    driverDetails = await DriverApi().getUser(token!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _isLoading ? Center(child: CircularProgressIndicator()) : homeUI(),
        ],
      ),
    );
  }

  Widget homeUI() {
    String dateString = DateTime.now().toString();
    var dateparse = DateTime.parse(dateString);
    var formattedDate =
        "${monthsNames[dateparse.month - 1]}. ${dateparse.day}, ${dateparse.year}";
    print("usama -----");
    print("u $reservations");
    return SafeArea(
      child: Scaffold(
        body: RefreshIndicator(
          child: ListView(
            shrinkWrap: true,
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AutoSizeText(
                    "Good Day ${driverData!.name}",
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
                        "This is the list of jobs assigned to you today\n $formattedDate",
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        softWrap: true,
                      ),
                    ],
                  ),
                ),
              )),
              Center(
                  child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                margin: EdgeInsets.all(12),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Icon(
                        Icons.add_alert_outlined,
                        color: Colors.red,
                      ),
                      AutoSizeText(
                        "Please notify dispatch immediately if you are unable to fulfull",
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        // style: TextStyle(color: Colors.red),
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
                      onClosed: (_) {
                        print("closed $index");
                        if (reservations[index].new_reservation) {
                          reservations[index].new_reservation = false;
                        }
                      },
                      closedColor: Theme.of(context).canvasColor,
                      transitionDuration: Duration(microseconds: 500000),
                      openColor: Theme.of(context).canvasColor,
                      closedBuilder: (context, action) {
                        // print("tap usama close run");
                        return reservations[index].new_reservation
                            ? Shimmer(
                                color: Colors.white,
                                colorOpacity: 0.3,
                                enabled: true,
                                direction: ShimmerDirection.fromLTRB(),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    jobCard(
                                      jobNo: "${index + 1}",
                                      isDetail: false,
                                      hotelAddress:
                                          reservations[index].hotelAddress,
                                      resId: reservations[index].reservationId,
                                      puTime: reservations[index].pickupTime,
                                      type: reservations[index].type,
                                      duData: reservations[index].reservationDo,
                                      pax2:
                                          "${reservations[index].passengers!}",
                                      paxData:
                                          reservations[index].passengerName,
                                      paxPhone:
                                          reservations[index].passengerPhone,
                                      resNo:
                                          "${reservations[index].reservationNumber}",
                                      puDataAddress:
                                          reservations[index].hotelAddress,
                                      eadt: reservations[index].eadt,
                                      puData: reservations[index].pu,
                                      pickupTimeIso:
                                          reservations[index].pickup_time_iso,
                                    ),
                                    allNoShows.contains(index + 1)
                                        ? GlassContainer(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(24.0),
                                              child: Text(
                                                "NO SHOW",
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.red,
                                                    fontSize: 40),
                                              ),
                                            ),
                                          )
                                        : Container(),
                                    allCompletedJobs.contains(index + 1)
                                        ? GlassContainer(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            child: Icon(
                                              Icons.done,
                                              size: 150,
                                            ),
                                          )
                                        : Container(),
                                  ],
                                ),
                              )
                            : Stack(
                                alignment: Alignment.center,
                                children: [
                                  jobCard(
                                    jobNo: "${index + 1}",
                                    isDetail: false,
                                    hotelAddress:
                                        reservations[index].hotelAddress,
                                    resId: reservations[index].reservationId,
                                    puTime: reservations[index].pickupTime,
                                    type: reservations[index].type,
                                    duData: reservations[index].reservationDo,
                                    pax2: "${reservations[index].passengers!}",
                                    paxData: reservations[index].passengerName,
                                    paxPhone:
                                        reservations[index].passengerPhone,
                                    resNo:
                                        "${reservations[index].reservationNumber}",
                                    puDataAddress:
                                        reservations[index].hotelAddress,
                                    eadt: reservations[index].eadt,
                                    puData: reservations[index].pu,
                                    pickupTimeIso:
                                        reservations[index].pickup_time_iso,
                                  ),
                                  allNoShows.contains(index + 1)
                                      ? GlassContainer(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          child: Padding(
                                            padding: const EdgeInsets.all(24.0),
                                            child: Text(
                                              "NO SHOW",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.red,
                                                  fontSize: 40),
                                            ),
                                          ),
                                        )
                                      : Container(),
                                  allCompletedJobs.contains(index + 1)
                                      ? GlassContainer(
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          child: Icon(
                                            Icons.done,
                                            size: 150,
                                          ),
                                        )
                                      : Container(),
                                ],
                              );
                      },
                      openBuilder: (context, action) {
                        // print("tap usama open run");
                        return allCompletedJobs.contains(index + 1)
                            ? Center(child: Text('Job Already Completed'))
                            : JobDetails(
                                allJobDetails: reservations,
                                index: "${index + 1}",
                              );
                      });
                },
              ),
            ],
          ),
          onRefresh: () => refresh(),
        ),
        bottomSheet: Container(
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: GestureDetector(
                  onTap: () => launch("tel://14412344366"),
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
              ),
              Expanded(
                flex: 1,
                child: InkWell(
                  onTap: () =>
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  )),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
