import 'dart:convert';

import 'package:drinking_assistant/core/error/exception.dart';
import 'package:drinking_assistant/features/drinking_assistant/data/models/bottle_model.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

abstract class BottleRemoteDataSource {
  Future<BottleModel> authenticateBottle(int bottleCode);
}

class BottleRemoteDataSourceImpl implements BottleRemoteDataSource {
  final http.Client client;

  BottleRemoteDataSourceImpl({@required this.client});

  @override
  Future<BottleModel> authenticateBottle(int bottleCode) async {
    print('authenticateBottle $bottleCode');

//    final response = await http.get('http://192.168.100.232/drink_assistant');
//    final response = await http.post('http://192.168.100.232/drink_assistant', body: {'bottleCode': '$bottleCode'});

    final response = bottleCode == 12345
        ? http.Response(
            jsonEncode({
              "idBottle": 1,
              "bottleCode": 12345,
              "status": "Success",
              "message": "Bottle Authenticated!"
            }),
            200)
        : http.Response(
            jsonEncode({"status": "False", "message": "Wrong Bottle!"}),
            200);
    await Future.delayed(Duration(seconds: 3));

    if (response.statusCode == 200) {
      Map bodyResponse = jsonDecode(response.body);
      if (bodyResponse['status'] == 'Success') {
        return BottleModel.fromJson(jsonDecode(response.body));
      } else {
        throw BottleException(bodyResponse['message']);
      }
    } else {
      throw ServerException();
    }
  }
}
