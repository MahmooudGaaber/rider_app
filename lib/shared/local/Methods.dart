import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:riderapp/models/AddressModel.dart';
import 'package:riderapp/modules/map_screen/Cubit/Cubit.dart';
import 'package:riderapp/shared/remotly/http.dart';

class Methodes
{
  // AddressModel adreePickUp = AddressModel();
  static Future<String> searchcoordinatesAddress(Position position,context) async
  {
    String placeAddress = "";
    String url  = "http://maps.googleapis.com/maps/api/geocoed/json?latlang=${position.latitude},${position.longitude}&key=AIzaSyC92KujT0w69XhDlp5NFQWIiNV0gKOs398";
    var response = await HttpReq.GetReq(url);
    if(response != "failed"){
      AddressModel addressPickUp = AddressModel();
      placeAddress = response["result"][0]["formatted_address"];
      addressPickUp.placeName = placeAddress ;
      addressPickUp.longitude = position.longitude;
      addressPickUp.latitude = position.latitude;
      MapScreenCubit.get(context).UpdatePickUpLocation(addressPickUp);
    }
    return placeAddress ;
  }
}