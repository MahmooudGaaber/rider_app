import 'dart:convert';
import 'package:http/http.dart' as http ;
class HttpReq
{

  static Future<dynamic> GetReq(String url) async
  {
    http.Response response = await http.get(url);
    try
    {
      if(response.statusCode == 200){
        String JSonData =  response.body;
        var decodeData = jsonDecode(JSonData);
        return decodeData;
      }else{
        return " Failed , No response";
      }
    }
    catch(exp)
    {
      return " Failed";
    }
  }

}