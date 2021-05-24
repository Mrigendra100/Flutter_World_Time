import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {

  String location;     //location name for the UI
  String time ;  // Time in that Location

  String flag; // URL to an asset for flags

  String url; // location url for api end points
  bool isDaytime; // True or False


  WorldTime({this.location , this.flag , this.url});



  Future<void> getData() async{

     try {
       Response response = await get(
           'http://worldtimeapi.org/api/timezone/$url');
       Map data = jsonDecode(response.body);
       print(data);
       // print(data['datetime']);

       //  get properties from data
       String datetime = data['utc_datetime'];
       String offset = data['utc_offset'].substring(1, 3);
       // print(datetime);
       // print(offset);

       // create Date Time Object

       DateTime now = DateTime.parse(datetime);
       now = now.add(Duration(hours: int.parse(offset)));
       // print(now);

       // set Time property
       isDaytime = ( now.hour > 6 && now.hour < 20  )? true : false ;
       time = DateFormat.jm().format(now);
       print('Time Now $time');
     }

     catch (e) {

       print('Error :  $e');
       time = 'Could not get time data';
     }

  }

}

