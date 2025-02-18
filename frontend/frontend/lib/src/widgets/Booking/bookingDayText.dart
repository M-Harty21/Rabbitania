import 'package:flutter/material.dart';
import 'package:frontend/src/helper/Booking/bookingHelper.dart';
import 'package:frontend/src/models/utilModel.dart';
import 'package:intl/intl.dart';

class BookingDayText extends StatefulWidget {
  final String displayText;
  final String dayOfTheWeek;
  late String bookText;

  BookingDayText(this.displayText, this.dayOfTheWeek, this.bookText);
  @override
  _BookingDayTextState createState() => _BookingDayTextState();
}

class _BookingDayTextState extends State<BookingDayText> {
  UtilModel utilModel = UtilModel();
  String dropdownValue = 'No Selection';
  String dropdownValue2 = 'No Selection';
  String selectedOffice = '';
  String selectedTimeSlot = '';
  var bookingColour = Color.fromRGBO(172, 255, 79, 1);
  String bookingText = 'Book';

  final bookingHelper = BookingHelper();

  List<String> officeLocations = [
    'No Selection',
    'Pretoria',
    'Braamfontein',
    'Amsterdam',
  ];

  List<String> timeSlots = ['No Selection', 'Full Day', 'Morning', 'Afternoon'];
  //change to use endpoint to receive days of the week availible
  int getOfficeIndex(String office) {
    int officeIndex = -1;
    if (office == 'Pretoria') {
      officeIndex = 0;
    } else if (office == 'Braamfontein') {
      officeIndex = 1;
    } else if (office == 'Amsterdam') {
      officeIndex = 2;
    }
    return officeIndex;
  }

  void getDropDownItem() {
    setState(() {
      selectedOffice = dropdownValue;
      selectedTimeSlot = dropdownValue2;
    });
  }

  Widget build(BuildContext context) => Center(
        child: Container(
          child: Column(
            children: <Widget>[
              Center(
                child: Text(
                  'Office Location: ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 30,
                    color: Color.fromRGBO(172, 255, 79, 1),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
              ),
              Center(
                child: Container(
                  width: 300,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Color.fromRGBO(172, 255, 79, 1), width: 1),
                    borderRadius: BorderRadius.circular(12),
                    color: Color.fromRGBO(33, 33, 33, 1),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      dropdownColor: Color.fromRGBO(33, 33, 33, 1),
                      value: dropdownValue,
                      icon: const Padding(
                        padding: EdgeInsets.only(right: 20),
                        child: Icon(Icons.arrow_downward,
                            color: Color.fromRGBO(171, 255, 79, 1)),
                      ),
                      iconSize: 30,
                      elevation: 8,
                      style: const TextStyle(
                        fontSize: 30,
                        color: Color.fromRGBO(172, 255, 79, 1),
                      ),
                      underline: Container(
                        height: 0,
                        color: Color.fromRGBO(33, 33, 33, 1),
                      ),
                      onChanged: (String? office) {
                        setState(() {
                          dropdownValue = office!;
                        });
                      },
                      items: officeLocations
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Padding(
                            padding: EdgeInsets.only(left: 30),
                            child: Text(value),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 25),
              ),
              Center(
                child: Text(
                  'Slot: ',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 30,
                    color: Color.fromRGBO(172, 255, 79, 1),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
              ),
              Center(
                child: Container(
                  width: 300,
                  decoration: BoxDecoration(
                    border: Border.all(
                        color: Color.fromRGBO(172, 255, 79, 1), width: 1),
                    borderRadius: BorderRadius.circular(12),
                    color: Color.fromRGBO(33, 33, 33, 1),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      dropdownColor: Color.fromRGBO(33, 33, 33, 1),
                      value: dropdownValue2,
                      icon: const Padding(
                        padding: EdgeInsets.only(right: 20),
                        child: Icon(Icons.arrow_downward,
                            color: Color.fromRGBO(171, 255, 79, 1)),
                      ),
                      iconSize: 30,
                      elevation: 8,
                      style: const TextStyle(
                        fontSize: 30,
                        color: Color.fromRGBO(172, 255, 79, 1),
                      ),
                      underline: Container(
                        height: 0,
                        color: Color.fromRGBO(33, 33, 33, 1),
                      ),
                      onChanged: (String? time) {
                        setState(() {
                          dropdownValue2 = time!;
                        });
                      },
                      items: timeSlots
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Padding(
                            padding: EdgeInsets.only(left: 30),
                            child: Text(value),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 15),
                child: SizedBox(
                  width: 300,
                  height: 60,
                  child: ElevatedButton(
                    key: Key('BookingButton'),
                    style: ButtonStyle(
                      elevation: MaterialStateProperty.all(0),
                      backgroundColor: MaterialStateProperty.all(
                        bookingColour,
                      ),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                          side: BorderSide(
                            style: BorderStyle.none,
                          ),
                        ),
                      ),
                    ),
                    child: Text(
                      bookingText,
                      style: TextStyle(
                        fontSize: 30,
                        color: Color.fromRGBO(33, 33, 33, 1),
                      ),
                    ),
                    onPressed: () {
                      int office = this.getOfficeIndex(this.dropdownValue);

                      DateTime date = DateTime.now();
                      //convert date variable to string using format
                      String formattedDate =
                          DateFormat('yyyy-MM-dd – kk:mm').format(date);
                      // Checks for Full Day value
                      String timeSlot;
                      if (dropdownValue2 == "Full Day") {
                        timeSlot = widget.dayOfTheWeek + ",Whole";
                      } else {
                        timeSlot =
                            widget.dayOfTheWeek + "," + this.dropdownValue2;
                      }
                      bookingHelper
                          .confirmNoPriorBookings(
                              timeslot: timeSlot, office: office)
                          .then((value) {
                        if (value) {
                          //use setState to change the value of Widget body member on press
                          bookingHelper
                              .checkAndMakeBooking(
                                  timeslot: timeSlot,
                                  office: office,
                                  bookingDate: formattedDate)
                              .then((value) {
                            if (value == "Created new Booking") {
                              return showDialog<void>(
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    elevation: 5,
                                    backgroundColor:
                                        Color.fromRGBO(33, 33, 33, 1),
                                    titleTextStyle: TextStyle(
                                        color: Colors.white, fontSize: 25),
                                    title: Text("Create Booking for " +
                                        widget.dayOfTheWeek),
                                    contentTextStyle: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                    content: Text("Booking for slot " +
                                        this.dropdownValue2 +
                                        " @ " +
                                        this.dropdownValue +
                                        " successfully created!"),
                                    actions: [
                                      IconButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(false),
                                        icon: Icon(
                                          Icons.close,
                                          color: Colors.red,
                                        ),
                                      ),
                                    ],
                                  );
                                },
                                context: context,
                              );
                            } else {
                              return showDialog<void>(
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    elevation: 5,
                                    backgroundColor:
                                        Color.fromRGBO(33, 33, 33, 1),
                                    titleTextStyle: TextStyle(
                                        color: Colors.white, fontSize: 25),
                                    title: Text("No Booking Availible"),
                                    contentTextStyle: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                    content: Text(
                                        "There are no booking slots currently availible. Please try again later."),
                                    actions: [
                                      IconButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(false),
                                        icon: Icon(Icons.close,
                                            color: Colors.red),
                                      ),
                                    ],
                                  );
                                },
                                context: context,
                              );
                            }
                          });
                        } else {
                          return showDialog<void>(
                            builder: (BuildContext context) {
                              return AlertDialog(
                                elevation: 5,
                                backgroundColor: Color.fromRGBO(33, 33, 33, 1),
                                titleTextStyle: TextStyle(
                                    color: Colors.white, fontSize: 25),
                                title: Text("Issue with Booking"),
                                contentTextStyle: TextStyle(
                                    color: Colors.white, fontSize: 20),
                                content: Text(
                                    "You have already booked for this slot for the week!"),
                                actions: [
                                  IconButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(false),
                                    icon: Icon(Icons.close, color: Colors.red),
                                  ),
                                ],
                              );
                            },
                            context: context,
                          );
                        }
                      });
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
