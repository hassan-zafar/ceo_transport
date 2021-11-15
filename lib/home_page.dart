import 'package:animations/animations.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:ceo_transport/APIs/reservationAPI.dart';
import 'package:ceo_transport/constants/constants.dart';
import 'package:ceo_transport/job_details.dart';
import 'package:ceo_transport/models/driver_details.dart';
import 'package:ceo_transport/screens/auth_screens/login.dart';
import 'package:ceo_transport/tools/custom_toast.dart';
import 'package:ceo_transport/tools/job_card.dart';
import 'package:flutter/material.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';
import 'package:url_launcher/url_launcher.dart';

import 'APIs/driver_api.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
  refresh() async {
    driverDetails = await DriverApi().getUser(token!);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String dateString = DateTime.now().toString();
    var dateparse = DateTime.parse(dateString);
    var formattedDate =
        "${monthsNames[dateparse.month - 1]}. ${dateparse.day}, ${dateparse.year}";

    Driver driverData = driverDetails!.success!.driver!;
    List<Reservation> reservations = driverDetails!.success!.reservations!;

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
                      closedColor: Theme.of(context).canvasColor,
                      openColor: Theme.of(context).canvasColor,
                      closedBuilder: (context, action) => Stack(
                            alignment: Alignment.center,
                            children: [
                              jobCard(
                                jobNo: "${index + 1}",
                                isDetail: false,
                                hotelAddress: reservations[index].hotelAddress,
                                resId: reservations[index].reservationId,
                                puTime: reservations[index].pickupTime,
                                type: reservations[index].type,
                                duData: reservations[index].reservationDo,
                                pax2: "${reservations[index].passengers!}",
                                paxData: reservations[index].passengerName,
                                paxPhone: reservations[index].passengerPhone,
                                resNo:
                                    "${reservations[index].reservationNumber}",
                                puDataAddress: reservations[index].hotelAddress,
                                eadt: reservations[index].eadt,
                                puData: reservations[index].pu,
                              ),
                              allCompletedJobs.contains(index + 1)
                                  ? GlassContainer(
                                      borderRadius: BorderRadius.circular(50),
                                      child: Icon(
                                        Icons.done,
                                        size: 250,
                                      ),
                                    )
                                  : Container(),
                            ],
                          ),
                      openBuilder: (context, action) =>
                          allCompletedJobs.contains(index + 1)
                              ? Center(child: Text('Job Already Completed'))
                              : JobDetails(
                                  allJobDetails: reservations,
                                  index: "${index + 1}",
                                ));
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
