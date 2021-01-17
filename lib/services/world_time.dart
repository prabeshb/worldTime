import 'dart:convert';

import 'package:http/http.dart';
import 'package:intl/intl.dart';

class WorldTime {
  String location;
  String time;
  String flag; //url to an asset flag icon
  String url; //location url for API endpoint
  String bgImageBasedOnTime; //set background image based on the time of day

  WorldTime({this.location, this.flag, this.url});

  Future<void> getTime() async {
    try {
      Response response =
          await get('http://worldtimeapi.org/api/timezone/$url');
      Map data = jsonDecode(response.body);

      String datetime = data['datetime'];
      String offset = data['utc_offset'].substring(0, 3);

      DateTime now = DateTime.parse(datetime);
      now = now.add(Duration(hours: int.parse(offset)));

      // isDayTime = now.hour > 6 && now.hour < 20 ? true : false;
      int temp = now.hour;
      print('Time hour is : $temp');
      if (now.hour >= 1 && now.hour < 12) {
        bgImageBasedOnTime = "day.jpg";
      } else if (now.hour >= 12 && now.hour < 16) {
        bgImageBasedOnTime = "afternoon.jpg";
      } else if (now.hour >= 16 && now.hour < 21) {
        bgImageBasedOnTime = "evening.jpg";
      } else if (now.hour >= 21 && now.hour <= 24) {
        bgImageBasedOnTime = "night.jpg";
      }

      //set the time property
      time = DateFormat.jm().format(now);
    } catch (e) {
      print('caught error: $e');
      time = 'Could not get time data';
    }
  }
}
