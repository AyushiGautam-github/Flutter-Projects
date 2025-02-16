import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


final firestore=FirebaseFirestore.instance;
User? loggedinuser;
final _auth=FirebaseAuth.instance;

class PlaceRequestPage extends StatefulWidget {
  @override
  _PlaceRequestPageState createState() => _PlaceRequestPageState();
}

class _PlaceRequestPageState extends State<PlaceRequestPage> {

  String? pickupinfo;
  String? deliveryloc;
  String? deliveryinfo;
  String? time;
  String? itemsize;
  String? amount;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getcurretuser();

  }

  void getcurretuser() async{
    try{
      final user=await _auth.currentUser;
      if(user!=null){ loggedinuser=user;}
    }catch(e){print(e);}
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Grabie Friend Forever...", style: TextStyle(color: Colors.white),),
          backgroundColor: Color(0xFFBF592B),
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(children: [
              Padding(
                padding: EdgeInsets.all(20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      'lib/images/logo.png', // Replace with your logo asset path
                      height: 60, // Adjust the height of the logo
                    ),
                    SizedBox(
                        width:
                        10), // Add some spacing between the logo and title
                    Text(
                      'Place a Request',
                      style:
                      TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
              Stack(clipBehavior: Clip.none, children: [
                Container(
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Color(0xFFBF592B),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          "Enter Details",
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),

                      // Pickup Location
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          'Pickup Location',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      TextField(
                        readOnly: true,
                        decoration: InputDecoration(
                          hintText: "Main Gate",
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),

                      // Preferred Pickup Time
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          'Preferred Pickup Time',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: 8),

                      // Combined Dropdown (Hour:Minute AM/PM)
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        value: time,
                        items: _generateTimeOptions(),
                        onChanged: (value) {
                          setState(() {
                            time = value;
                          });
                        },
                      ),
                      SizedBox(height: 10),

                      // Pickup Location
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          'Counter Number',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      TextField(
                        keyboardType: TextInputType.number,
                        //keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            pickupinfo = value;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: "type Counter Number...",
                          hintStyle: TextStyle(color: Color(0xFFBF592B).withOpacity(0.5)),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),


                      // Drop-off Location
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          'Select Delivery Location',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        items: [
                          'A Block',
                          'B Block',
                          'C Block',
                          'D-1 Block',
                          'D-2 Block',
                        ]
                            .map((location) => DropdownMenuItem(
                          value: location,
                          child: Text(location),
                        ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            deliveryloc = value;
                          });
                        },
                      ),
                      SizedBox(height: 10),

                      // Delivery Location- Room No.
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          'Additional Info (Delivery)',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      TextField(
                        //keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            deliveryinfo = value;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: "Such as Room number...",
                          hintStyle: TextStyle(color: Color(0xFFBF592B).withOpacity(0.5)),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),

                      // Item Details
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          'Select Item Size',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        items: [
                          'Small',
                          'Medium',
                          'Large',
                        ]
                            .map((size) => DropdownMenuItem(
                          value: size,
                          child: Text(size),
                        ))
                            .toList(),
                        onChanged: (value) {
                          itemsize=value;
                        },
                      ),
                      SizedBox(height: 20),

                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(
                          'Amount to pay',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(height: 8),
                      TextField(
                        keyboardType: TextInputType.number,
                        onChanged: (value) {
                          setState(() {
                            amount = value;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: "Type amount in INR...",
                          hintStyle: TextStyle(color: Color(0xFFBF592B).withOpacity(0.5)),
                          filled: true,
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),



                      SizedBox(height: 40),
                    ],
                  ),
                ),
                Positioned(
                  bottom: -30, // Adjusted value for overlap
                  left: 0,
                  right: 0,
                  child: Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Submit logic here
                        firestore.collection('request').add({
                          'amount': amount,
                          'itemsize': itemsize,
                          'deliveryinfo': deliveryinfo,
                          'deliveryloc': deliveryloc,
                          'itemsize': itemsize,
                          'pickupinfo': pickupinfo,
                          'time': time,
                          'user': loggedinuser?.email,
                          'contact': loggedinuser?.phoneNumber,
                        });
                        Navigator.pushNamed(context, 'service_request');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFFFE854F),
                        padding: EdgeInsets.symmetric(
                          horizontal: 100,
                          vertical: 20,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: Text(
                        "Submit Request",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ]),

              SizedBox(height: 30),
              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Go Back",
                    style: TextStyle(
                      color: Color(0xFFBF592B),
                      fontWeight: FontWeight.w900,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ));
  }
}




// Method to generate time options in HH:MM AM/PM format and restrict times from 9 PM to 8 AM
List<DropdownMenuItem<String>> _generateTimeOptions() {
  List<String> timeOptions = [];
  List<String> hours = List.generate(12, (index) => (index + 1).toString());
  List<String> minutes = ['00', '30'];
  List<String> amPm = ['AM', 'PM'];

  // First add all AM options
  for (var hour in hours) {
    for (var minute in minutes) {
      String time = '$hour:$minute AM';

      // Filter out times between 9 PM and 8 AM (8 AM is included)
      if (hour == '9' || hour == '10' || hour == '11' || hour == '12') {
        timeOptions.add(time); // Add AM times from 9 AM onwards
      }
    }
  }

  // Then add all PM options
  for (var hour in hours) {
    for (var minute in minutes) {
      String time = '$hour:$minute PM';

      // Allow PM times from 1 PM to 8 PM
      if (hour == '1' || hour == '2' || hour == '3' || hour == '4' ||
          hour == '5' || hour == '6' || hour == '7' || hour == '8') {
        timeOptions.add(time); // Add PM times from 1 PM to 8 PM
      }
    }
  }

  return timeOptions.map((time) => DropdownMenuItem<String>(
    value: time,
    child: Text(time),
  )).toList();
}
