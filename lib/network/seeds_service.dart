import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:seeds_system/network/seeds_api_model.dart';

class SeedApiService {
  static Future<void> postSeeds(
      String id,
      String name,
      String manufacturer,
      String manufacturedAt,
      String expiresIn,
      String createdAt,
      String userId) async {
    var url = Uri.parse(
        'https://learning-data-sync-mobile.herokuapp.com/datasync/api/seed');

    try {
      final response = await http.post(url,
          body: json.encode({
            "id": id,
            "name": name,
            "manufacturer": manufacturer,
            "manufacturedAt": manufacturedAt,
            "expiresIn": expiresIn,
            "createdAt": createdAt,
            "userId": userId
          }),
          headers: {
            "content-type": "application/json",
            "accept": "application/json",
          });

      var code = response.statusCode;
      if (code == 500) {
        //Todo: handling error
      }
    } catch (error) {
      rethrow;
    }
  }

  static Future<List<SeedsApiModel>> getRemoteSeeds(String userId) async {
    var url = Uri.parse(
        'https://learning-data-sync-mobile.herokuapp.com/datasync/api/seed/$userId');

    try {
      final response = await http.get(url);
      final list = json.decode(response.body);
      final fetchedApiSeeds = List.generate(
          list.length, (index) => SeedsApiModel.fromJson(list[index]));
      var code = response.statusCode;
      return fetchedApiSeeds;

      /*if (code == 404) {
      throw UserNotFound();
    } else if (code == 500) {
      
    }*/
    } catch (error) {
      rethrow;
    }
  }
}
